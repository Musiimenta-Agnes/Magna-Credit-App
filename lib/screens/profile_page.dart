import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:magna_credit_app/api_service.dart';
import 'returning_loan_application.dart';
import 'settings_page.dart';
import 'login_screen.dart';
import 'notifications_page.dart';
import 'home_screen.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as p;

// ─── Theme Colors ───────────────────────────────────────────────
const Color kBlue  = Color(0xFF0076D6);
const Color kGreen = Color(0xFF00CB5E);
const Color kBg    = Color(0xFFF4F8FF);

// ─── Global money formatter ─────────────────────────────────────
String fmtUGX(dynamic v) {
  if (v == null) return '0';
  final d = double.tryParse(v.toString()) ?? 0.0;
  final n = d.toInt();
  final str = n.toString();
  final buffer = StringBuffer();
  for (int i = 0; i < str.length; i++) {
    if (i > 0 && (str.length - i) % 3 == 0) buffer.write(',');
    buffer.write(str[i]);
  }
  return buffer.toString();
}

// ════════════════════════════════════════════════════════════════
//  ProfilePage  –  4-tab client dashboard
// ════════════════════════════════════════════════════════════════
class ProfilePage extends StatefulWidget {
  final int initialTab;
  const ProfilePage({super.key, this.initialTab = 0});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 4, vsync: this, initialIndex: widget.initialTab);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0A0F1E) : kBg,
      // ── AppBar with back button ──
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF0A0F1E) : kBlue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Colors.white, size: 20),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HomePage()),
              );
            }
          },
          tooltip: 'Back to Home',
        ),
        title: const Text(
          'My Account',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(
            height: 2,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [kBlue, kGreen]),
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _DashboardTab(isDark: isDark),
          _LoansTab(isDark: isDark),
          _RepaymentsTab(isDark: isDark),
          _ProfileTab(isDark: isDark),
        ],
      ),
      bottomNavigationBar: Material(
        color: isDark ? const Color(0xFF0A0F1E) : Colors.white,
        elevation: 8,
        child: TabBar(
          controller: _tabController,
          indicatorColor: kBlue,
          indicatorWeight: 3,
          labelColor: kBlue,
          unselectedLabelColor: Colors.grey,
          labelStyle:
              const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
          tabs: const [
            Tab(
                icon: Icon(Icons.dashboard_rounded, size: 20),
                text: 'Overview'),
            Tab(
                icon: Icon(Icons.receipt_long_rounded, size: 20),
                text: 'My Loans'),
            Tab(
                icon: Icon(Icons.payments_rounded, size: 20),
                text: 'Repayments'),
            Tab(
                icon: Icon(Icons.person_rounded, size: 20),
                text: 'Profile'),
          ],
        ),
      ),
    );
  }
}






// ════════════════════════════════════════════════════════════════
//  TAB 1 — OVERVIEW DASHBOARD
// ════════════════════════════════════════════════════════════════
class _DashboardTab extends StatefulWidget {
  final bool isDark;
  const _DashboardTab({required this.isDark});
  @override
  State<_DashboardTab> createState() => _DashboardTabState();
}

class _DashboardTabState extends State<_DashboardTab> {
  bool isLoading = true;
  Map<String, dynamic>? dashboardData;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final data = await ApiService.getDashboard();
      setState(() {
        dashboardData = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator(color: kBlue));
    }

    if (dashboardData == null || dashboardData!['user'] == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                      color: kBlue.withValues(alpha: 0.08),
                      shape: BoxShape.circle),
                  child: const Icon(Icons.person_outline_rounded,
                      size: 64, color: kBlue),
                ),
                const SizedBox(height: 20),
                const Text('Not logged in',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: kBlue)),
                const SizedBox(height: 8),
                Text(
                  'Please log in to view your dashboard, loans, and repayments.',
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ]),
        ),
      );
    }

    final summary = dashboardData!['summary'] ?? {};
    final user = dashboardData!['user'] ?? {};
    final recentLoans =
        (dashboardData!['recent_loans'] as List?) ?? [];
    final recentRepayments =
        (dashboardData!['recent_repayments'] as List?) ?? [];

    return RefreshIndicator(
      onRefresh: _load,
      color: kBlue,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Welcome banner with notification bell ──
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(20, 20, 60, 20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [kBlue, Color(0xFF0056A8)]),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: kBlue.withValues(alpha: 0.3),
                            blurRadius: 16,
                            offset: const Offset(0, 6))
                      ],
                    ),
                    child: Row(children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.white.withValues(alpha: 0.2),
                        child: Text(
                            (user['name'] ?? 'U')[0].toUpperCase(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w700)),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Text('Welcome back,',
                                style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.8),
                                    fontSize: 13)),
                            Text(user['name'] ?? '',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700)),
                            Text(user['phone'] ?? '',
                                style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.7),
                                    fontSize: 12)),
                          ])),
                    ]),
                  ),
                  // ── Notification bell pinned top-right inside banner ──
                  Positioned(
                    top: 10,
                    right: 10,
                    child: _NotificationBell(),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              _sectionTitle('Financial Summary'),
              const SizedBox(height: 10),
              Row(children: [
                Expanded(
                    child: _SummaryCard(
                        label: 'Total Borrowed',
                        value:
                            'UGX ${_fmt(summary['total_borrowed'])}',
                        icon: Icons.account_balance_rounded,
                        color: kBlue,
                        isDark: widget.isDark)),
                const SizedBox(width: 12),
                Expanded(
                    child: _SummaryCard(
                        label: 'Total Repaid',
                        value: 'UGX ${_fmt(summary['total_repaid'])}',
                        icon: Icons.check_circle_rounded,
                        color: kGreen,
                        isDark: widget.isDark)),
              ]),
              const SizedBox(height: 12),
              _SummaryCard(
                  label: 'Outstanding Balance',
                  value: 'UGX ${_fmt(summary['total_balance'])}',
                  icon: Icons.account_balance_wallet_rounded,
                  color: (summary['total_balance'] ?? 0) > 0
                      ? Colors.orange
                      : kGreen,
                  isDark: widget.isDark,
                  wide: true),

              const SizedBox(height: 20),
              _sectionTitle('Loan Status Overview'),
              const SizedBox(height: 10),
              Wrap(spacing: 10, runSpacing: 10, children: [
                _StatusPill(
                    label: 'Pending',
                    count: summary['pending'] ?? 0,
                    color: Colors.orange),
                _StatusPill(
                    label: 'Approved',
                    count: summary['approved'] ?? 0,
                    color: kGreen),
                _StatusPill(
                    label: 'Disbursed',
                    count: summary['disbursed'] ?? 0,
                    color: kBlue),
                _StatusPill(
                    label: 'Repaying',
                    count: summary['repaying'] ?? 0,
                    color: Colors.purple),
                _StatusPill(
                    label: 'Completed',
                    count: summary['completed'] ?? 0,
                    color: Colors.teal),
                _StatusPill(
                    label: 'Rejected',
                    count: summary['rejected'] ?? 0,
                    color: Colors.red),
              ]),

              if (recentLoans.isNotEmpty) ...[
                const SizedBox(height: 20),
                _sectionTitle('Recent Applications'),
                const SizedBox(height: 10),
                ...recentLoans.map((l) => _LoanCard(
                    loan: l, isDark: widget.isDark, compact: true)),
              ],
              if (recentRepayments.isNotEmpty) ...[
                const SizedBox(height: 20),
                _sectionTitle('Recent Repayments'),
                const SizedBox(height: 10),
                ...recentRepayments.map((r) => _RepaymentCard(
                    repayment: r, isDark: widget.isDark)),
              ],

              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            const ReturningClientLoanPage())),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [kGreen, Color(0xFF00A84E)]),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                          color: kGreen.withValues(alpha: 0.3),
                          blurRadius: 16,
                          offset: const Offset(0, 6))
                    ],
                  ),
                  child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_circle_rounded,
                            color: Colors.white),
                        SizedBox(width: 10),
                        Text('Apply for a New Loan',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700)),
                      ]),
                ),
              ),
            ]),
      ),
    );
  }

  Widget _sectionTitle(String t) => Text(t,
      style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: kBlue));

  String _fmt(dynamic v) => fmtUGX(v);
}










