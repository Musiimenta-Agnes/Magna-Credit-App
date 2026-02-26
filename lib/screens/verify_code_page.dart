

import 'package:flutter/material.dart';
import 'reset_password_page.dart';

class VerifyCodePage extends StatefulWidget {
  final String email;

  const VerifyCodePage({super.key, required this.email});

  @override
  State<VerifyCodePage> createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends State<VerifyCodePage> {
  final TextEditingController codeController = TextEditingController();
  bool isLoading = false;

  static const Color _blue = Color(0xFF007BFF);
  static const Color _green = Colors.green;

  Future<void> verifyCode() async {
    final String token = codeController.text.trim();

    if (token.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter verification code")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResetPasswordPage(
            email: widget.email,
            token: token,
            code: '',
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Server error. Try again.")),
      );
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: _blue,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Verify Code",
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
        padding: const EdgeInsets.fromLTRB(22, 40, 22, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ── Icon badge ──
            Center(
              child: Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: _green.withOpacity(0.08),
                  shape: BoxShape.circle,
                  border: Border.all(color: _green.withOpacity(0.25)),
                ),
                child: const Icon(
                  Icons.mark_email_read_rounded,
                  color: _green,
                  size: 44,
                ),
              ),
            ),

            const SizedBox(height: 24),

            const Center(
              child: Text(
                "Verification Code",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                  letterSpacing: 0.3,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                "Enter the code sent to your email",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black45,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 12),

            // ── Email display chip ──
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: _blue.withOpacity(0.07),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _blue.withOpacity(0.2)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.email_rounded, color: _blue, size: 14),
                    const SizedBox(width: 6),
                    Text(
                      widget.email,
                      style: const TextStyle(
                        color: _blue,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 36),

            // ── Code field ──
            const _FieldLabel(label: "Verification Code"),
            const SizedBox(height: 6),
            TextField(
              controller: codeController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.text,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                letterSpacing: 8,
              ),
              decoration: InputDecoration(
                hintText: "- - - - - -",
                hintStyle: TextStyle(
                  color: Colors.black26,
                  fontSize: 18,
                  letterSpacing: 6,
                ),
                filled: true,
                fillColor: const Color(0xFFF5F8FF),
                contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFD0E4FF)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: _blue, width: 1.5),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // ── Verify button ──
            GestureDetector(
              onTap: isLoading ? null : verifyCode,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: _green,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.28),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: isLoading
                    ? const Center(
                        child: SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        ),
                      )
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.verified_rounded, color: Colors.white, size: 20),
                          SizedBox(width: 10),
                          Text(
                            "Verify",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
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

class _FieldLabel extends StatelessWidget {
  final String label;
  const _FieldLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
        letterSpacing: 0.2,
      ),
    );
  }
}



