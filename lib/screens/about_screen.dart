import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';
import 'profile_page.dart';
import 'login_screen.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  int _selectedIndex = 1;

  static const Color _primaryBlue  = Color(0xFF007BFF);
  static const Color _accentGreen  = Color(0xFF1BBE6D);

  Future<void> _onItemTapped(int index) async {
    setState(() => _selectedIndex = index);

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    } else if (index == 2) {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';

      if (!mounted) return;

      if (token.isEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const ProfilePage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme  = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : const Color(0xFFF5F8FA),
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : _primaryBlue,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: isDark ? _primaryBlue : Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'About Us',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 20,
            letterSpacing: 0.5,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(
            height: 2,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [_primaryBlue, _accentGreen]),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Hero Header ──
            _buildHeroHeader(isDark),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Vision & Mission ──
                  Row(
                    children: [
                      Expanded(
                        child: _MiniCard(
                          icon: Icons.visibility_rounded,
                          title: 'Our Vision',
                          text: 'To become the most trusted and innovative digital credit partner, driving financial inclusion.',
                          gradient: const LinearGradient(
                            colors: [Color(0x22007BFF), Color(0x05007BFF)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          accentColor: _primaryBlue,
                          isDark: isDark,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _MiniCard(
                          icon: Icons.flag_rounded,
                          title: 'Our Mission',
                          text: 'To empower individuals & SMEs with simple, fast, and secure financing solutions.',
                          gradient: const LinearGradient(
                            colors: [Color(0x221BBE6D), Color(0x051BBE6D)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          accentColor: _accentGreen,
                          isDark: isDark,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // ── Loan Types ──
                  _SectionCard(
                    icon: Icons.account_balance_wallet_rounded,
                    title: 'Our Financial Solutions',
                    color: _primaryBlue,
                    isDark: isDark,
                    items: const [
                      _LoanItem(
                        icon: Icons.build_circle_rounded,
                        label: 'Asset Financing',
                        desc: 'Finance for acquiring capital & productive equipment.',
                        badge: 'For Business',
                        badgeColor: _accentGreen,
                      ),
                      _LoanItem(
                        icon: Icons.directions_car_rounded,
                        label: 'Logbook Loans',
                        desc: 'Superfast financing secured by your vehicle logbook.',
                        badge: 'Quick cash',
                        badgeColor: Colors.orange,
                      ),
                      _LoanItem(
                        icon: Icons.person_rounded,
                        label: 'Personal Loans',
                        desc: 'Flexible terms designed for urgent personal demands.',
                        badge: 'Flexible',
                        badgeColor: _primaryBlue,
                      ),
                      _LoanItem(
                        icon: Icons.badge_rounded,
                        label: 'Salary Loans',
                        desc: 'Convenient advances aligned with your salary schedule.',
                        badge: 'Easy approval',
                        badgeColor: Colors.deepPurple,
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // ── Core Values ──
                  _ValuesCard(isDark: isDark),

                  const SizedBox(height: 24),

                  // ── Contact Card (Premium Metallic/Credit Card Theme) ──
                  _buildContactCreditCard(isDark),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: isDark ? const Color(0xFF0F0F0F) : Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: _primaryBlue,
        unselectedItemColor: Colors.grey[500],
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        elevation: 8,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.info_rounded), label: 'About'),
          BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'My Profile'),
        ],
      ),
    );
  }

  // ── Hero Header Builder ──
  Widget _buildHeroHeader(bool isDark) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [const Color(0xFF111827), const Color(0xFF030712)]
              : [const Color(0xFFF8FAFC), const Color(0xFFE2E8F0)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        border: Border(
          bottom: BorderSide(
            color: isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.05),
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
      child: Column(
        children: [
          // Elegant animated-feeling logo ring
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [_primaryBlue, _accentGreen],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: _primaryBlue.withOpacity(0.25),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1F2937) : Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.account_balance_rounded,
                color: _primaryBlue,
                size: 38,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'MAGNA CREDIT LIMITED',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
              color: isDark ? Colors.white : Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            'INNOVATIVE FINANCIAL SOLUTIONS',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: isDark ? _accentGreen : _primaryBlue,
              letterSpacing: 2.0,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'A premier microfinance & digital lending institution committed to providing accessible, transparent, and affordable financial services that empower individuals and fuel business growth.',
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.grey[400] : Colors.grey[700],
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  // ── Premium Contact Credit Card Builder ──
  Widget _buildContactCreditCard(bool isDark) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [
            Color(0xFFF8FAFC),
            Color(0xFFF1F5F9),
            Color(0xFFF8FAFC),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(
          color: Colors.black.withOpacity(0.06),
        ),
      ),
      child: Stack(
        children: [
          // Tech Mesh Overlay Effect (Abstract credit card shape lines)
          Positioned(
            right: -50,
            bottom: -50,
            child: Opacity(
              opacity: 0.02,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 4),
                ),
              ),
            ),
          ),
          Positioned(
            right: 20,
            top: 20,
            child: Row(
              children: [
                // Mastercard/Visa-like luxury logo concept
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: _primaryBlue.withOpacity(0.85),
                    shape: BoxShape.circle,
                  ),
                ),
                Transform.translate(
                  offset: const Offset(-10, 0),
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: _accentGreen.withOpacity(0.85),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Removed MAGNA PLATINUM text
                const SizedBox(height: 8),
                // Golden Sim Chip simulation
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 42,
                      height: 32,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFEAB308), Color(0xFFCA8A04)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 4, left: 4, right: 4, bottom: 4,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black12, width: 0.8),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.contactless_outlined,
                      color: Colors.black38,
                      size: 24,
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                // Card details formatted beautifully
                const Text(
                  'CONTACT CHANNELS',
                  style: TextStyle(
                    color: Color(0xFF475569),
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 12),
                const _ContactRow(
                  icon: Icons.location_on_rounded,
                  text: 'Kampala, Uganda',
                  textColor: Color(0xFF1E293B),
                  iconColor: _primaryBlue,
                  iconBgColor: Color(0xFFE2E8F0),
                ),
                const _ContactRow(
                  icon: Icons.phone_rounded,
                  text: '+256 700 123456',
                  textColor: Color(0xFF1E293B),
                  iconColor: _primaryBlue,
                  iconBgColor: Color(0xFFE2E8F0),
                ),
                const _ContactRow(
                  icon: Icons.email_rounded,
                  text: 'info@magnacredit.com',
                  textColor: Color(0xFF1E293B),
                  iconColor: _primaryBlue,
                  iconBgColor: Color(0xFFE2E8F0),
                ),
                const _ContactRow(
                  icon: Icons.language_rounded,
                  text: 'www.magnacredit.com',
                  textColor: Color(0xFF1E293B),
                  iconColor: _primaryBlue,
                  iconBgColor: Color(0xFFE2E8F0),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'MEMBER: AMFIU',
                      style: TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                    Text(
                      'SECURE CONNECTION',
                      style: TextStyle(
                        color: Color(0xFF059669),
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Vision/Mission Cards ────────────────────────────────────────
class _MiniCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;
  final Gradient gradient;
  final Color accentColor;
  final bool isDark;

  const _MiniCard({
    required this.icon,
    required this.title,
    required this.text,
    required this.gradient,
    required this.accentColor,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: accentColor.withOpacity(isDark ? 0.15 : 0.08)),
        boxShadow: [
          BoxShadow(
            color: accentColor.withOpacity(isDark ? 0.02 : 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E293B) : Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: accentColor.withOpacity(0.12),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(icon, color: accentColor, size: 20),
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w800,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: TextStyle(
              color: isDark ? Colors.grey[400] : Colors.black54,
              fontSize: 12,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Loan Item Data Holder ────────────────────────────────────────
class _LoanItem {
  final IconData icon;
  final String label;
  final String desc;
  final String badge;
  final Color badgeColor;

  const _LoanItem({
    required this.icon,
    required this.label,
    required this.desc,
    required this.badge,
    required this.badgeColor,
  });
}

// ── Financial Solutions Card ──────────────────────────────────────
class _SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final bool isDark;
  final List<_LoanItem> items;

  const _SectionCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.isDark,
    required this.items,
  });

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
                  gradient: LinearGradient(
                    colors: [color, const Color(0xFF1BBE6D)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Icon(icon, color: color, size: 20),
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
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Divider(color: isDark ? Colors.white.withOpacity(0.06) : Colors.black.withOpacity(0.05)),
            ),
            itemBuilder: (context, index) {
              final item = items[index];
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.08),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(item.icon, color: color, size: 20),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              item.label,
                              style: TextStyle(
                                color: isDark ? Colors.white : Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: item.badgeColor.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: item.badgeColor.withOpacity(0.2), width: 0.5),
                              ),
                              child: Text(
                                item.badge,
                                style: TextStyle(
                                  color: item.badgeColor,
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.desc,
                          style: TextStyle(
                            color: isDark ? Colors.grey[400] : Colors.black54,
                            fontSize: 12,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: isDark ? Colors.white30 : Colors.black26,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

// ── Core Values Section ──────────────────────────────────────────
class _ValuesCard extends StatelessWidget {
  final bool isDark;
  static const Color _blue  = Color(0xFF007BFF);
  static const Color _green = Color(0xFF1BBE6D);

  const _ValuesCard({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final values = [
      _ValueTile(icon: Icons.handshake_rounded, label: 'Integrity', color: _blue),
      _ValueTile(icon: Icons.favorite_rounded, label: 'Customer-First', color: _green),
      _ValueTile(icon: Icons.lightbulb_rounded, label: 'Innovation', color: _blue),
      _ValueTile(icon: Icons.remove_red_eye_rounded, label: 'Transparency', color: _green),
    ];

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
                    colors: [_blue, _green],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              const Icon(Icons.stars_rounded, color: _blue, size: 20),
              const SizedBox(width: 8),
              Text(
                'Our Core Values',
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 2.3,
            children: values.map((v) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: v.color.withOpacity(0.06),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: v.color.withOpacity(isDark ? 0.15 : 0.08)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: v.color.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(v.icon, color: v.color, size: 18),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      v.label,
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black87,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }
}

class _ValueTile {
  final IconData icon;
  final String label;
  final Color color;
  const _ValueTile({required this.icon, required this.label, required this.color});
}

// ── Contact Row (Formatted for Credit Card Layout) ─────────────────
class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color textColor;
  final Color iconColor;
  final Color iconBgColor;

  const _ContactRow({
    required this.icon,
    required this.text,
    this.textColor = Colors.white,
    this.iconColor = Colors.white,
    this.iconBgColor = const Color(0x1AFFFFFF),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 14),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