// ════════════════════════════════════════════════════════════════
//  TAB 2 — MY LOANS
// ════════════════════════════════════════════════════════════════
class _LoansTab extends StatefulWidget {
  final bool isDark;
  const _LoansTab({required this.isDark});
  @override
  State<_LoansTab> createState() => _LoansTabState();
}

class _LoansTabState extends State<_LoansTab> {
  bool isLoading = true;
  List loans = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final data = await ApiService.getLoanApplications();
      setState(() {
        loans = data['data'] ?? [];
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator(color: kBlue));
    }

    return RefreshIndicator(
      onRefresh: _load,
      color: kBlue,
      child: loans.isEmpty
          ? const Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Icon(Icons.receipt_long_outlined,
                    size: 64, color: Colors.grey),
                SizedBox(height: 12),
                Text('No loan applications yet',
                    style: TextStyle(color: Colors.grey)),
              ]))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: loans.length,
              itemBuilder: (_, i) => _LoanCard(
                    loan: loans[i],
                    isDark: widget.isDark,
                    onEdit: loans[i]['can_edit'] == true
                        ? () => _editLoan(loans[i])
                        : null,
                    onViewRepayments: () => _viewRepayments(loans[i]),
                  )),
    );
  }

  void _editLoan(Map loan) {
    Navigator.push(context,
            MaterialPageRoute(builder: (_) => _EditLoanPage(loan: loan)))
        .then((_) => _load());
  }

  void _viewRepayments(Map loan) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => _LoanRepaymentsPage(loan: loan)));
  }
}

// ════════════════════════════════════════════════════════════════
//  TAB 3 — REPAYMENTS
// ════════════════════════════════════════════════════════════════
class _RepaymentsTab extends StatefulWidget {
  final bool isDark;
  const _RepaymentsTab({required this.isDark});
  @override
  State<_RepaymentsTab> createState() => _RepaymentsTabState();
}

class _RepaymentsTabState extends State<_RepaymentsTab> {
  bool isLoading = true;
  List repayments = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final data = await ApiService.getRepayments();
      setState(() {
        repayments = data['data'] ?? [];
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator(color: kBlue));
    }

    return RefreshIndicator(
      onRefresh: _load,
      color: kBlue,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── How to Pay header ──
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [kBlue, Color(0xFF0056A8)]),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: kBlue.withValues(alpha: 0.3),
                      blurRadius: 16,
                      offset: const Offset(0, 6))
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Icon(Icons.info_outline_rounded,
                        color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Text('How to Pay',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700)),
                  ]),
                  SizedBox(height: 8),
                  Text(
                    'Make your repayment using any of the options below, then contact us with your transaction reference to confirm.',
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                        height: 1.5),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ── Mobile Money ──
            _PaymentCard(
              isDark: widget.isDark,
              title: 'Mobile Money',
              icon: Icons.phone_android_rounded,
              color: const Color(0xFFFFAA00),
              iconBg: const Color(0xFFFFF3DC),
              details: const [
                _PaymentDetail(
                    label: 'MTN Mobile Money', value: '0770 656 698'),
                _PaymentDetail(
                    label: 'Airtel Money', value: '0742 443 850'),
                _PaymentDetail(
                    label: 'Account Name',
                    value: 'Magna Credit Limited'),
              ],
            ),

            const SizedBox(height: 12),

            // ── Bank Transfer ──
            _PaymentCard(
              isDark: widget.isDark,
              title: 'Bank Transfer',
              icon: Icons.account_balance_rounded,
              color: kBlue,
              iconBg: const Color(0xFFE8F0FF),
              details: const [
                _PaymentDetail(
                    label: 'Bank Name',
                    value: 'Stanbic Bank Uganda'),
                _PaymentDetail(
                    label: 'Account Number', value: '9030012345678'),
                _PaymentDetail(
                    label: 'Account Name',
                    value: 'Magna Credit Limited'),
                _PaymentDetail(
                    label: 'Branch', value: 'Kampala Main Branch'),
              ],
            ),

            const SizedBox(height: 12),

            // ── Notice ──
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14),
                border:
                    Border.all(color: Colors.orange.withValues(alpha: 0.3)),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.warning_amber_rounded,
                      color: Colors.orange, size: 20),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'After making payment, please contact us with your transaction reference so we can update your account.',
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 12,
                          height: 1.5),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ── Repayment History ──
            const Row(children: [
              Icon(Icons.history_rounded, color: kBlue, size: 18),
              SizedBox(width: 8),
              Text('Repayment History',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: kBlue)),
            ]),

            const SizedBox(height: 12),

            repayments.isEmpty
                ? Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(vertical: 40),
                    decoration: BoxDecoration(
                      color: widget.isDark
                          ? const Color(0xFF111827)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                          color: kBlue.withValues(alpha: 0.1)),
                    ),
                    child: const Column(children: [
                      Icon(Icons.payments_outlined,
                          size: 48, color: Colors.grey),
                      SizedBox(height: 10),
                      Text('No repayments recorded yet',
                          style: TextStyle(
                              color: Colors.grey, fontSize: 13)),
                    ]),
                  )
                : Column(
                    children: repayments
                        .map((r) => _RepaymentCard(
                            repayment: r, isDark: widget.isDark))
                        .toList(),
                  ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// ── Payment Card widget ─────────────────────────────────────────
class _PaymentCard extends StatelessWidget {
  final bool isDark;
  final String title;
  final IconData icon;
  final Color color;
  final Color iconBg;
  final List<_PaymentDetail> details;

  const _PaymentCard({
    required this.isDark,
    required this.title,
    required this.icon,
    required this.color,
    required this.iconBg,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF111827) : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
              color: color.withValues(alpha: 0.07),
              blurRadius: 12,
              offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 12),
            Text(title,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : Colors.black87)),
          ]),
          const SizedBox(height: 14),
          ...details.map((d) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(d.label,
                        style: TextStyle(
                            fontSize: 13,
                            color: isDark
                                ? Colors.white54
                                : Colors.black45)),
                    Text(d.value,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: isDark
                                ? Colors.white
                                : Colors.black87)),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

// ── Payment Detail data holder ──────────────────────────────────
class _PaymentDetail {
  final String label;
  final String value;
  const _PaymentDetail({required this.label, required this.value});
}

