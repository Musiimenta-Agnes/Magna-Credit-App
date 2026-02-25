import 'package:flutter/material.dart';

class HelpFaqPage extends StatefulWidget {
  const HelpFaqPage({super.key});

  @override
  State<HelpFaqPage> createState() => _HelpFaqPageState();
}

class _HelpFaqPageState extends State<HelpFaqPage> {
  static const Color _blue = Color(0xFF007BFF);
  static const Color _green = Colors.green;

  final List<Map<String, String>> _faqs = const [
    {
      "q": "How do I apply for a loan?",
      "a":
          "To apply for a loan, tap 'Apply for a Loan' on the Home screen. You will be guided through our simple application process. Make sure you have your national ID and any required documents ready.",
    },
    {
      "q": "What types of loans does Magna Credit offer?",
      "a":
          "We offer Personal Loans, Business Loans, Logbook Loans, Investment Loans, and Car Loans. Each loan type is designed to meet specific financial needs — visit the About page for full details.",
    },
    {
      "q": "How long does loan approval take?",
      "a":
          "Our approval process is fast — most applications receive a decision within 24 hours. In some cases, additional verification may be required which can take slightly longer.",
    },
    {
      "q": "What are the eligibility requirements?",
      "a":
          "Eligibility varies by loan type but generally includes: being 18 years or older, having a valid national ID, proof of income or business activity, and a good repayment history.",
    },
    {
      "q": "Are there any hidden fees?",
      "a":
          "No. Magna Credit is committed to full transparency. All fees, interest rates, and repayment terms are clearly disclosed before you accept any loan offer.",
    },
    {
      "q": "How is my loan disbursed?",
      "a":
          "Once approved, funds are disbursed directly to your registered mobile money account or bank account, typically within 24 hours of approval.",
    },
    {
      "q": "How do I repay my loan?",
      "a":
          "Repayments can be made via mobile money, bank transfer, or through our app. You will receive reminders before each due date to help you stay on track.",
    },
    {
      "q": "What happens if I miss a repayment?",
      "a":
          "If you miss a repayment, please contact our support team immediately. Late payments may attract penalty fees. We encourage you to communicate early so we can find a suitable arrangement.",
    },
    {
      "q": "Is my personal data safe?",
      "a":
          "Yes. We use 256-bit encryption and industry-standard security protocols to protect all your personal and financial data at every step.",
    },
    {
      "q": "How do I update my account information?",
      "a":
          "You can update your profile details by going to Settings → Edit Profile or by visiting the Profile page directly from the bottom navigation bar.",
    },
    {
      "q": "How do I reset my password?",
      "a":
          "Go to Settings → Change Password. You will be redirected to our secure password reset flow where you can create a new password using your registered email or phone number.",
    },
    {
      "q": "How do I contact Magna Credit support?",
      "a":
          "You can reach us via phone at +256 700 123456, by email at info@magnacredit.com, or through the Contact Support page found in Settings → Support.",
    },
  ];

  final Set<int> _expanded = {};

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
          "Help & FAQ",
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
              padding: const EdgeInsets.all(20),
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
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.help_outline_rounded,
                        color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Frequently Asked Questions",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Find quick answers to common questions below.",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ── Section label ──
            Row(
              children: [
                Text(
                  "ALL QUESTIONS",
                  style: TextStyle(
                    color: textSecondary,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    height: 1,
                    color: textSecondary.withOpacity(0.2),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // ── FAQ items ──
            ...List.generate(_faqs.length, (i) {
              final isOpen = _expanded.contains(i);
              return GestureDetector(
                onTap: () => setState(() {
                  if (isOpen) {
                    _expanded.remove(i);
                  } else {
                    _expanded.add(i);
                  }
                }),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isOpen
                          ? _blue.withOpacity(0.3)
                          : (isDark
                              ? Colors.white.withOpacity(0.06)
                              : const Color(0xFFE8EAEE)),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: isOpen
                            ? _blue.withOpacity(0.08)
                            : Colors.black.withOpacity(0.04),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Question row
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: isOpen
                                    ? _blue.withOpacity(0.12)
                                    : (isDark
                                        ? Colors.white.withOpacity(0.07)
                                        : const Color(0xFFF0F4FF)),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                isOpen
                                    ? Icons.remove_rounded
                                    : Icons.add_rounded,
                                color: isOpen ? _blue : textSecondary,
                                size: 16,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                _faqs[i]["q"]!,
                                style: TextStyle(
                                  color: isOpen ? _blue : textPrimary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  height: 1.3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Answer
                      if (isOpen)
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: _blue.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: _blue.withOpacity(0.1)),
                          ),
                          child: Text(
                            _faqs[i]["a"]!,
                            style: TextStyle(
                              color: textSecondary,
                              fontSize: 13,
                              height: 1.6,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }),

            const SizedBox(height: 10),

            // ── Still need help? ──
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                    color: _green.withOpacity(0.2)),
                boxShadow: [
                  BoxShadow(
                    color: _green.withOpacity(0.06),
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _green.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.headset_mic_rounded,
                        color: _green, size: 22),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Still need help?",
                          style: TextStyle(
                            color: textPrimary,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "Our support team is ready to assist you.",
                          style: TextStyle(
                              color: textSecondary, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios_rounded,
                      color: _green.withOpacity(0.5), size: 14),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}