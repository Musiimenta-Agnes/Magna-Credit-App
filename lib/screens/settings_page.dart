

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_controller.dart';
import 'profile_page.dart';
import 'forgot_password_page.dart';
import 'terms_and_policy.dart';
import 'about_screen.dart';
import 'help_faq_page.dart';
import 'contact_support_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const Color _blue = Color(0xFF007BFF);
  static const Color _green = Colors.green;

  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<ThemeController>();
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
        title: const Text(
          "Settings",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            letterSpacing: 0.4,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(3),
          child: Container(
            height: 3,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [_blue, _green]),
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(18, 24, 18, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ── Appearance ──
            _SectionHeader(label: "Appearance", isDark: isDark),
            const SizedBox(height: 10),
            _SettingsCard(
              isDark: isDark,
              children: [
                _ThemeOption(
                  icon: Icons.phone_android_rounded,
                  label: "System Default",
                  subtitle: "Follow device setting",
                  isActive: themeController.themeMode == ThemeMode.system,
                  onTap: () => themeController.setSystemMode(),
                  isDark: isDark,
                ),
                _Divider(isDark: isDark),
                _ThemeOption(
                  icon: Icons.wb_sunny_rounded,
                  label: "Light Mode",
                  subtitle: "Always use light theme",
                  isActive: themeController.themeMode == ThemeMode.light,
                  onTap: () => themeController.setLightMode(),
                  isDark: isDark,
                ),
                _Divider(isDark: isDark),
                _ThemeOption(
                  icon: Icons.nightlight_round,
                  label: "Dark Mode",
                  subtitle: "Always use dark theme",
                  isActive: themeController.themeMode == ThemeMode.dark,
                  onTap: () => themeController.setDarkMode(),
                  isDark: isDark,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ── Account ──
            _SectionHeader(label: "Account", isDark: isDark),
            const SizedBox(height: 10),
            _SettingsCard(
              isDark: isDark,
              children: [
                _SettingsTile(
                  icon: Icons.person_rounded,
                  label: "Edit Profile",
                  iconColor: _blue,
                  isDark: isDark,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ProfilePage()),
                  ),
                ),
                _Divider(isDark: isDark),
                _SettingsTile(
                  icon: Icons.lock_rounded,
                  label: "Change Password",
                  iconColor: _blue,
                  isDark: isDark,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ForgotPasswordPage()),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ── Notifications ──
            _SectionHeader(label: "Notifications", isDark: isDark),
            const SizedBox(height: 10),
            _SettingsCard(
              isDark: isDark,
              children: [
                _SwitchTile(
                  icon: Icons.notifications_rounded,
                  label: "Push Notifications",
                  subtitle: "Loan updates & alerts",
                  iconColor: _green,
                  isDark: isDark,
                ),
                _Divider(isDark: isDark),
                _SwitchTile(
                  icon: Icons.email_rounded,
                  label: "Email Notifications",
                  subtitle: "Receive updates via email",
                  iconColor: _green,
                  isDark: isDark,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ── Support ──
            _SectionHeader(label: "Support", isDark: isDark),
            const SizedBox(height: 10),
            _SettingsCard(
              isDark: isDark,
              children: [
                _SettingsTile(
                  icon: Icons.help_outline_rounded,
                  label: "Help & FAQ",
                  iconColor: _blue,
                  isDark: isDark,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const HelpFaqPage()),
                  ),
                ),
                _Divider(isDark: isDark),
                _SettingsTile(
                  icon: Icons.headset_mic_rounded,
                  label: "Contact Support",
                  iconColor: _blue,
                  isDark: isDark,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ContactSupportPage()),
                  ),
                ),
                _Divider(isDark: isDark),
                _SettingsTile(
                  icon: Icons.description_rounded,
                  label: "Terms & Privacy Policy",
                  iconColor: _blue,
                  isDark: isDark,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const TermsPoliciesPage()),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ── About ──
            _SectionHeader(label: "About", isDark: isDark),
            const SizedBox(height: 10),
            _SettingsCard(
              isDark: isDark,
              children: [
                _SettingsTile(
                  icon: Icons.info_outline_rounded,
                  label: "About Magna Credit",
                  iconColor: _green,
                  isDark: isDark,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AboutPage()),
                  ),
                ),
                _Divider(isDark: isDark),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: _green.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.verified_rounded,
                            color: _green, size: 18),
                      ),
                      const SizedBox(width: 14),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "App Version",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                          Text(
                            "v1.0.0",
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark ? Colors.white38 : Colors.black38,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ── Logout button ──
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    backgroundColor: isDark ? Colors.grey[900] : Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    title: Text(
                      "Log Out",
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: Text(
                      "Are you sure you want to log out?",
                      style: TextStyle(
                        color: isDark ? Colors.white60 : Colors.black54,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel",
                            style: TextStyle(color: _blue)),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          // TODO: add your logout logic here
                        },
                        child: const Text("Log Out",
                            style: TextStyle(color: Colors.redAccent)),
                      ),
                    ],
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.redAccent.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.redAccent.withOpacity(0.3)),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout_rounded, color: Colors.redAccent, size: 20),
                    SizedBox(width: 10),
                    Text(
                      "Log Out",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.redAccent,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Section Header ──
class _SectionHeader extends StatelessWidget {
  final String label;
  final bool isDark;
  const _SectionHeader({required this.label, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 16,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF007BFF), Colors.green],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white54 : Colors.black45,
            letterSpacing: 0.8,
          ),
        ),
      ],
    );
  }
}

