
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'verify_code_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  bool isLoading = false;

  static const Color _blue = Color(0xFF007BFF);
  static const Color _green = Colors.green;

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

  Future<void> sendResetLink() async {
    final String email = emailController.text.trim();

    if (email.isEmpty) {
      _showTopNotification(
        '⚠️ Please enter your email',
        bgColor: Colors.orange,
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final response = await http.post(
        Uri.parse("http://127.0.0.1:8000/api/forgot-password"),
        headers: {"Accept": "application/json"},
        body: {"email": email},
      );

      final data = jsonDecode(response.body);

      // ── Check the response body directly since Laravel returns 200 for everything ──
      // Success = no 'success:false' field AND no 'exception' field
      final bool isSuccess = data['success'] != false &&
          !data.containsKey('exception') &&
          data['message'] ==
              'A 6-digit verification code has been sent to your email.';

      if (isSuccess) {
        // ✅ Email actually sent — navigate to verify page
        _showTopNotification('✅ Code sent! Check your email.');
        Future.delayed(const Duration(milliseconds: 800), () {
          if (mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VerifyCodePage(email: email),
              ),
            );
          }
        });
      } else {
        // ❌ Show the actual error message from backend
        _showTopNotification(
          data['message'] ?? '❌ Something went wrong',
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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,

      appBar: AppBar(
        backgroundColor: _blue,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Forgot Password",
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
        padding: const EdgeInsets.fromLTRB(22, 50, 22, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Center(
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: _blue.withOpacity(0.1),
                  shape: BoxShape.circle,
                  border: Border.all(color: _blue.withOpacity(0.25)),
                ),
                child: const Icon(
                  Icons.lock_reset_rounded,
                  color: _blue,
                  size: 48,
                ),
              ),
            ),

            const SizedBox(height: 28),

            Center(
              child: Text(
                "Forgot Password?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: isDark ? Colors.white : Colors.black87,
                  letterSpacing: 0.3,
                ),
              ),
            ),

            const SizedBox(height: 10),

            Center(
              child: Text(
                "Enter your email to receive a\nverification code",
                style: TextStyle(
                  fontSize: 13,
                  color: isDark ? Colors.white54 : Colors.black45,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 40),

            Text(
              "Email Address",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white70 : Colors.black87,
                letterSpacing: 0.2,
              ),
            ),
            const SizedBox(height: 6),

            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black87,
                fontSize: 14,
              ),
              decoration: InputDecoration(
                prefixIcon:
                    const Icon(Icons.email_rounded, color: _blue, size: 20),
                hintText: "Enter your email",
                hintStyle: TextStyle(
                  color: isDark ? Colors.white38 : Colors.black38,
                  fontSize: 14,
                ),
                filled: true,
                fillColor:
                    isDark ? Colors.grey[900] : const Color(0xFFF5F8FF),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 14, horizontal: 16),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: isDark
                        ? Colors.white12
                        : const Color(0xFFD0E4FF),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: _blue, width: 1.5),
                ),
              ),
            ),

            const SizedBox(height: 36),

            GestureDetector(
              onTap: isLoading ? null : sendResetLink,
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
                          Icon(Icons.send_rounded,
                              color: Colors.white, size: 20),
                          SizedBox(width: 10),
                          Text(
                            "Send Code",
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











// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'verify_code_page.dart';

// class ForgotPasswordPage extends StatefulWidget {
//   const ForgotPasswordPage({super.key});

//   @override
//   State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
// }

// class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
//   final TextEditingController emailController = TextEditingController();
//   bool isLoading = false;

//   static const Color _blue = Color(0xFF007BFF);
//   static const Color _green = Colors.green;

//   // ── Shows notification from the TOP of the screen ──
//   void _showTopNotification(String message, {Color bgColor = Colors.green}) {
//     final overlay = Overlay.of(context);
//     final overlayEntry = OverlayEntry(
//       builder: (context) => Positioned(
//         top: MediaQuery.of(context).padding.top + 10,
//         left: 20,
//         right: 20,
//         child: Material(
//           color: Colors.transparent,
//           child: Container(
//             padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//             decoration: BoxDecoration(
//               color: bgColor,
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: [
//                 BoxShadow(
//                   color: bgColor.withOpacity(0.3),
//                   blurRadius: 12,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: Center(
//               child: Text(
//                 message,
//                 style: const TextStyle(color: Colors.white, fontSize: 14),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );

//     overlay.insert(overlayEntry);
//     Future.delayed(const Duration(seconds: 3), () => overlayEntry.remove());
//   }

//   Future<void> sendResetLink() async {
//     final String email = emailController.text.trim();

//     if (email.isEmpty) {
//       _showTopNotification(
//         '⚠️ Please enter your email',
//         bgColor: Colors.orange,
//       );
//       return;
//     }

//     setState(() => isLoading = true);

//     try {
//       final response = await http.post(
//         Uri.parse("http://127.0.0.1:8000/api/forgot-password"),
//         headers: {"Accept": "application/json"},
//         body: {"email": email},
//       );

//       final data = jsonDecode(response.body);

//       if (response.statusCode == 200) {
//         // ✅ Email sent successfully — NOW navigate to verify page
//         _showTopNotification('✅ Code sent! Check your email.');
//         Future.delayed(const Duration(milliseconds: 800), () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => VerifyCodePage(email: email),
//             ),
//           );
//         });
//       } else if (response.statusCode == 404) {
//         // ❌ Email not found in database
//         _showTopNotification(
//           '❌ No account found with that email',
//           bgColor: Colors.redAccent,
//         );
//       } else if (response.statusCode == 429) {
//         // ❌ Too many requests
//         _showTopNotification(
//           '⚠️ Too many requests. Please wait.',
//           bgColor: Colors.orange,
//         );
//       } else {
//         // ❌ Any other error
//         _showTopNotification(
//           data['message'] ?? '❌ Something went wrong',
//           bgColor: Colors.redAccent,
//         );
//       }
//     } catch (e) {
//       _showTopNotification(
//         '❌ Server error. Please try again.',
//         bgColor: Colors.redAccent,
//       );
//     }

//     setState(() => isLoading = false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;

//     return Scaffold(
//       backgroundColor: isDark ? Colors.black : Colors.white,

//       appBar: AppBar(
//         backgroundColor: _blue,
//         elevation: 0,
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           "Forgot Password",
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
//         padding: const EdgeInsets.fromLTRB(22, 50, 22, 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [

//             // ── Centered icon badge ──
//             Center(
//               child: Container(
//                 padding: const EdgeInsets.all(24),
//                 decoration: BoxDecoration(
//                   color: _blue.withOpacity(0.1),
//                   shape: BoxShape.circle,
//                   border: Border.all(color: _blue.withOpacity(0.25)),
//                 ),
//                 child: const Icon(
//                   Icons.lock_reset_rounded,
//                   color: _blue,
//                   size: 48,
//                 ),
//               ),
//             ),

//             const SizedBox(height: 28),

//             Center(
//               child: Text(
//                 "Forgot Password?",
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.w800,
//                   color: isDark ? Colors.white : Colors.black87,
//                   letterSpacing: 0.3,
//                 ),
//               ),
//             ),

//             const SizedBox(height: 10),

//             Center(
//               child: Text(
//                 "Enter your email to receive a\nverification code",
//                 style: TextStyle(
//                   fontSize: 13,
//                   color: isDark ? Colors.white54 : Colors.black45,
//                   height: 1.6,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),

//             const SizedBox(height: 40),

//             // ── Label ──
//             Text(
//               "Email Address",
//               style: TextStyle(
//                 fontSize: 13,
//                 fontWeight: FontWeight.w600,
//                 color: isDark ? Colors.white70 : Colors.black87,
//                 letterSpacing: 0.2,
//               ),
//             ),
//             const SizedBox(height: 6),

//             // ── Email field ──
//             TextField(
//               controller: emailController,
//               keyboardType: TextInputType.emailAddress,
//               style: TextStyle(
//                 color: isDark ? Colors.white : Colors.black87,
//                 fontSize: 14,
//               ),
//               decoration: InputDecoration(
//                 prefixIcon:
//                     const Icon(Icons.email_rounded, color: _blue, size: 20),
//                 hintText: "Enter your email",
//                 hintStyle: TextStyle(
//                   color: isDark ? Colors.white38 : Colors.black38,
//                   fontSize: 14,
//                 ),
//                 filled: true,
//                 fillColor:
//                     isDark ? Colors.grey[900] : const Color(0xFFF5F8FF),
//                 contentPadding: const EdgeInsets.symmetric(
//                     vertical: 14, horizontal: 16),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: BorderSide(
//                     color: isDark
//                         ? Colors.white12
//                         : const Color(0xFFD0E4FF),
//                   ),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide:
//                       const BorderSide(color: _blue, width: 1.5),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 36),

//             // ── Send Code button ──
//             GestureDetector(
//               onTap: isLoading ? null : sendResetLink,
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
//                           Icon(Icons.send_rounded,
//                               color: Colors.white, size: 20),
//                           SizedBox(width: 10),
//                           Text(
//                             "Send Code",
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