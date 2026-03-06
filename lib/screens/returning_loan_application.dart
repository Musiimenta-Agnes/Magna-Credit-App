import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'success_message.dart';

class ReturningClientLoanPage extends StatefulWidget {
  const ReturningClientLoanPage({super.key});

  @override
  State<ReturningClientLoanPage> createState() =>
      _ReturningClientLoanPageState();
}

class _ReturningClientLoanPageState extends State<ReturningClientLoanPage> {
  final _formKey = GlobalKey<FormState>();

  // ── Auto-filled from saved session ──
  String _userName  = '';
  String _userEmail = '';
  String _userPhone = '';
  String _token     = '';

  // ── User-fillable fields ──
  final TextEditingController bioInfoController       = TextEditingController();
  final TextEditingController locationController      = TextEditingController();
  final TextEditingController otherContactController  = TextEditingController();
  final TextEditingController kinNameController       = TextEditingController();
  final TextEditingController kinContactController    = TextEditingController();
  final TextEditingController incomeController        = TextEditingController();
  final TextEditingController loanAmountController    = TextEditingController();
  final TextEditingController addressController       = TextEditingController();

  String? selectedGender;
  String? selectedOccupation;
  String? selectedLoanType;
  String? selectedEducation;

  XFile?       nationalIdImage;
  List<XFile>  collateralImages = [];
  bool         _isSubmitting    = false;

  final ImagePicker _picker = ImagePicker();

  static const Color _blue  = Color(0xFF0076D6);
  static const Color _green = Color(0xFF00CB5E);

  @override
  void initState() {
    super.initState();
    _loadUserDetails();
  }