// ════════════════════════════════════════════════════════════════
//  TAB 4 — PROFILE
// ════════════════════════════════════════════════════════════════
class _ProfileTab extends StatefulWidget {
  final bool isDark;
  const _ProfileTab({required this.isDark});
  @override
  State<_ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<_ProfileTab> {
  bool isEditing = false;
  bool isLoading = true;

  final nameCtrl = TextEditingController();
  final contactCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final bioCtrl = TextEditingController();
  final locationCtrl = TextEditingController();
  final otherContactCtrl = TextEditingController();
  final kinNameCtrl = TextEditingController();
  final kinContactCtrl = TextEditingController();
  final incomeCtrl = TextEditingController();
  final addressCtrl = TextEditingController();

  String selectedGender = 'Other';
  String selectedOccupation = 'Other';
  String selectedLoanType = '';
  String selectedEducation = '';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final data = await ApiService.getProfile();
      setState(() {
        nameCtrl.text = data['name'] ?? '';
        emailCtrl.text = data['email'] ?? '';
        contactCtrl.text = data['phone'] ?? '';
        bioCtrl.text = data['profile']?['bio'] ?? '';
        locationCtrl.text = data['profile']?['address'] ?? '';
        otherContactCtrl.text =
            data['profile']?['other_contact'] ?? '';
        kinNameCtrl.text = data['profile']?['kin_name'] ?? '';
        kinContactCtrl.text = data['profile']?['kin_contact'] ?? '';
        incomeCtrl.text = data['profile']?['income'] ?? '';
        addressCtrl.text =
            data['profile']?['current_address'] ?? '';
        selectedGender = data['profile']?['gender'] ?? 'Other';
        selectedOccupation =
            data['profile']?['occupation'] ?? 'Other';
        selectedLoanType = data['profile']?['loan_type'] ?? '';
        selectedEducation = data['profile']?['education'] ?? '';
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  Future<void> _save() async {
    try {
      await ApiService.updateProfile(
        {
          'name': nameCtrl.text,
          'phone': contactCtrl.text,
          'bio': bioCtrl.text,
          'address': locationCtrl.text,
          'other_contact': otherContactCtrl.text,
          'kin_name': kinNameCtrl.text,
          'kin_contact': kinContactCtrl.text,
          'income': incomeCtrl.text,
          'current_address': addressCtrl.text,
          'gender': selectedGender,
          'occupation': selectedOccupation,
          'loan_type': selectedLoanType,
          'education': selectedEducation,
        },
        null,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('✅ Profile updated successfully'),
            backgroundColor: kGreen));
        setState(() => isEditing = false);
        _load();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Failed: $e')));
      }
    }
  }

  String _safe(String current, List<String> items) {
    if (current.isNotEmpty && items.contains(current)) return current;
    if (current.isNotEmpty) items.add(current);
    return items.contains('Other') ? 'Other' : items.first;
  }

  Future<void> _logout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        title: const Row(children: [
          Icon(Icons.logout_rounded,
              color: Colors.redAccent, size: 22),
          SizedBox(width: 8),
          Text('Log Out',
              style: TextStyle(fontWeight: FontWeight.w700)),
        ]),
        content:
            const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel',
                style: TextStyle(color: kBlue)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Log Out',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      try {
        await ApiService.clearAllNotifications();
      } catch (_) {}
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      await prefs.remove('user');
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
          (_) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator(color: kBlue));
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 30),
      child: Column(children: [
        // ── Header card ──
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
                colors: [kBlue, Color(0xFF0056A8)]),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(children: [
            CircleAvatar(
              radius: 44,
              backgroundColor: Colors.white24,
              child: Text(
                nameCtrl.text.isNotEmpty
                    ? nameCtrl.text[0].toUpperCase()
                    : 'U',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 12),
            Text(nameCtrl.text,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            Text(emailCtrl.text,
                style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.75),
                    fontSize: 13)),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: isEditing
                  ? _save
                  : () => setState(() => isEditing = true),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 10),
                decoration: BoxDecoration(
                  color: isEditing
                      ? kGreen
                      : Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: Colors.white.withValues(alpha: 0.3)),
                ),
                child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                          isEditing
                              ? Icons.check_rounded
                              : Icons.edit_rounded,
                          color: Colors.white,
                          size: 16),
                      const SizedBox(width: 6),
                      Text(
                          isEditing
                              ? 'Save Changes'
                              : 'Edit Profile',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600)),
                    ]),
              ),
            ),
          ]),
        ),

        const SizedBox(height: 20),

        _Section(
            title: 'Personal Information',
            icon: Icons.person_rounded,
            isDark: widget.isDark,
            children: [
              _Field('Full Name', nameCtrl, isEditing, widget.isDark,
                  icon: Icons.badge_rounded),
              _Field('Email', emailCtrl, false, widget.isDark,
                  icon: Icons.email_rounded),
              _Field('Phone', contactCtrl, isEditing, widget.isDark,
                  icon: Icons.phone_rounded,
                  type: TextInputType.phone),
              _Field('Other Contact', otherContactCtrl, isEditing,
                  widget.isDark,
                  icon: Icons.phone_in_talk_rounded,
                  type: TextInputType.phone),
              _Field('Address', locationCtrl, isEditing, widget.isDark,
                  icon: Icons.location_on_rounded),
              _Field('Bio', bioCtrl, isEditing, widget.isDark,
                  icon: Icons.info_outline_rounded, maxLines: 3),
              _Drop(
                  'Gender',
                  _safe(selectedGender, ['Male', 'Female', 'Other']),
                  ['Male', 'Female', 'Other'],
                  isEditing,
                  widget.isDark,
                  Icons.wc_rounded,
                  (v) => setState(() => selectedGender = v!)),
            ]),

        const SizedBox(height: 14),

        _Section(
            title: 'Employment & Loan Details',
            icon: Icons.work_rounded,
            isDark: widget.isDark,
            children: [
              _Field('Next of Kin Name', kinNameCtrl, isEditing,
                  widget.isDark,
                  icon: Icons.people_rounded),
              _Field('Next of Kin Contact', kinContactCtrl, isEditing,
                  widget.isDark,
                  icon: Icons.contact_phone_rounded,
                  type: TextInputType.phone),
              _Drop(
                  'Occupation',
                  _safe(selectedOccupation, [
                    'Farmer',
                    'Business Owner',
                    'Teacher',
                    'Engineer',
                    'Driver',
                    'Student',
                    'Civil Servant',
                    'Medical Worker',
                    'Technician',
                    'Other'
                  ]),
                  [
                    'Farmer',
                    'Business Owner',
                    'Teacher',
                    'Engineer',
                    'Driver',
                    'Student',
                    'Civil Servant',
                    'Medical Worker',
                    'Technician',
                    'Other'
                  ],
                  isEditing,
                  widget.isDark,
                  Icons.work_outline_rounded,
                  (v) => setState(() => selectedOccupation = v!)),
              _Field('Monthly Income (UGX)', incomeCtrl, isEditing,
                  widget.isDark,
                  icon: Icons.account_balance_wallet_rounded,
                  type: TextInputType.number),
              _Drop(
                  'Loan Type',
                  _safe(selectedLoanType, [
                    'Logbook Loan',
                    'Business Loan',
                    'Personal Loan',
                    'Asset Financing Loan',
                    'Salary Loan'
                  ]),
                  [
                    'Logbook Loan',
                    'Business Loan',
                    'Personal Loan',
                    'Asset Financing Loan',
                    'Salary Loan'
                  ],
                  isEditing,
                  widget.isDark,
                  Icons.monetization_on_rounded,
                  (v) => setState(() => selectedLoanType = v!)),
              _Drop(
                  'Highest Education',
                  _safe(selectedEducation, [
                    "Primary",
                    "Secondary",
                    "Diploma",
                    "Bachelor's Degree",
                    "Master's Degree",
                    "Doctorate",
                    "Other"
                  ]),
                  [
                    "Primary",
                    "Secondary",
                    "Diploma",
                    "Bachelor's Degree",
                    "Master's Degree",
                    "Doctorate",
                    "Other"
                  ],
                  isEditing,
                  widget.isDark,
                  Icons.school_rounded,
                  (v) => setState(() => selectedEducation = v!)),
              _Field('Current Address', addressCtrl, isEditing,
                  widget.isDark,
                  icon: Icons.home_rounded),
            ]),

        const SizedBox(height: 14),

        // ── Account section ──
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: widget.isDark
                ? const Color(0xFF111827)
                : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: kBlue.withValues(alpha: 0.1)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black
                      .withValues(alpha: widget.isDark ? 0.3 : 0.05),
                  blurRadius: 12,
                  offset: const Offset(0, 4))
            ],
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Container(
                      width: 4,
                      height: 20,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [kBlue, kGreen]),
                          borderRadius: BorderRadius.circular(2))),
                  const SizedBox(width: 10),
                  const Icon(Icons.manage_accounts_rounded,
                      color: kBlue, size: 18),
                  const SizedBox(width: 6),
                  const Text('Account',
                      style: TextStyle(
                          color: kBlue,
                          fontSize: 15,
                          fontWeight: FontWeight.w700)),
                ]),
                const SizedBox(height: 16),

                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const SettingsPage())),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: kBlue.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                          color: kBlue.withValues(alpha: 0.15)),
                    ),
                    child: Row(children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: kBlue.withValues(alpha: 0.12),
                            borderRadius:
                                BorderRadius.circular(10)),
                        child: const Icon(
                            Icons.settings_rounded,
                            color: kBlue,
                            size: 20),
                      ),
                      const SizedBox(width: 14),
                      const Expanded(
                        child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text('Settings',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: kBlue)),
                              Text(
                                  'App preferences & notifications',
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey)),
                            ]),
                      ),
                      const Icon(Icons.chevron_right_rounded,
                          color: kBlue, size: 20),
                    ]),
                  ),
                ),

                const SizedBox(height: 10),

                GestureDetector(
                  onTap: _logout,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.redAccent.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                          color:
                              Colors.redAccent.withValues(alpha: 0.2)),
                    ),
                    child: Row(children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color:
                                Colors.redAccent.withValues(alpha: 0.10),
                            borderRadius:
                                BorderRadius.circular(10)),
                        child: const Icon(Icons.logout_rounded,
                            color: Colors.redAccent, size: 20),
                      ),
                      const SizedBox(width: 14),
                      const Expanded(
                        child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text('Log Out',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.redAccent)),
                              Text('Sign out of your account',
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey)),
                            ]),
                      ),
                      const Icon(Icons.chevron_right_rounded,
                          color: Colors.redAccent, size: 20),
                    ]),
                  ),
                ),
              ]),
        ),
      ]),
    );
  }
}

