
// // import 'dart:convert';
// import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
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
//       // Do not send temporary passwords here
//       // Only validate token if you want, backend now handles expiry & reuse

//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ResetPasswordPage(
//             email: widget.email,
//             token: token, code: '',
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
//         backgroundColor: const Color(0xFF007BFF),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           "Forgot Password",
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 20,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Center(
//                 child: Container(
//                   width: 200,
//                   height: 120,
//                   decoration: BoxDecoration(
//                     color: Colors.blue.shade100,
//                     borderRadius: BorderRadius.circular(12),
//                     image: const DecorationImage(
//                       image: AssetImage('assets/verify.jpg'),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 25),
//               const Text(
//                 "Verification Code",
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.blueAccent,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               const Text(
//                 "Enter the verification code sent to your email",
//                 style: TextStyle(
//                   color: Colors.black54,
//                   fontSize: 20,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 30),
//               TextField(
//                 controller: codeController,
//                 textAlign: TextAlign.center,
//                 keyboardType: TextInputType.text,
//                 decoration: InputDecoration(
//                   hintText: "Enter Code",
//                   hintStyle: const TextStyle(color: Colors.grey),
//                   filled: true,
//                   fillColor: Colors.grey[100],
//                   contentPadding:
//                       const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: const BorderSide(color: Colors.black12),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide:
//                         const BorderSide(color: Colors.blueAccent),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 30),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: isLoading ? null : verifyCode,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green,
//                     padding: const EdgeInsets.symmetric(vertical: 14),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: isLoading
//                       ? const CircularProgressIndicator(
//                           color: Colors.white,
//                         )
//                       : const Text(
//                           "Verify",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }









// // import 'package:flutter/material.dart';
// // import 'reset_password_page.dart';
// // import 'package:http/http.dart' as http;
// // import 'dart:convert';

// // class VerifyCodePage extends StatefulWidget {
// //   final String email;
// //   const VerifyCodePage({super.key, required this.email});

// //   @override
// //   State<VerifyCodePage> createState() => _VerifyCodePageState();
// // }

// // class _VerifyCodePageState extends State<VerifyCodePage> {
// //   final TextEditingController codeController = TextEditingController();
// //   bool isLoading = false;

// //   Future<void> verifyCode() async {
// //     final code = codeController.text.trim();
// //     if (code.isEmpty) {
// //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter the code")));
// //       return;
// //     }

// //     setState(() => isLoading = true);

// //     try {
// //       final response = await http.post(
// //         Uri.parse("[http://127.0.0.1:8000/api/forgot-password/verify-code"),
// //         headers: {"Content-Type": "application/json"},
// //         body: jsonEncode({"email": widget.email, "code": code}),
// //       );

// //       final data = jsonDecode(response.body);

// //       if (response.statusCode == 200) {
// //         Navigator.push(
// //           context,
// //           MaterialPageRoute(
// //             builder: (context) => ResetPasswordPage(email: widget.email, code: code),
// //           ),
// //         );
// //       } else {
// //         ScaffoldMessenger.of(context)
// //             .showSnackBar(SnackBar(content: Text(data['message'])));
// //       }
// //     } catch (e) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //           const SnackBar(content: Text("Failed to verify code. Try again.")));
// //     } finally {
// //       setState(() => isLoading = false);
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final theme = Theme.of(context);
// //     final isDark = theme.brightness == Brightness.dark;

// //     Color background = isDark ? Colors.black : Colors.white;
// //     Color textColor = isDark ? Colors.white : Colors.black;
// //     Color subtitleColor = isDark ? Colors.white70 : Colors.black54;
// //     Color fillColor = isDark ? Colors.black12 : Colors.grey[100]!;

// //     return Scaffold(
// //       backgroundColor: background,
// //       appBar: AppBar(
// //         backgroundColor: const Color(0xFF007BFF),
// //         elevation: 0,
// //         leading: IconButton(
// //           icon: const Icon(Icons.arrow_back, color: Colors.white),
// //           onPressed: () => Navigator.pop(context),
// //         ),
// //         title: const Text(
// //           "Back to Forget Password",
// //           style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
// //         ),
// //         centerTitle: true,
// //       ),
// //       body: Center(
// //         child: SingleChildScrollView(
// //           padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
// //           child: Column(
// //             children: [
// //               Center(
// //                 child: Container(
// //                   width: 200,
// //                   height: 120,
// //                   decoration: BoxDecoration(
// //                     color: Colors.blue.shade100,
// //                     borderRadius: BorderRadius.circular(12),
// //                     image: const DecorationImage(
// //                       image: AssetImage('assets/verify.jpg'),
// //                       fit: BoxFit.cover,
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //               const SizedBox(height: 25),
// //               Text(
// //                 "Verification Code",
// //                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueAccent),
// //               ),
// //               const SizedBox(height: 10),
// //               Text(
// //                 "Enter the verification code sent to your email",
// //                 style: TextStyle(color: subtitleColor, fontSize: 20),
// //                 textAlign: TextAlign.center,
// //               ),
// //               const SizedBox(height: 30),
// //               TextField(
// //                 controller: codeController,
// //                 textAlign: TextAlign.center,
// //                 keyboardType: TextInputType.number,
// //                 style: TextStyle(color: textColor),
// //                 decoration: InputDecoration(
// //                   hintText: "Enter Code",
// //                   hintStyle: TextStyle(color: textColor.withOpacity(0.6)),
// //                   filled: true,
// //                   fillColor: fillColor,
// //                   contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
// //                   enabledBorder: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(8),
// //                     borderSide: const BorderSide(color: Colors.black12),
// //                   ),
// //                   focusedBorder: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(8),
// //                     borderSide: const BorderSide(color: Colors.blueAccent),
// //                   ),
// //                 ),
// //               ),
// //               const SizedBox(height: 30),
// //               SizedBox(
// //                 width: double.infinity,
// //                 child: ElevatedButton(
// //                   onPressed: isLoading ? null : verifyCode,
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: Colors.green,
// //                     padding: const EdgeInsets.symmetric(vertical: 14),
// //                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
// //                   ),
// //                   child: isLoading
// //                       ? const CircularProgressIndicator(color: Colors.white)
// //                       : const Text(
// //                           "Verify",
// //                           style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
// //                         ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }











// // import 'package:flutter/material.dart';
// // import 'reset_password_page.dart';

// // class VerifyCodePage extends StatelessWidget {
// //   const VerifyCodePage({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     final TextEditingController codeController = TextEditingController();

// //     return Scaffold(
// //       backgroundColor: Colors.white,

// //       // // 🔹 AppBar with Back Arrow (like Registration Page)
// //       // appBar: AppBar(
// //       //   backgroundColor: Colors.green,
// //       //   elevation: 0,
// //       //   leading: IconButton(
// //       //     icon: const Icon(Icons.arrow_back, color: Colors.white),
// //       //     onPressed: () => Navigator.pop(context),
// //       //   ),
// //       // ),

      
// //       // 🔹 UPDATED APP BAR WITH HEADING
// //       appBar: AppBar(
// //         backgroundColor: Color(0xFF007BFF),
// //         elevation: 0,

// //         // 👇 Back arrow icon (unchanged)
// //         leading: IconButton(
// //           icon: const Icon(Icons.arrow_back, color: Colors.white),
// //           onPressed: () => Navigator.pop(context),
// //         ),

// //         //  NEW: Add a title to show the previous page name
// //         // You can customize the text here to match the actual previous page title.
// //         title: const Text(
// //           "Forgot Password", // 🟢 Example: Name of previous page (change as needed)
// //           style: TextStyle(
// //             color: Colors.white, // makes the title text white
// //             fontSize: 20,
// //             fontWeight: FontWeight.w600,
// //           ),
// //         ),

// //         // 👇 Center title for symmetry (optional)
// //         centerTitle: true,
// //       ),
// //       // 🔹 END OF APP BAR UPDATE


// //       body: Center(
// //         child: SingleChildScrollView(
// //           padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.center,
// //             children: [
// //               // 🔹 Larger Image
                
// //                   Center(
// //                     child: Container(
// //                       width: 200,
// //                       height: 120,
// //                       decoration: BoxDecoration(
// //                         color: Colors.blue.shade100,
// //                         borderRadius: BorderRadius.circular(12), // make corners slightly rounded
// //                         image: const DecorationImage(
// //                           image: AssetImage('assets/verify.jpg'),
// //                           fit: BoxFit.cover, // makes image fill the rectangle nicely
// //                         ),
// //                       ),
// //                     ),
// //                   ),

              
// //               // CircleAvatar(
// //               //   radius: 55, // Increased size
// //               //   backgroundImage: const AssetImage('assets/veryfy.jpg'),
// //               //   backgroundColor: Colors.blue.shade50,
// //               // ),

// //               const SizedBox(height: 25),

// //               const Text(
// //                 "Verification Code",
// //                 style: TextStyle(
// //                   fontSize: 22, // Slightly bigger
// //                   fontWeight: FontWeight.bold,
// //                   color: Colors.blueAccent,
// //                 ),
// //               ),

// //               const SizedBox(height: 10),

// //               const Text(
// //                 "Enter the verification code sent to your email",
// //                 style: TextStyle(
// //                   color: Colors.black54,
// //                   fontSize: 20,
// //                 ),
// //                 textAlign: TextAlign.center,
// //               ),

// //               const SizedBox(height: 30),

// //               // 🔹 Code Input Field
// //               TextField(
// //                 controller: codeController,
// //                 textAlign: TextAlign.center,
// //                 keyboardType: TextInputType.number,
// //                 decoration: InputDecoration(
// //                   hintText: "Enter Code",
// //                   hintStyle: const TextStyle(color: Colors.grey),
// //                   filled: true,
// //                   fillColor: Colors.grey[100],
// //                   contentPadding: const EdgeInsets.symmetric(
// //                       vertical: 15, horizontal: 10),
// //                   border: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(8),
// //                     borderSide: const BorderSide(color: Colors.black12),
// //                   ),
// //                   focusedBorder: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(8),
// //                     borderSide: const BorderSide(color: Colors.blueAccent),
// //                   ),
// //                 ),
// //               ),

// //               const SizedBox(height: 30),

// //               // 🔹 Verify Button
// //               SizedBox(
// //                 width: double.infinity,
// //                 child: ElevatedButton(
// //                   onPressed: () {
// //                     Navigator.push(
// //                       context,
// //                       MaterialPageRoute(
// //                           builder: (context) => const ResetPasswordPage()),
// //                     );
// //                   },
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: Colors.green,
// //                     padding: const EdgeInsets.symmetric(vertical: 14),
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(8),
// //                     ),
// //                   ),
// //                   child: const Text(
// //                     "Verify",
// //                     style: TextStyle(
// //                       color: Colors.white,
// //                       fontSize: 16,
// //                       fontWeight: FontWeight.bold,
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }





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