  // ── Load name, email, phone from SharedPreferences ──
  Future<void> _loadUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName  = prefs.getString('user_name')  ?? '';
      _userEmail = prefs.getString('user_email') ?? '';
      _userPhone = prefs.getString('user_phone') ?? '';
      _token     = prefs.getString('token')      ?? '';
    });
  }

  @override
  void dispose() {
    bioInfoController.dispose();
    locationController.dispose();
    otherContactController.dispose();
    kinNameController.dispose();
    kinContactController.dispose();
    incomeController.dispose();
    loanAmountController.dispose();
    addressController.dispose();
    super.dispose();
  }

  // ── Snack bar ──
  void _snack(String message, {bool isError = false}) {
    final overlay = Overlay.of(context);
    final entry = OverlayEntry(
      builder: (_) => Positioned(
        top: MediaQuery.of(context).padding.top + 12,
        left: 16, right: 16,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: isError ? Colors.redAccent : _green,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 12, offset: const Offset(0, 4))],
            ),
            child: Row(children: [
              Icon(isError ? Icons.error_rounded : Icons.check_circle_rounded,
                  color: Colors.white, size: 20),
              const SizedBox(width: 10),
              Expanded(child: Text(message,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14))),
            ]),
          ),
        ),
      ),
    );
    overlay.insert(entry);
    Future.delayed(const Duration(seconds: 3), entry.remove);
  }

  Future<void> _pickNationalId() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => nationalIdImage = picked);
  }

  Future<void> _pickCollateral() async {
    final picked = await _picker.pickMultiImage();
    if (picked.isNotEmpty) setState(() => collateralImages = picked);
  }

  Widget _imagePreview(XFile image) {
    if (kIsWeb) return Image.network(image.path, fit: BoxFit.cover);
    return Image.file(File(image.path), fit: BoxFit.cover);
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (nationalIdImage == null) {
      _snack('Please upload your National ID', isError: true);
      return;
    }
    if (collateralImages.isEmpty) {
      _snack('Please upload your National ID', isError: true);
      return;
    }
    if (_token.isEmpty) {
      _snack('Session expired. Please log in again.', isError: true);
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final uri     = Uri.parse('http://127.0.0.1:8000/api/loan-applications');
      final request = http.MultipartRequest('POST', uri);

      request.headers['Authorization'] = 'Bearer $_token';
      request.headers['Accept']        = 'application/json';

      // ── Auto-filled fields from session ──
      request.fields['name']    = _userName;
      request.fields['email']   = _userEmail;
      request.fields['contact'] = _userPhone;

      // ── User-filled fields ──
      request.fields['bio_info']       = bioInfoController.text.trim();
      request.fields['location']       = locationController.text.trim();
      request.fields['other_contact']  = otherContactController.text.trim();
      request.fields['gender']         = selectedGender ?? '';
      request.fields['kin_name']       = kinNameController.text.trim();
      request.fields['kin_contact']    = kinContactController.text.trim();
      request.fields['occupation']     = selectedOccupation ?? '';
      request.fields['monthly_income'] = incomeController.text.trim();
      request.fields['loan_amount']    = loanAmountController.text.trim();
      request.fields['loan_type']      = selectedLoanType ?? '';
      request.fields['education']      = selectedEducation ?? '';
      request.fields['address']        = addressController.text.trim();

      // ── National ID image ──
      if (kIsWeb) {
        final bytes = await nationalIdImage!.readAsBytes();
        request.files.add(http.MultipartFile.fromBytes(
            'national_id_image', bytes, filename: nationalIdImage!.name));
      } else {
        request.files.add(await http.MultipartFile.fromPath(
            'national_id_image', nationalIdImage!.path));
      }

      // ── Collateral images ──
      for (final img in collateralImages) {
        if (kIsWeb) {
          final bytes = await img.readAsBytes();
          request.files.add(http.MultipartFile.fromBytes(
              'collateral_images[]', bytes, filename: img.name));
        } else {
          request.files.add(await http.MultipartFile.fromPath(
              'collateral_images[]', img.path));
        }
      }

      final streamed      = await request.send();
      final responseBody  = await streamed.stream.bytesToString();
      final data          = jsonDecode(responseBody) as Map<String, dynamic>;

      // Backend returns success:true or status:true
      final bool ok = data['success'] == true || data['status'] == true ||
          (streamed.statusCode >= 200 && streamed.statusCode < 300);

      if (ok) {
        _snack('Loan application submitted successfully!');
        await Future.delayed(const Duration(milliseconds: 700));
        if (mounted) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_) => const ApplicationSuccessPage()));
        }
      } else {
        _snack(data['message'] ?? 'Submission failed. Please try again.', isError: true);
      }
    } catch (e) {
      _snack('Something went wrong. Please try again.', isError: true);
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  // ════════════════════════════════════════════════════════════
  //  BUILD
  // ════════════════════════════════════════════════════════════

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : const Color(0xFFF5F8FA),
      appBar: AppBar(
        backgroundColor: _blue,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('New Loan Application',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,
                fontSize: 18, letterSpacing: 0.4)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(3),
          child: Container(height: 3,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [_blue, _green]))),
        ),
      ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(18, 24, 18, 30),
        child: Form(
          key: _formKey,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

            // ── Auto-filled banner ──
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [_blue.withOpacity(0.08), _green.withOpacity(0.06)]),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: _blue.withOpacity(0.2)),
              ),
              child: Row(children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: _blue.withOpacity(0.1), shape: BoxShape.circle),
                  child: const Icon(Icons.person_rounded, color: _blue, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(_userName.isEmpty ? 'Logged in user' : _userName,
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15,
                          color: isDark ? Colors.white : Colors.black87)),
                  const SizedBox(height: 2),
                  Text(_userEmail, style: TextStyle(fontSize: 12,
                      color: isDark ? Colors.white54 : Colors.black45)),
                  Text(_userPhone, style: TextStyle(fontSize: 12,
                      color: isDark ? Colors.white54 : Colors.black45)),
                ])),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: _green.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: _green.withOpacity(0.3)),
                  ),
                  child: const Text('Auto-filled',
                      style: TextStyle(color: _green, fontSize: 11, fontWeight: FontWeight.w600)),
                ),
              ]),
            ),

            const SizedBox(height: 20),

            // ── Personal extras ──
            _FormCard(isDark: isDark, title: 'Personal Details',
                icon: Icons.person_outline_rounded,
                subtitle: 'Additional details for your application.',
                children: [
                  _field(bioInfoController, 'Bio / About You',
                      icon: Icons.info_outline_rounded, isDark: isDark, maxLines: 3),
                  _field(locationController, 'Location',
                      icon: Icons.location_on_rounded, isDark: isDark),
                  _field(otherContactController, 'Other Contact (optional)',
                      icon: Icons.phone_in_talk_rounded, isDark: isDark,
                      type: TextInputType.phone, required: false),
                  _dropdown(label: 'Gender', value: selectedGender,
                      items: ['Male', 'Female'],
                      icon: Icons.wc_rounded, isDark: isDark,
                      onChanged: (v) => setState(() => selectedGender = v)),
                ]),

            const SizedBox(height: 16),

            // ── Next of kin ──
            _FormCard(isDark: isDark, title: 'Next of Kin',
                icon: Icons.people_rounded,
                subtitle: 'Emergency contact information.',
                children: [
                  _field(kinNameController, 'Next of Kin Name',
                      icon: Icons.badge_rounded, isDark: isDark),
                  _field(kinContactController, 'Next of Kin Phone',
                      icon: Icons.contact_phone_rounded, isDark: isDark,
                      type: TextInputType.phone,
                      formatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Please fill in this field';
                        if (v.length != 10) return 'Must be exactly 10 digits';
                        return null;
                      }),
                ]),

            const SizedBox(height: 16),

            // ── Loan details ──
            _FormCard(isDark: isDark, title: 'Loan Details',
                icon: Icons.monetization_on_rounded,
                subtitle: 'Tell us about the loan you need.',
                children: [
                  _dropdown(label: 'Loan Type', value: selectedLoanType,
                      items: ['Logbook Loan', 'Business Loan', 'Personal Loan',
                        'Investment Loan', 'Car Loan'],
                      icon: Icons.category_rounded, isDark: isDark,
                      onChanged: (v) => setState(() => selectedLoanType = v)),
                  _field(loanAmountController, 'Loan Amount (UGX)',
                      icon: Icons.attach_money_rounded, isDark: isDark,
                      type: TextInputType.number,
                      formatters: [FilteringTextInputFormatter.digitsOnly]),
                  _field(incomeController, 'Monthly Income (UGX)',
                      icon: Icons.account_balance_wallet_rounded, isDark: isDark,
                      type: TextInputType.number,
                      formatters: [FilteringTextInputFormatter.digitsOnly]),
                  _dropdown(label: 'Occupation', value: selectedOccupation,
                      items: ['Farmer', 'Business Owner', 'Teacher', 'Engineer',
                        'Driver', 'Student', 'Civil Servant',
                        'Medical Worker', 'Technician', 'Other'],
                      icon: Icons.work_outline_rounded, isDark: isDark,
                      onChanged: (v) => setState(() => selectedOccupation = v)),
                  _dropdown(label: 'Highest Education', value: selectedEducation,
                      items: ["Primary", "Secondary", "Diploma",
                        "Bachelor's Degree", "Master's Degree", "Doctorate", "Other"],
                      icon: Icons.school_rounded, isDark: isDark,
                      onChanged: (v) => setState(() => selectedEducation = v)),
                  _field(addressController, 'Current Address',
                      icon: Icons.home_rounded, isDark: isDark),
                ]),

            const SizedBox(height: 16),

            // ── Documents ──
            _FormCard(isDark: isDark, title: 'Documents',
                icon: Icons.upload_file_rounded,
                subtitle: 'Upload required documents for verification.',
                children: [

                  // National ID
                  _docLabel('National ID *', Icons.badge_rounded, isDark),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: _pickNationalId,
                    child: _UploadBox(
                      isDark: isDark,
                      isEmpty: nationalIdImage == null,
                      emptyLabel: 'Tap to upload National ID',
                      emptyIcon: Icons.badge_rounded,
                      child: nationalIdImage != null
                          ? ClipRRect(borderRadius: BorderRadius.circular(12),
                              child: _imagePreview(nationalIdImage!))
                          : null,
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Collateral
                  _docLabel('Collateral Images *', Icons.collections_rounded, isDark,
                      badge: collateralImages.isNotEmpty
                          ? '${collateralImages.length} uploaded' : null),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: _pickCollateral,
                    child: _UploadBox(
                      isDark: isDark,
                      isEmpty: collateralImages.isEmpty,
                      emptyLabel: 'Tap to upload collateral images',
                      emptyIcon: Icons.add_photo_alternate_rounded,
                      child: collateralImages.isNotEmpty
                          ? ListView(
                              scrollDirection: Axis.horizontal,
                              children: collateralImages.map((img) => Padding(
                                padding: const EdgeInsets.all(4),
                                child: ClipRRect(borderRadius: BorderRadius.circular(10),
                                    child: SizedBox(width: 110, height: 110,
                                        child: _imagePreview(img))),
                              )).toList(),
                            )
                          : null,
                    ),
                  ),
                ]),

            const SizedBox(height: 28),

            // ── Submit button ──
            GestureDetector(
              onTap: _isSubmitting ? null : _submit,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: _isSubmitting ? _green.withOpacity(0.6) : _green,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: _green.withOpacity(0.3),
                      blurRadius: 16, offset: const Offset(0, 6))],
                ),
                child: _isSubmitting
                    ? const Center(child: SizedBox(width: 22, height: 22,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5)))
                    : const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
                        SizedBox(width: 10),
                        Text('Submit Application', style: TextStyle(fontSize: 16,
                            color: Colors.white, fontWeight: FontWeight.w700, letterSpacing: 0.4)),
                      ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  // ════════════════════════════════════════════════════════════
  //  HELPERS
  // ════════════════════════════════════════════════════════════

  Widget _field(
    TextEditingController ctrl,
    String label, {
    required IconData icon,
    required bool isDark,
    TextInputType type = TextInputType.text,
    int maxLines = 1,
    List<TextInputFormatter>? formatters,
    String? Function(String?)? validator,
    bool required = true,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: ctrl,
        keyboardType: type,
        maxLines: maxLines,
        inputFormatters: formatters,
        style: TextStyle(color: isDark ? Colors.white : Colors.black87, fontSize: 14),
        decoration: _deco(label, icon, isDark),
        validator: validator ?? (required
            ? (v) => v == null || v.isEmpty ? 'Please fill in this field' : null
            : null),
      ),
    );
  }

  Widget _dropdown({
    required String label,
    required String? value,
    required List<String> items,
    required IconData icon,
    required bool isDark,
    required Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: DropdownButtonFormField<String>(
        value: value,
        style: TextStyle(color: isDark ? Colors.white : Colors.black87, fontSize: 14),
        dropdownColor: isDark ? Colors.grey[900] : Colors.white,
        decoration: _deco(label, icon, isDark),
        items: items.map((g) => DropdownMenuItem(
          value: g,
          child: Text(g, style: TextStyle(color: isDark ? Colors.white : Colors.black87)),
        )).toList(),
        onChanged: onChanged,
        validator: (v) => v == null ? 'Please select $label' : null,
      ),
    );
  }

  InputDecoration _deco(String label, IconData icon, bool isDark) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: isDark ? Colors.white54 : Colors.black45, fontSize: 13),
      prefixIcon: Icon(icon, color: _blue, size: 18),
      filled: true,
      fillColor: isDark ? Colors.grey[850] : const Color(0xFFF5F8FF),
      contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 14),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: isDark ? Colors.white12 : const Color(0xFFD0E4FF))),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _blue, width: 1.5)),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent)),
      focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.5)),
    );
  }

  Widget _docLabel(String label, IconData icon, bool isDark, {String? badge}) {
    return Row(children: [
      Icon(icon, color: _blue, size: 16),
      const SizedBox(width: 6),
      Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600,
          color: isDark ? Colors.white70 : Colors.black87)),
      if (badge != null) ...[
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: _green.withOpacity(0.15), borderRadius: BorderRadius.circular(20)),
          child: Text(badge, style: const TextStyle(color: _green,
              fontSize: 10, fontWeight: FontWeight.w600)),
        ),
      ],
    ]);
  }
}