// ════════════════════════════════════════════════════════════════
//  GUEST PROMPT
// ════════════════════════════════════════════════════════════════
// ignore: unused_element
class _GuestPrompt extends StatelessWidget {
  final String message;
  const _GuestPrompt({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                    color: kBlue.withValues(alpha: 0.07),
                    shape: BoxShape.circle),
                child: const Icon(Icons.lock_outline_rounded,
                    size: 56, color: kBlue),
              ),
              const SizedBox(height: 20),
              const Text('Not logged in',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: kBlue)),
              const SizedBox(height: 8),
              Text(message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      height: 1.5)),
            ]),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
//  EDIT LOAN PAGE
// ════════════════════════════════════════════════════════════════
class _EditLoanPage extends StatefulWidget {
  final Map loan;
  const _EditLoanPage({required this.loan});
  @override
  State<_EditLoanPage> createState() => _EditLoanPageState();
}

class _EditLoanPageState extends State<_EditLoanPage> {
  final _formKey = GlobalKey<FormState>();
  bool isSaving = false;

  late final nameCtrl = TextEditingController(
      text: widget.loan['name']?.toString() ?? '');
  late final contactCtrl = TextEditingController(
      text: widget.loan['contact']?.toString() ?? '');
  late final emailCtrl = TextEditingController(
      text: widget.loan['email']?.toString() ?? '');
  late final locationCtrl = TextEditingController(
      text: widget.loan['location']?.toString() ?? '');
  late final otherCtrl = TextEditingController(
      text: widget.loan['other_contact']?.toString() ?? '');
  late final bioCtrl = TextEditingController(
      text: widget.loan['bio_info']?.toString() ?? '');
  late final kinNameCtrl = TextEditingController(
      text: widget.loan['kin_name']?.toString() ?? '');
  late final kinContactCtrl = TextEditingController(
      text: widget.loan['kin_contact']?.toString() ?? '');
  late final amountCtrl = TextEditingController(
      text: widget.loan['loan_amount']?.toString() ?? '');
  late final incomeCtrl = TextEditingController(
      text: widget.loan['monthly_income']?.toString() ?? '');
  late final addressCtrl = TextEditingController(
      text: widget.loan['address']?.toString() ?? '');

  late String? selectedGender =
      widget.loan['gender']?.toString();
  late String? selectedLoanType =
      widget.loan['loan_type']?.toString();
  late String? selectedOccupation =
      widget.loan['occupation']?.toString();
  late String? selectedEducation =
      widget.loan['education']?.toString();

  List<XFile> newCollateralImages = [];
  bool _collateralTouched = false;
  final _picker = ImagePicker();

  static const _genders = ['Male', 'Female'];
  static const _loanTypes = [
    'Logbook Loan',
    'Business Loan',
    'Personal Loan',
    'Asset Financing Loan',
    'Salary Loan'
  ];
  static const _occupations = [
    'Farmer',
    'Business Owner',
    'Teacher',
    'Engineer',
    'Driver',
    'Student',
    'Civil Servant',
    'Medical Worker',
    'Technician',
    'Other'
  ];
  static const _educations = [
    "Primary",
    "Secondary",
    "Diploma",
    "Bachelor's Degree",
    "Master's Degree",
    "Doctorate",
    "Other"
  ];

  @override
  void dispose() {
    nameCtrl.dispose();
    contactCtrl.dispose();
    emailCtrl.dispose();
    locationCtrl.dispose();
    otherCtrl.dispose();
    bioCtrl.dispose();
    kinNameCtrl.dispose();
    kinContactCtrl.dispose();
    amountCtrl.dispose();
    incomeCtrl.dispose();
    addressCtrl.dispose();
    super.dispose();
  }

  int get _existingCount {
    final raw = widget.loan['collateral_images'];
    if (raw == null) return 0;
    if (raw is List) return raw.length;
    if (raw is String && raw.isNotEmpty) {
      try {
        return (jsonDecode(raw) as List).length;
      } catch (_) {
        return 1;
      }
    }
    return 0;
  }

  Future<void> _pickCollateral() async {
    final picked = await _picker.pickMultiImage();
    setState(() {
      _collateralTouched = true;
      if (picked.isNotEmpty) newCollateralImages = picked;
    });
  }

  void _removeNewImage(int index) {
    setState(() {
      newCollateralImages.removeAt(index);
      if (newCollateralImages.isEmpty) _collateralTouched = true;
    });
  }