// ── Settings Card container ──
class _SettingsCard extends StatelessWidget {
  final List<Widget> children;
  final bool isDark;
  const _SettingsCard({required this.children, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }
}

// ── Theme Option tile ──
class _ThemeOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final bool isActive;
  final VoidCallback onTap;
  final bool isDark;

  static const Color _blue = Color(0xFF007BFF);
  static const Color _green = Colors.green;

  const _ThemeOption({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.isActive,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isActive ? _blue.withOpacity(0.05) : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isActive
                    ? _blue.withOpacity(0.12)
                    : (isDark
                        ? Colors.white.withOpacity(0.07)
                        : Colors.grey.shade100),
                shape: BoxShape.circle,
              ),
              child: Icon(icon,
                  color: isActive ? _blue : Colors.grey, size: 18),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isActive
                          ? _blue
                          : (isDark ? Colors.white : Colors.black87),
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 11,
                      color: isDark ? Colors.white38 : Colors.black38,
                    ),
                  ),
                ],
              ),
            ),
            if (isActive)
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: _green,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_rounded,
                    color: Colors.white, size: 12),
              ),
          ],
        ),
      ),
    );
  }
}

// ── Regular Settings Tile ──
class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;
  final bool isDark;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.label,
    required this.iconColor,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 18),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: isDark ? Colors.white24 : Colors.black26,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}

// ── Switch Tile ──
class _SwitchTile extends StatefulWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final Color iconColor;
  final bool isDark;

  const _SwitchTile({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.iconColor,
    required this.isDark,
  });

  @override
  State<_SwitchTile> createState() => _SwitchTileState();
}

class _SwitchTileState extends State<_SwitchTile> {
  bool _value = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: widget.iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(widget.icon, color: widget.iconColor, size: 18),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: widget.isDark ? Colors.white : Colors.black87,
                  ),
                ),
                Text(
                  widget.subtitle,
                  style: TextStyle(
                    fontSize: 11,
                    color: widget.isDark ? Colors.white38 : Colors.black38,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: _value,
            activeThumbColor: Colors.green,
            onChanged: (val) => setState(() => _value = val),
          ),
        ],
      ),
    );
  }
}

// ── Thin divider ──
class _Divider extends StatelessWidget {
  final bool isDark;
  const _Divider({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      color: isDark
          ? Colors.white.withOpacity(0.06)
          : Colors.black.withOpacity(0.05),
    );
  }
}