// ════════════════════════════════════════════════════════════
//  SHARED WIDGETS
// ════════════════════════════════════════════════════════════

class _FormCard extends StatelessWidget {
  final bool isDark;
  final String title, subtitle;
  final IconData icon;
  final List<Widget> children;
  static const Color _blue  = Color(0xFF0076D6);
  static const Color _green = Color(0xFF00CB5E);

  const _FormCard({required this.isDark, required this.title,
      required this.icon, required this.subtitle, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _blue.withOpacity(0.1)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
            blurRadius: 16, offset: const Offset(0, 4))],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(width: 4, height: 20,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(begin: Alignment.topCenter,
                      end: Alignment.bottomCenter, colors: [_blue, _green]),
                  borderRadius: BorderRadius.circular(2))),
          const SizedBox(width: 10),
          Icon(icon, color: _blue, size: 18),
          const SizedBox(width: 6),
          Text(title, style: const TextStyle(color: _blue,
              fontSize: 15, fontWeight: FontWeight.w700)),
        ]),
        const SizedBox(height: 6),
        Padding(padding: const EdgeInsets.only(left: 14),
            child: Text(subtitle, style: TextStyle(fontSize: 12,
                color: isDark ? Colors.white38 : Colors.black38))),
        const SizedBox(height: 18),
        ...children,
      ]),
    );
  }
}

class _UploadBox extends StatelessWidget {
  final bool isDark, isEmpty;
  final String emptyLabel;
  final IconData emptyIcon;
  final Widget? child;
  static const Color _blue  = Color(0xFF0076D6);
  static const Color _green = Color(0xFF00CB5E);

  const _UploadBox({required this.isDark, required this.isEmpty,
      required this.emptyLabel, required this.emptyIcon, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140, width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[850] : const Color(0xFFF5F8FF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
            color: isEmpty ? const Color(0xFFD0E4FF) : _green.withOpacity(0.4),
            width: 1.5),
      ),
      child: isEmpty
          ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: _blue.withOpacity(0.08), shape: BoxShape.circle),
                  child: Icon(emptyIcon, color: _blue, size: 24)),
              const SizedBox(height: 8),
              Text(emptyLabel, style: TextStyle(
                  color: isDark ? Colors.white38 : Colors.black38, fontSize: 13)),
              const SizedBox(height: 4),
              Text('Tap to browse', style: TextStyle(
                  color: _blue.withOpacity(0.7), fontSize: 11, fontWeight: FontWeight.w500)),
            ])
          : child!,
    );
  }
}