  bool get _collateralValid {
    if (!_collateralTouched) return _existingCount > 0;
    return newCollateralImages.isNotEmpty;
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_collateralValid) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
              Text('⚠️ Please upload at least one collateral image'),
          backgroundColor: Colors.redAccent));
      return;
    }

    setState(() => isSaving = true);
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';

      final uri = Uri.parse(
          '${ApiService.baseUrl}/loan-applications/${widget.loan['id']}/update');
      final request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'Bearer $token'
        ..headers['Accept'] = 'application/json';

      request.fields.addAll({
        'name': nameCtrl.text.trim(),
        'contact': contactCtrl.text.trim(),
        'email': emailCtrl.text.trim(),
        'location': locationCtrl.text.trim(),
        'other_contact': otherCtrl.text.trim(),
        'bio_info': bioCtrl.text.trim(),
        'gender': selectedGender ?? '',
        'kin_name': kinNameCtrl.text.trim(),
        'kin_contact': kinContactCtrl.text.trim(),
        'loan_type': selectedLoanType ?? '',
        'loan_amount': amountCtrl.text.trim(),
        'monthly_income': incomeCtrl.text.trim(),
        'occupation': selectedOccupation ?? '',
        'education': selectedEducation ?? '',
        'address': addressCtrl.text.trim(),
      });

      MediaType mimeTypeForPath(String path) {
        final ext = p.extension(path).toLowerCase();
        if (ext == '.png') {
          return MediaType('image', 'png');
        } else if (ext == '.jpg' || ext == '.jpeg') {
          return MediaType('image', 'jpeg');
        } else if (ext == '.gif') {
          return MediaType('image', 'gif');
        } else if (ext == '.webp') {
          return MediaType('image', 'webp');
        } else if (ext == '.heic') {
          return MediaType('image', 'heic');
        } else if (ext == '.heif') {
          return MediaType('image', 'heif');
        }
        return MediaType('image', 'jpeg');
      }

      for (final img in newCollateralImages) {
        if (kIsWeb) {
          final bytes = await img.readAsBytes();
          request.files.add(http.MultipartFile.fromBytes(
              'collateral_images[]', bytes,
              filename: img.name,
              contentType: MediaType('image', 'jpeg')));
        } else {
          request.files.add(await http.MultipartFile.fromPath(
              'collateral_images[]', img.path,
              filename: p.basename(img.path),
              contentType: mimeTypeForPath(img.path)));
        }
      }

      final streamed = await request.send();
      final body = await streamed.stream.bytesToString();
      final data = jsonDecode(body) as Map<String, dynamic>;
      final ok = data['success'] == true ||
          (streamed.statusCode >= 200 &&
              streamed.statusCode < 300);

      if (!mounted) return;
      if (ok) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('✅ Loan updated successfully'),
            backgroundColor: kGreen));
        Navigator.pop(context, true);
      } else {
        String errMsg = data['message'] ?? 'Update failed';
        if (data['errors'] != null && data['errors'] is Map) {
          final errorsMap = data['errors'] as Map<String, dynamic>;
          final errList = <String>[];
          errorsMap.forEach((key, value) {
            if (value is List) {
              errList.addAll(value.map((e) => e.toString()));
            } else {
              errList.add(value.toString());
            }
          });
          if (errList.isNotEmpty) {
            errMsg = errList.join('\n');
          }
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(errMsg),
            backgroundColor: Colors.redAccent));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.redAccent));
      }
    }
    if (mounted) setState(() => isSaving = false);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0A0F1E) : kBg,
      appBar: AppBar(
        backgroundColor: kBlue,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text('Edit Loan Application',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 17)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(3),
          child: Container(
              height: 3,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [kBlue, kGreen]))),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: isSaving
                ? const Padding(
                    padding: EdgeInsets.all(14),
                    child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2)))
                : TextButton.icon(
                    onPressed: _save,
                    icon: const Icon(Icons.check_rounded,
                        color: Colors.white, size: 18),
                    label: const Text('Save',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16)),
                  ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: Colors.orange.withValues(alpha: 0.3)),
              ),
              child: const Row(children: [
                Icon(Icons.info_outline_rounded,
                    color: Colors.orange, size: 18),
                SizedBox(width: 8),
                Expanded(
                    child: Text(
                  'Editing is only allowed while status is Pending. All fields are required.',
                  style: TextStyle(
                      color: Colors.orange, fontSize: 13),
                )),
              ]),
            ),

            _editSection(
                title: 'Personal Details',
                icon: Icons.person_rounded,
                isDark: isDark,
                children: [
                  _req(nameCtrl, 'Full Name',
                      Icons.badge_rounded, isDark),
                  _req(contactCtrl, 'Phone Number',
                      Icons.phone_rounded, isDark,
                      type: TextInputType.phone),
                  _req(emailCtrl, 'Email Address',
                      Icons.email_rounded, isDark,
                      type: TextInputType.emailAddress),
                  _req(locationCtrl, 'Location',
                      Icons.location_on_rounded, isDark),
                  _req(otherCtrl, 'Other Contact',
                      Icons.phone_in_talk_rounded, isDark,
                      type: TextInputType.phone),
                  _req(bioCtrl, 'Bio / About',
                      Icons.info_outline_rounded, isDark,
                      maxLines: 3),
                  _reqDrop('Gender', selectedGender, _genders,
                      Icons.wc_rounded, isDark,
                      (v) => setState(() => selectedGender = v)),
                ]),

            const SizedBox(height: 14),

            _editSection(
                title: 'Next of Kin',
                icon: Icons.people_rounded,
                isDark: isDark,
                children: [
                  _req(kinNameCtrl, 'Next of Kin Name',
                      Icons.badge_rounded, isDark),
                  _req(
                      kinContactCtrl,
                      'Next of Kin Contact',
                      Icons.contact_phone_rounded,
                      isDark,
                      type: TextInputType.phone,
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return 'Required';
                        }
                        if (v.trim().length != 10) {
                          return 'Must be exactly 10 digits';
                        }
                        return null;
                      }),
                ]),

            const SizedBox(height: 14),

            _editSection(
                title: 'Loan Details',
                icon: Icons.monetization_on_rounded,
                isDark: isDark,
                children: [
                  _reqDrop(
                      'Loan Type',
                      selectedLoanType,
                      _loanTypes,
                      Icons.category_rounded,
                      isDark,
                      (v) =>
                          setState(() => selectedLoanType = v)),
                  _req(amountCtrl, 'Loan Amount (UGX)',
                      Icons.attach_money_rounded, isDark,
                      type: TextInputType.number,
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return 'Required';
                        }
                        if (double.tryParse(v.trim()) == null) {
                          return 'Enter a valid number';
                        }
                        return null;
                      }),
                  _req(incomeCtrl, 'Monthly Income (UGX)',
                      Icons.account_balance_wallet_rounded, isDark,
                      type: TextInputType.number,
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return 'Required';
                        }
                        if (double.tryParse(v.trim()) == null) {
                          return 'Enter a valid number';
                        }
                        return null;
                      }),
                  _reqDrop(
                      'Occupation',
                      selectedOccupation,
                      _occupations,
                      Icons.work_outline_rounded,
                      isDark,
                      (v) => setState(
                          () => selectedOccupation = v)),
                  _reqDrop(
                      'Highest Education',
                      selectedEducation,
                      _educations,
                      Icons.school_rounded,
                      isDark,
                      (v) => setState(
                          () => selectedEducation = v)),
                  _req(addressCtrl, 'Current Address',
                      Icons.home_rounded, isDark),
                ]),

            const SizedBox(height: 14),

            _editSection(
              title: 'Collateral Images',
              icon: Icons.photo_library_rounded,
              isDark: isDark,
              children: [
                Container(
                  padding: const EdgeInsets.all(11),
                  margin: const EdgeInsets.only(bottom: 14),
                  decoration: BoxDecoration(
                    color: kBlue.withValues(alpha: 0.07),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: kBlue.withValues(alpha: 0.2)),
                  ),
                  child: Row(children: [
                    const Icon(Icons.info_outline_rounded,
                        color: kBlue, size: 15),
                    const SizedBox(width: 8),
                    Expanded(
                        child: Text(
                      _existingCount > 0
                          ? 'Currently $_existingCount image(s) on file. Upload new images below to replace them, or leave as-is to keep existing ones.'
                          : 'No collateral images on file. You must upload at least one image.',
                      style: const TextStyle(
                          color: kBlue, fontSize: 12),
                    )),
                  ]),
                ),

                GestureDetector(
                  onTap: _pickCollateral,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: double.infinity,
                    constraints:
                        const BoxConstraints(minHeight: 150),
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.grey[850]
                          : const Color(0xFFF5F8FF),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: !_collateralValid
                            ? Colors.redAccent.withValues(alpha: 0.6)
                            : newCollateralImages.isNotEmpty
                                ? kGreen.withValues(alpha: 0.6)
                                : kBlue.withValues(alpha: 0.25),
                        width: 1.8,
                      ),
                    ),
                    child: newCollateralImages.isEmpty
                        ? Column(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [
                                const SizedBox(height: 24),
                                Container(
                                  padding:
                                      const EdgeInsets.all(14),
                                  decoration: BoxDecoration(
                                      color: (_existingCount > 0
                                              ? kBlue
                                              : Colors.redAccent)
                                          .withValues(alpha: 0.09),
                                      shape: BoxShape.circle),
                                  child: Icon(
                                      Icons
                                          .add_photo_alternate_rounded,
                                      color: _existingCount > 0
                                          ? kBlue
                                          : Colors.redAccent,
                                      size: 30),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  _existingCount > 0
                                      ? 'Tap to replace collateral images'
                                      : 'Tap to upload collateral images',
                                  style: TextStyle(
                                      color: _existingCount > 0
                                          ? Colors.grey
                                          : Colors.redAccent,
                                      fontSize: 13),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _existingCount > 0
                                      ? '(Optional — $_existingCount existing image(s) will be kept)'
                                      : 'Required — at least one image',
                                  style: TextStyle(
                                    color: _existingCount > 0
                                        ? kBlue.withValues(alpha: 0.6)
                                        : Colors.redAccent,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 24),
                              ])
                        : Padding(
                            padding: const EdgeInsets.all(10),
                            child: Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  ...List.generate(
                                      newCollateralImages.length,
                                      (i) {
                                    final img =
                                        newCollateralImages[i];
                                    return Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius
                                                    .circular(10),
                                            child: SizedBox(
                                              width: 100,
                                              height: 100,
                                              child: kIsWeb
                                                  ? Image.network(
                                                      img.path,
                                                      fit: BoxFit
                                                          .cover)
                                                  : Image.file(
                                                      File(img.path),
                                                      fit: BoxFit
                                                          .cover),
                                            ),
                                          ),
                                          Positioned(
                                              top: -6,
                                              right: -6,
                                              child: GestureDetector(
                                                onTap: () =>
                                                    _removeNewImage(
                                                        i),
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets
                                                          .all(3),
                                                  decoration: const BoxDecoration(
                                                      color: Colors
                                                          .redAccent,
                                                      shape: BoxShape
                                                          .circle),
                                                  child: const Icon(
                                                      Icons
                                                          .close_rounded,
                                                      color: Colors
                                                          .white,
                                                      size: 13),
                                                ),
                                              )),
                                          Positioned(
                                              bottom: 4,
                                              right: 4,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets
                                                        .all(3),
                                                decoration: const BoxDecoration(
                                                    color: kGreen,
                                                    shape: BoxShape
                                                        .circle),
                                                child: const Icon(
                                                    Icons
                                                        .check_rounded,
                                                    color:
                                                        Colors.white,
                                                    size: 11),
                                              )),
                                        ]);
                                  }),
                                  GestureDetector(
                                    onTap: _pickCollateral,
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: kBlue.withValues(
                                            alpha: 0.06),
                                        borderRadius:
                                            BorderRadius.circular(
                                                10),
                                        border: Border.all(
                                            color: kBlue
                                                .withValues(alpha: 0.25),
                                            width: 1.5),
                                      ),
                                      child: const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment
                                                  .center,
                                          children: [
                                            Icon(Icons.add_rounded,
                                                color: kBlue,
                                                size: 26),
                                            SizedBox(height: 4),
                                            Text('Add more',
                                                style: TextStyle(
                                                    color: kBlue,
                                                    fontSize: 11)),
                                          ]),
                                    ),
                                  ),
                                ]),
                          ),
                  ),
                ),

                if (newCollateralImages.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Row(children: [
                    const Icon(Icons.check_circle_rounded,
                        color: kGreen, size: 14),
                    const SizedBox(width: 6),
                    Text(
                        '${newCollateralImages.length} new image(s) will replace existing ones',
                        style: const TextStyle(
                            color: kGreen,
                            fontSize: 12,
                            fontWeight: FontWeight.w600)),
                  ]),
                ] else if (_existingCount > 0 &&
                    !_collateralTouched) ...[
                  const SizedBox(height: 8),
                  Row(children: [
                    const Icon(
                        Icons.check_circle_outline_rounded,
                        color: kBlue,
                        size: 14),
                    const SizedBox(width: 6),
                    Text(
                        '$_existingCount existing image(s) will be kept',
                        style: const TextStyle(
                            color: kBlue,
                            fontSize: 12,
                            fontWeight: FontWeight.w500)),
                  ]),
                ] else if (_collateralTouched &&
                    newCollateralImages.isEmpty) ...[
                  const SizedBox(height: 8),
                  const Row(children: [
                    Icon(Icons.warning_amber_rounded,
                        color: Colors.redAccent, size: 14),
                    SizedBox(width: 6),
                    Text(
                        'Please select at least one collateral image',
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 12,
                            fontWeight: FontWeight.w500)),
                  ]),
                ],
              ],
            ),

            const SizedBox(height: 28),

            GestureDetector(
              onTap: isSaving ? null : _save,
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: isSaving
                      ? kGreen.withValues(alpha: 0.6)
                      : kGreen,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                        color: kGreen.withValues(alpha: 0.3),
                        blurRadius: 16,
                        offset: const Offset(0, 6))
                  ],
                ),
                child: isSaving
                    ? const Center(
                        child: SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.5)))
                    : const Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        children: [
                            Icon(Icons.check_circle_rounded,
                                color: Colors.white, size: 20),
                            SizedBox(width: 10),
                            Text('Save Changes',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.4)),
                          ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _editSection(
      {required String title,
      required IconData icon,
      required bool isDark,
      required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF111827) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kBlue.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
              color: Colors.black
                  .withValues(alpha: isDark ? 0.3 : 0.05),
              blurRadius: 12,
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Container(
                  width: 4,
                  height: 20,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [kBlue, kGreen]),
                      borderRadius: BorderRadius.circular(2))),
              const SizedBox(width: 10),
              Icon(icon, color: kBlue, size: 18),
              const SizedBox(width: 6),
              Text(title,
                  style: const TextStyle(
                      color: kBlue,
                      fontSize: 15,
                      fontWeight: FontWeight.w700)),
            ]),
            const SizedBox(height: 18),
            ...children,
          ]),
    );
  }

  Widget _req(TextEditingController ctrl, String label,
      IconData icon, bool isDark,
      {TextInputType type = TextInputType.text,
      int maxLines = 1,
      String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: ctrl,
        keyboardType: type,
        maxLines: maxLines,
        style: TextStyle(
            color: isDark ? Colors.white : Colors.black87,
            fontSize: 14),
        decoration: _deco(label, icon, isDark),
        validator: validator ??
            (v) =>
                (v == null || v.trim().isEmpty) ? 'Required' : null,
      ),
    );
  }

  Widget _reqDrop(String label, String? value, List<String> items,
      IconData icon, bool isDark, Function(String?) onChanged) {
    final safe =
        (value != null && items.contains(value)) ? value : null;
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: DropdownButtonFormField<String>(
        initialValue: safe,
        style: TextStyle(
            color: isDark ? Colors.white : Colors.black87,
            fontSize: 14),
        dropdownColor:
            isDark ? const Color(0xFF1A2235) : Colors.white,
        decoration: _deco(label, icon, isDark),
        items: items
            .map((i) => DropdownMenuItem(
                  value: i,
                  child: Text(i,
                      style: TextStyle(
                          color: isDark
                              ? Colors.white
                              : Colors.black87)),
                ))
            .toList(),
        onChanged: onChanged,
        validator: (v) => v == null ? 'Required' : null,
      ),
    );
  }

  InputDecoration _deco(
          String label, IconData icon, bool isDark) =>
      InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
            color: isDark ? Colors.white54 : Colors.black45,
            fontSize: 13),
        prefixIcon: Icon(icon, color: kBlue, size: 18),
        filled: true,
        fillColor: isDark
            ? const Color(0xFF1A2235)
            : const Color(0xFFF5F8FF),
        contentPadding: const EdgeInsets.symmetric(
            vertical: 13, horizontal: 14),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
                color: isDark
                    ? Colors.white12
                    : const Color(0xFFD0E4FF))),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                const BorderSide(color: kBlue, width: 1.5)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                const BorderSide(color: Colors.redAccent)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
                color: Colors.redAccent, width: 1.5)),
      );
}

