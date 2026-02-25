import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ContactSupportPage extends StatelessWidget {
  const ContactSupportPage({super.key});

  static const Color _blue = Color(0xFF007BFF);
  static const Color _green = Colors.green;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF0A0A0F) : const Color(0xFFF7F8FC);
    final cardColor = isDark ? const Color(0xFF13131A) : Colors.white;
    final textPrimary = isDark ? Colors.white : const Color(0xFF0D0D1A);
    final textSecondary = isDark ? const Color(0xFF8888AA) : const Color(0xFF888899);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: _blue,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Contact Support",
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

            // ── Header banner ──
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF0057D9), Color(0xFF00C896)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: _blue.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.support_agent_rounded,
                        color: Colors.white, size: 28),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    "We're here to help",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Reach out to the Magna Credit team through any of the channels below. We typically respond within 24 hours.",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // ── Section label ──
            _SectionLabel(text: "Contact Channels", textSecondary: textSecondary),
            const SizedBox(height: 14),

            // ── Contact cards ──
            _ContactCard(
              icon: Icons.phone_rounded,
              label: "Phone",
              value: "+256 700 123456",
              actionLabel: "Call Now",
              actionIcon: Icons.call_rounded,
              accent: _blue,
              cardColor: cardColor,
              textPrimary: textPrimary,
              textSecondary: textSecondary,
              isDark: isDark,
              onCopy: () => _copy(context, "+256 700 123456"),
            ),

            const SizedBox(height: 12),

            _ContactCard(
              icon: Icons.email_rounded,
              label: "Email",
              value: "info@magnacredit.com",
              actionLabel: "Send Email",
              actionIcon: Icons.send_rounded,
              accent: _green,
              cardColor: cardColor,
              textPrimary: textPrimary,
              textSecondary: textSecondary,
              isDark: isDark,
              onCopy: () => _copy(context, "info@magnacredit.com"),
            ),

            const SizedBox(height: 12),

            _ContactCard(
              icon: Icons.language_rounded,
              label: "Website",
              value: "www.magnacredit.com",
              actionLabel: "Visit Site",
              actionIcon: Icons.open_in_browser_rounded,
              accent: _blue,
              cardColor: cardColor,
              textPrimary: textPrimary,
              textSecondary: textSecondary,
              isDark: isDark,
              onCopy: () => _copy(context, "www.magnacredit.com"),
            ),

            const SizedBox(height: 12),

            _ContactCard(
              icon: Icons.location_on_rounded,
              label: "Office Address",
              value: "Kampala, Uganda",
              actionLabel: "Get Directions",
              actionIcon: Icons.directions_rounded,
              accent: _green,
              cardColor: cardColor,
              textPrimary: textPrimary,
              textSecondary: textSecondary,
              isDark: isDark,
              onCopy: () => _copy(context, "Kampala, Uganda"),
            ),

            const SizedBox(height: 28),

            // ── Section label ──
            _SectionLabel(text: "Business Hours", textSecondary: textSecondary),
            const SizedBox(height: 14),

            // ── Business hours card ──
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withOpacity(0.06)
                      : const Color(0xFFE8EAEE),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _HoursRow(
                    day: "Monday – Friday",
                    hours: "8:00 AM – 6:00 PM",
                    isOpen: true,
                    textPrimary: textPrimary,
                    textSecondary: textSecondary,
                  ),
                  Divider(
                    height: 20,
                    color: isDark
                        ? Colors.white.withOpacity(0.06)
                        : Colors.black.withOpacity(0.05),
                  ),
                  _HoursRow(
                    day: "Saturday",
                    hours: "9:00 AM – 2:00 PM",
                    isOpen: true,
                    textPrimary: textPrimary,
                    textSecondary: textSecondary,
                  ),
                  Divider(
                    height: 20,
                    color: isDark
                        ? Colors.white.withOpacity(0.06)
                        : Colors.black.withOpacity(0.05),
                  ),
                  _HoursRow(
                    day: "Sunday",
                    hours: "Closed",
                    isOpen: false,
                    textPrimary: textPrimary,
                    textSecondary: textSecondary,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // ── Quick message prompt ──
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: _green.withOpacity(0.07),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: _green.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _green.withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.chat_bubble_outline_rounded,
                        color: _green, size: 22),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Prefer to chat?",
                          style: TextStyle(
                            color: textPrimary,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "Send us an email and we'll get back to you shortly.",
                          style: TextStyle(
                              color: textSecondary, fontSize: 12, height: 1.4),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _copy(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Copied: $text"),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: const Color(0xFF007BFF),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

// ── Section Label ──
class _SectionLabel extends StatelessWidget {
  final String text;
  final Color textSecondary;
  const _SectionLabel({required this.text, required this.textSecondary});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text.toUpperCase(),
          style: TextStyle(
            color: textSecondary,
            fontSize: 10.5,
            fontWeight: FontWeight.w700,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(height: 1, color: textSecondary.withOpacity(0.2)),
        ),
      ],
    );
  }
}

// ── Contact Card ──
class _ContactCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String actionLabel;
  final IconData actionIcon;
  final Color accent;
  final Color cardColor;
  final Color textPrimary;
  final Color textSecondary;
  final bool isDark;
  final VoidCallback onCopy;

  const _ContactCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.actionLabel,
    required this.actionIcon,
    required this.accent,
    required this.cardColor,
    required this.textPrimary,
    required this.textSecondary,
    required this.isDark,
    required this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: accent.withOpacity(0.12)),
        boxShadow: [
          BoxShadow(
            color: accent.withOpacity(0.07),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: accent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: accent, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: textSecondary,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    color: textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          // Copy button
          GestureDetector(
            onTap: onCopy,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: accent.withOpacity(0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.copy_rounded, color: accent, size: 16),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Business Hours Row ──
class _HoursRow extends StatelessWidget {
  final String day;
  final String hours;
  final bool isOpen;
  final Color textPrimary;
  final Color textSecondary;

  const _HoursRow({
    required this.day,
    required this.hours,
    required this.isOpen,
    required this.textPrimary,
    required this.textSecondary,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Icons.circle,
              size: 7,
              color: isOpen ? Colors.green : Colors.redAccent,
            ),
            const SizedBox(width: 8),
            Text(
              day,
              style: TextStyle(
                color: textPrimary,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Text(
          hours,
          style: TextStyle(
            color: isOpen ? Colors.green : Colors.redAccent,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}