

// import 'package:flutter/material.dart';
// import 'reset_password_page.dart';

// class VerifyCodePage extends StatefulWidget {
//   final String email;

//   const VerifyCodePage({super.key, required this.email});

//   @override
//   State<VerifyCodePage> createState() => _VerifyCodePageState();
// }

// class _VerifyCodePageState extends State<VerifyCodePage> {
//   final TextEditingController codeController = TextEditingController();
//   bool isLoading = false;

//   static const Color _blue = Color(0xFF007BFF);
//   static const Color _green = Colors.green;

//   Future<void> verifyCode() async {
//     final String token = codeController.text.trim();

//     if (token.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please enter verification code")),
//       );
//       return;
//     }

//     setState(() => isLoading = true);

//     try {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ResetPasswordPage(
//             email: widget.email,
//             token: token,
//             code: '',
//           ),
//         ),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Server error. Try again.")),
//       );
//     }

//     setState(() => isLoading = false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,

//       appBar: AppBar(
//         backgroundColor: _blue,
//         elevation: 0,
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           "Verify Code",
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 18,
//             letterSpacing: 0.4,
//           ),
//         ),
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(3),
//           child: Container(
//             height: 3,
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(colors: [_blue, _green]),
//             ),
//           ),
//         ),
//       ),

//       body: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         padding: const EdgeInsets.fromLTRB(22, 40, 22, 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [

//             // ── Icon badge ──
//             Center(
//               child: Container(
//                 padding: const EdgeInsets.all(22),
//                 decoration: BoxDecoration(
//                   color: _green.withOpacity(0.08),
//                   shape: BoxShape.circle,
//                   border: Border.all(color: _green.withOpacity(0.25)),
//                 ),
//                 child: const Icon(
//                   Icons.mark_email_read_rounded,
//                   color: _green,
//                   size: 44,
//                 ),
//               ),
//             ),

//             const SizedBox(height: 24),

//             const Center(
//               child: Text(
//                 "Verification Code",
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.w800,
//                   color: Colors.black87,
//                   letterSpacing: 0.3,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 8),
//             Center(
//               child: Text(
//                 "Enter the code sent to your email",
//                 style: TextStyle(
//                   fontSize: 13,
//                   color: Colors.black45,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),

//             const SizedBox(height: 12),

//             // ── Email display chip ──
//             Center(
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
//                 decoration: BoxDecoration(
//                   color: _blue.withOpacity(0.07),
//                   borderRadius: BorderRadius.circular(20),
//                   border: Border.all(color: _blue.withOpacity(0.2)),
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const Icon(Icons.email_rounded, color: _blue, size: 14),
//                     const SizedBox(width: 6),
//                     Text(
//                       widget.email,
//                       style: const TextStyle(
//                         color: _blue,
//                         fontSize: 13,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             const SizedBox(height: 36),

//             // ── Code field ──
//             const _FieldLabel(label: "Verification Code"),
//             const SizedBox(height: 6),
//             TextField(
//               controller: codeController,
//               textAlign: TextAlign.center,
//               keyboardType: TextInputType.text,
//               style: const TextStyle(
//                 color: Colors.black87,
//                 fontSize: 20,
//                 fontWeight: FontWeight.w700,
//                 letterSpacing: 8,
//               ),
//               decoration: InputDecoration(
//                 hintText: "- - - - - -",
//                 hintStyle: TextStyle(
//                   color: Colors.black26,
//                   fontSize: 18,
//                   letterSpacing: 6,
//                 ),
//                 filled: true,
//                 fillColor: const Color(0xFFF5F8FF),
//                 contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: const BorderSide(color: Color(0xFFD0E4FF)),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: const BorderSide(color: _blue, width: 1.5),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 32),

//             // ── Verify button ──
//             GestureDetector(
//               onTap: isLoading ? null : verifyCode,
//               child: Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.symmetric(vertical: 15),
//                 decoration: BoxDecoration(
//                   color: _green,
//                   borderRadius: BorderRadius.circular(14),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.green.withOpacity(0.28),
//                       blurRadius: 16,
//                       offset: const Offset(0, 6),
//                     ),
//                   ],
//                 ),
//                 child: isLoading
//                     ? const Center(
//                         child: SizedBox(
//                           width: 22,
//                           height: 22,
//                           child: CircularProgressIndicator(
//                             color: Colors.white,
//                             strokeWidth: 2.5,
//                           ),
//                         ),
//                       )
//                     : const Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Icons.verified_rounded, color: Colors.white, size: 20),
//                           SizedBox(width: 10),
//                           Text(
//                             "Verify",
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.white,
//                               fontWeight: FontWeight.w700,
//                               letterSpacing: 0.5,
//                             ),
//                           ),
//                         ],
//                       ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _FieldLabel extends StatelessWidget {
//   final String label;
//   const _FieldLabel({required this.label});

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       label,
//       style: const TextStyle(
//         fontSize: 13,
//         fontWeight: FontWeight.w600,
//         color: Colors.black87,
//         letterSpacing: 0.2,
//       ),
//     );
//   }
// }




import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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

  // ── Shows notification from the TOP of the screen ──
  void _showTopNotification(String message, {Color bgColor = Colors.green}) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 10,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: bgColor.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    Future.delayed(const Duration(seconds: 3), () => overlayEntry.remove());
  }

  // ── Calls the backend to verify the code ──
  Future<void> verifyCode() async {
    final String token = codeController.text.trim();

    if (token.isEmpty) {
      _showTopNotification(
        '⚠️ Please enter the verification code',
        bgColor: Colors.orange,
      );
      return;
    }

    if (token.length != 6) {
      _showTopNotification(
        '⚠️ Code must be 6 digits',
        bgColor: Colors.orange,
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final response = await http.post(
        Uri.parse("http://127.0.0.1:8000/api/verify-reset-token"),
        headers: {"Accept": "application/json"},
        body: {
          "email": widget.email,
          "token": token,
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // ✅ Code is valid — navigate to reset password page
        _showTopNotification('✅ Code verified!');
        Future.delayed(const Duration(milliseconds: 800), () {
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
        });
      } else {
        // ❌ Invalid or expired code — show error from top
        _showTopNotification(
          data['message'] ?? '❌ Invalid verification code',
          bgColor: Colors.redAccent,
        );
      }
    } catch (e) {
      _showTopNotification(
        '❌ Server error. Please try again.',
        bgColor: Colors.redAccent,
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
            const Center(
              child: Text(
                "Enter the 6-digit code sent to your email",
                style: TextStyle(fontSize: 13, color: Colors.black45),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 12),

            // ── Email display chip ──
            Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
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
              keyboardType: TextInputType.number,
              maxLength: 6,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                letterSpacing: 8,
              ),
              decoration: InputDecoration(
                counterText: '', // hides the character counter
                hintText: "- - - - - -",
                hintStyle: const TextStyle(
                  color: Colors.black26,
                  fontSize: 18,
                  letterSpacing: 6,
                ),
                filled: true,
                fillColor: const Color(0xFFF5F8FF),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
                          Icon(Icons.verified_rounded,
                              color: Colors.white, size: 20),
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