// ════════════════════════════════════════════════════════════════
//  LOAN REPAYMENTS PAGE
// ════════════════════════════════════════════════════════════════
class _LoanRepaymentsPage extends StatefulWidget {
  final Map loan;
  const _LoanRepaymentsPage({required this.loan});
  @override
  State<_LoanRepaymentsPage> createState() =>
      _LoanRepaymentsPageState();
}

class _LoanRepaymentsPageState extends State<_LoanRepaymentsPage> {
  bool isLoading = true;
  Map? loanDetail;
  List repayments = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final data =
          await ApiService.getRepaymentsByLoan(widget.loan['id']);
      setState(() {
        loanDetail = data['loan'];
        repayments = data['repayments'] ?? [];
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0A0F1E) : kBg,
      appBar: AppBar(
        backgroundColor: kBlue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(widget.loan['loan_type'] ?? 'Loan',
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700)),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: kBlue))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (loanDetail != null)
                      Container(
                        padding: const EdgeInsets.all(18),
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [kBlue, Color(0xFF0056A8)]),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(children: [
                          _balRow(
                              'Loan Amount',
                              'UGX ${fmtUGX(loanDetail!['loan_amount'])}',
                              Colors.white),
                          const SizedBox(height: 8),
                          _balRow(
                              'Total Repaid',
                              'UGX ${fmtUGX(loanDetail!['total_repaid'])}',
                              const Color(0xFF7FFFC4)),
                          const SizedBox(height: 8),
                          _balRow(
                              'Balance',
                              'UGX ${fmtUGX(loanDetail!['balance'])}',
                              (loanDetail!['balance'] ?? 0) > 0
                                  ? Colors.orange[300]!
                                  : Colors.greenAccent),
                          const SizedBox(height: 8),
                          _balRow(
                              'Due Date',
                              '${loanDetail!['due_date'] ?? 'N/A'}',
                              Colors.white),
                        ]),
                      ),
                    const Text('Repayment History',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: kBlue)),
                    const SizedBox(height: 10),
                    if (repayments.isEmpty)
                      const Center(
                          child: Padding(
                              padding: EdgeInsets.all(24),
                              child: Text('No repayments yet',
                                  style: TextStyle(
                                      color: Colors.grey))))
                    else
                      ...repayments.map((r) => _RepaymentCard(
                          repayment: r, isDark: isDark)),
                  ]),
            ),
    );
  }

  Widget _balRow(String label, String value, Color valueColor) =>
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
                style: const TextStyle(
                    color: Colors.white70, fontSize: 13)),
            Text(value,
                style: TextStyle(
                    color: valueColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 15)),
          ]);
}

// ════════════════════════════════════════════════════════════════
//  Notification Bell
// ════════════════════════════════════════════════════════════════
class _NotificationBell extends StatefulWidget {
  @override
  State<_NotificationBell> createState() =>
      _NotificationBellState();
}

class _NotificationBellState extends State<_NotificationBell> {
  int _unread = 0;

  @override
  void initState() {
    super.initState();
    _loadUnread();
  }

  Future<void> _loadUnread() async {
    try {
      final data = await ApiService.getNotifications();
      if (mounted) {
        setState(() => _unread = data['unread_count'] ?? 0);
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => const NotificationsPage()));
        _loadUnread();
      },
      child: Stack(children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.notifications_rounded,
              color: Colors.white, size: 22),
        ),
        if (_unread > 0)
          Positioned(
            right: 2,
            top: 2,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                  color: kGreen, shape: BoxShape.circle),
              constraints: const BoxConstraints(
                  minWidth: 16, minHeight: 16),
              child: Text(
                _unread > 99 ? '99+' : '$_unread',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ]),
    );
  }
}

// ════════════════════════════════════════════════════════════════
//  SHARED REUSABLE WIDGETS
// ════════════════════════════════════════════════════════════════

class _SummaryCard extends StatelessWidget {
  final String label, value;
  final IconData icon;
  final Color color;
  final bool isDark, wide;
  const _SummaryCard(
      {required this.label,
      required this.value,
      required this.icon,
      required this.color,
      required this.isDark,
      this.wide = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: wide ? double.infinity : null,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF111827) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
              color: color.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4))
        ],
      ),
      child: Row(children: [
        Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: color, size: 20)),
        const SizedBox(width: 12),
        Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Text(label,
                  style: TextStyle(
                      fontSize: 11,
                      color: isDark
                          ? Colors.white54
                          : Colors.grey[600])),
              const SizedBox(height: 2),
              Text(value,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: isDark
                          ? Colors.white
                          : Colors.black87)),
            ])),
      ]),
    );
  }
}

class _StatusPill extends StatelessWidget {
  final String label;
  final int count;
  final Color color;
  const _StatusPill(
      {required this.label,
      required this.count,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withValues(alpha: 0.3))),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
                color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text('$label: $count',
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color)),
      ]),
    );
  }
}

class _LoanCard extends StatelessWidget {
  final Map loan;
  final bool isDark, compact;
  final VoidCallback? onEdit, onViewRepayments;
  const _LoanCard(
      {required this.loan,
      required this.isDark,
      this.compact = false,
      this.onEdit,
      this.onViewRepayments});

  Color _statusColor(String s) => switch (s) {
        'pending' => Colors.orange,
        'approved' => kGreen,
        'disbursed' => kBlue,
        'repaying' => Colors.purple,
        'completed' => Colors.teal,
        'rejected' => Colors.red,
        _ => Colors.grey,
      };

  @override
  Widget build(BuildContext context) {
    final status = loan['status'] ?? 'pending';
    final color = _statusColor(status);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF111827) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 3))
        ],
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Text(loan['loan_type'] ?? '',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: isDark
                                  ? Colors.white
                                  : Colors.black87))),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: color.withValues(alpha: 0.3))),
                    child: Text(status.toUpperCase(),
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: color)),
                  ),
                ]),
            const SizedBox(height: 8),
            Text('UGX ${fmtUGX(loan['loan_amount'])}',
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: kBlue)),
            if (!compact) ...[
              const SizedBox(height: 6),
              Row(children: [
                _det('Repaid',
                    'UGX ${fmtUGX(loan['total_repaid'])}'),
                const SizedBox(width: 16),
                _det('Balance',
                    'UGX ${fmtUGX(loan['balance'])}'),
              ]),
              if (loan['due_date'] != null) ...[
                const SizedBox(height: 4),
                _det('Due Date', '${loan['due_date']}'),
              ],
            ],
            if (loan['rejection_reason'] != null &&
                status == 'rejected') ...[
              const SizedBox(height: 8),
              Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(children: [
                    const Icon(Icons.info_outline,
                        color: Colors.red, size: 16),
                    const SizedBox(width: 6),
                    Expanded(
                        child: Text(
                            'Reason: ${loan['rejection_reason']}',
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.red))),
                  ])),
            ],
            if (!compact &&
                (onEdit != null ||
                    onViewRepayments != null)) ...[
              const SizedBox(height: 12),
              Row(children: [
                if (onViewRepayments != null)
                  Expanded(
                      child: OutlinedButton.icon(
                    onPressed: onViewRepayments,
                    icon: const Icon(Icons.payments_rounded,
                        size: 16),
                    label: const Text('Repayments'),
                    style: OutlinedButton.styleFrom(
                        foregroundColor: kBlue,
                        side: const BorderSide(color: kBlue)),
                  )),
                if (onEdit != null) ...[
                  const SizedBox(width: 10),
                  Expanded(
                      child: ElevatedButton.icon(
                    onPressed: onEdit,
                    icon: const Icon(Icons.edit_rounded,
                        size: 16, color: Colors.white),
                    label: const Text('Edit',
                        style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: kGreen),
                  )),
                ],
              ]),
            ],
          ]),
    );
  }

  Widget _det(String label, String value) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: '$label: ',
          style: const TextStyle(color: Colors.grey, fontSize: 12)),
      TextSpan(
          text: value,
          style: TextStyle(
              color: isDark ? Colors.white : Colors.black87,
              fontSize: 12,
              fontWeight: FontWeight.w600)),
    ]));
  }
}

class _RepaymentCard extends StatelessWidget {
  final Map repayment;
  final bool isDark;
  const _RepaymentCard(
      {required this.repayment, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF111827) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: kGreen.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 6)
        ],
      ),
      child: Row(children: [
        Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: kGreen.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10)),
            child: const Icon(Icons.check_circle_rounded,
                color: kGreen, size: 22)),
        const SizedBox(width: 12),
        Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Text('UGX ${fmtUGX(repayment['amount'])}',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: kGreen)),
              Text(
                  '${repayment['payment_method'] ?? ''} • ${repayment['payment_date'] ?? ''}',
                  style: TextStyle(
                      fontSize: 12,
                      color: isDark
                          ? Colors.white54
                          : Colors.grey[600])),
              if (repayment['loan_type'] != null)
                Text('${repayment['loan_type']}',
                    style: const TextStyle(
                        fontSize: 11, color: Colors.grey)),
            ])),
        if (repayment['reference_number'] != null &&
            repayment['reference_number']
                .toString()
                .isNotEmpty)
          Text('#${repayment['reference_number']}',
              style: TextStyle(
                  fontSize: 11,
                  color: isDark
                      ? Colors.white38
                      : Colors.grey)),
      ]),
    );
  }
}

// ─── Shared form helpers ─────────────────────────────────────────
class _Section extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isDark;
  final List<Widget> children;
  const _Section(
      {required this.title,
      required this.icon,
      required this.isDark,
      required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0F172A).withOpacity(0.3) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark ? Colors.white.withOpacity(0.06) : Colors.black.withOpacity(0.04),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 20,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [kBlue, kGreen],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Icon(icon, color: kBlue, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final String label;
  final TextEditingController ctrl;
  final bool editing, isDark;
  final IconData? icon;
  final TextInputType type;
  final int maxLines;
  const _Field(this.label, this.ctrl, this.editing, this.isDark,
      {this.icon,
      this.type = TextInputType.text,
      this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    if (!editing) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: kBlue.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon ?? Icons.info_rounded, color: kBlue, size: 18),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label.toUpperCase(),
                        style: TextStyle(
                          color: isDark ? Colors.white38 : Colors.black38,
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        ctrl.text.isEmpty ? '—' : ctrl.text,
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Divider(
              color: isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.03),
              height: 1,
              thickness: 1,
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: ctrl,
        maxLines: maxLines,
        keyboardType: type,
        style: TextStyle(
          color: isDark ? Colors.white : Colors.black87,
          fontSize: 14,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: isDark ? Colors.white54 : Colors.black45,
            fontSize: 13,
          ),
          prefixIcon: icon != null ? Icon(icon, color: kBlue, size: 18) : null,
          filled: true,
          fillColor: isDark ? const Color(0xFF1E293B).withOpacity(0.3) : const Color(0xFFF1F5F9),
          contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: isDark ? Colors.white10 : Colors.black.withOpacity(0.06),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: kBlue, width: 1.5),
          ),
        ),
      ),
    );
  }
}

class _Drop extends StatelessWidget {
  final String label, value;
  final List<String> items;
  final bool editing, isDark;
  final IconData icon;
  final Function(String?) onChanged;
  const _Drop(this.label, this.value, this.items, this.editing,
      this.isDark, this.icon, this.onChanged);

  @override
  Widget build(BuildContext context) {
    if (!editing) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: kBlue.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: kBlue, size: 18),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label.toUpperCase(),
                        style: TextStyle(
                          color: isDark ? Colors.white38 : Colors.black38,
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        value.isEmpty ? '—' : value,
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Divider(
              color: isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.03),
              height: 1,
              thickness: 1,
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<String>(
        value: value,
        style: TextStyle(
          color: isDark ? Colors.white : Colors.black87,
          fontSize: 14,
        ),
        dropdownColor: isDark ? const Color(0xFF1E293B) : Colors.white,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: isDark ? Colors.white54 : Colors.black45,
            fontSize: 13,
          ),
          prefixIcon: Icon(icon, color: kBlue, size: 18),
          filled: true,
          fillColor: isDark ? const Color(0xFF1E293B).withOpacity(0.3) : const Color(0xFFF1F5F9),
          contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: isDark ? Colors.white10 : Colors.black.withOpacity(0.06),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: kBlue, width: 1.5),
          ),
        ),
        items: items
            .map((i) => DropdownMenuItem(value: i, child: Text(i)))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}