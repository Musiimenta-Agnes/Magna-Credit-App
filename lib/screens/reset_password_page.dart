


// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'login_screen.dart';

// class ResetPasswordPage extends StatefulWidget {
//   final String email;
//   final String token;

//   const ResetPasswordPage({
//     super.key,
//     required this.email,
//     required this.token, required String code,
//   });

//   @override
//   State<ResetPasswordPage> createState() => _ResetPasswordPageState();
// }

// class _ResetPasswordPageState extends State<ResetPasswordPage> {
//   final TextEditingController newPasswordController = TextEditingController();
//   final TextEditingController confirmPasswordController =
//       TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   bool _obscurePassword = true;
//   bool _obscureConfirmPassword = true;
//   bool isLoading = false;

//   Future<void> _resetPassword() async {
//     if (!_formKey.currentState!.validate()) return;

//     if (newPasswordController.text != confirmPasswordController.text) {
//       _showTopNotification("❌ Passwords do not match",
//           bgColor: Colors.redAccent);
//       return;
//     }

//     setState(() => isLoading = true);

//     try {
//       final response = await http.post(
//         Uri.parse("http://127.0.0.1:8000/api/reset-password"),
//         headers: {"Accept": "application/json"},
//         body: {
//           "email": widget.email,
//           "token": widget.token,
//           "password": newPasswordController.text,
//           "password_confirmation": confirmPasswordController.text,
//         },
//       );

//       final data = jsonDecode(response.body);

//       if (response.statusCode == 200) {
//         _showTopNotification("✅ Password reset successful!");
//         Future.delayed(const Duration(seconds: 2), () {
//           Navigator.pushAndRemoveUntil(
//             context,
//             MaterialPageRoute(builder: (context) => const LoginPage()),
//             (route) => false,
//           );
//         });
//       } else {
//         _showTopNotification(
//           data['message'] ?? "Reset failed",
//           bgColor: Colors.redAccent,
//         );
//       }
//     } catch (e) {
//       _showTopNotification(
//         "Server error. Try again.",
//         bgColor: Colors.redAccent,
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
//           "Reset Password",
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
//           child: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Center(
//                   child: Container(
//                     width: 200,
//                     height: 120,
//                     decoration: BoxDecoration(
//                       color: Colors.blue.shade100,
//                       borderRadius: BorderRadius.circular(12),
//                       image: const DecorationImage(
//                         image: AssetImage('assets/reset_password.jpg'),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 25),
//                 const Text(
//                   "Reset Password",
//                   style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.blueAccent,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 const Text(
//                   "Enter your new password and confirm it",
//                   style: TextStyle(
//                     color: Colors.black54,
//                     fontSize: 20,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 30),
//                 _buildPasswordField(
//                   newPasswordController,
//                   "Enter New Password",
//                   _obscurePassword,
//                   () => setState(() => _obscurePassword = !_obscurePassword),
//                 ),
//                 const SizedBox(height: 15),
//                 _buildPasswordField(
//                   confirmPasswordController,
//                   "Confirm Password",
//                   _obscureConfirmPassword,
//                   () => setState(
//                       () => _obscureConfirmPassword = !_obscureConfirmPassword),
//                 ),
//                 const SizedBox(height: 30),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: isLoading ? null : _resetPassword,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green,
//                       padding: const EdgeInsets.symmetric(vertical: 14),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: isLoading
//                         ? const CircularProgressIndicator(
//                             color: Colors.white,
//                           )
//                         : const Text(
//                             "Reset Password",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildPasswordField(TextEditingController controller, String hintText,
//       bool obscureText, VoidCallback toggleVisibility) {
//     return TextFormField(
//       controller: controller,
//       obscureText: obscureText,
//       decoration: InputDecoration(
//         prefixIcon: const Icon(Icons.lock, color: Colors.blueAccent),
//         hintText: hintText,
//         filled: true,
//         fillColor: Colors.white,
//         contentPadding:
//             const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: const BorderSide(color: Colors.black12),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: const BorderSide(color: Colors.blueAccent),
//         ),
//         suffixIcon: IconButton(
//           icon: Icon(
//             obscureText ? Icons.visibility_off : Icons.visibility,
//             color: Colors.grey,
//           ),
//           onPressed: toggleVisibility,
//         ),
//       ),
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Please fill in this field';
//         }
//         return null;
//       },
//     );
//   }

//   void _showTopNotification(String message,
//       {Color bgColor = Colors.green}) {
//     final overlay = Overlay.of(context);
//     final overlayEntry = OverlayEntry(
//       builder: (context) => Positioned(
//         top: MediaQuery.of(context).padding.top + 10,
//         left: 20,
//         right: 20,
//         child: Material(
//           color: Colors.transparent,
//           child: Container(
//             padding:
//                 const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//             decoration: BoxDecoration(
//               color: bgColor,
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Center(
//               child: Text(
//                 message,
//                 style:
//                     const TextStyle(color: Colors.white, fontSize: 14),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );

//     overlay.insert(overlayEntry);
//     Future.delayed(const Duration(seconds: 2), () => overlayEntry.remove());
//   }
// }





// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'dart:convert';

// // class ResetPasswordPage extends StatefulWidget {
// //   final String email;
// //   final String code;

// //   const ResetPasswordPage({super.key, required this.email, required this.code, required String token});

// //   @override
// //   State<ResetPasswordPage> createState() => _ResetPasswordPageState();
// // }

// // class _ResetPasswordPageState extends State<ResetPasswordPage> {
// //   final TextEditingController passwordController = TextEditingController();
// //   bool isLoading = false;

// //   Future<void> resetPassword() async {
// //     final password = passwordController.text.trim();
// //     if (password.isEmpty) {
// //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter a new password")));
// //       return;
// //     }

// //     setState(() => isLoading = true);

// //     try {
// //       final response = await http.post(
// //         Uri.parse("[http://127.0.0.1:8000/api/forgot-password/reset-password"),
// //         headers: {"Content-Type": "application/json"},
// //         body: jsonEncode({
// //           "email": widget.email,
// //           "code": widget.code,
// //           "password": password,
// //         }),
// //       );

// //       final data = jsonDecode(response.body);

// //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data['message'])));

// //       if (response.statusCode == 200) {
// //         Navigator.popUntil(context, (route) => route.isFirst); // back to login
// //       }
// //     } catch (e) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //           const SnackBar(content: Text("Failed to reset password. Try again.")));
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
// //     Color fillColor = isDark ? Colors.grey[900]! : Colors.white;

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
// //           "Reset Password",
// //           style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
// //         ),
// //         centerTitle: true,
// //       ),
// //       body: Center(
// //         child: SingleChildScrollView(
// //           padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
// //           child: Column(
// //             children: [
// //               TextField(
// //                 controller: passwordController,
// //                 obscureText: true,
// //                 style: TextStyle(color: textColor),
// //                 decoration: InputDecoration(
// //                   hintText: "Enter new password",
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
// //                   onPressed: isLoading ? null : resetPassword,
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: Colors.green,
// //                     padding: const EdgeInsets.symmetric(vertical: 14),
// //                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
// //                   ),
// //                   child: isLoading
// //                       ? const CircularProgressIndicator(color: Colors.white)
// //                       : const Text(
// //                           "Reset Password",
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
// // import 'login_screen.dart';

// // class ResetPasswordPage extends StatefulWidget {
// //   const ResetPasswordPage({super.key});

// //   @override
// //   State<ResetPasswordPage> createState() => _ResetPasswordPageState();
// // }

// // class _ResetPasswordPageState extends State<ResetPasswordPage> {
// //   final TextEditingController newPasswordController = TextEditingController();
// //   final TextEditingController confirmPasswordController = TextEditingController();
// //   final _formKey = GlobalKey<FormState>();

// //   bool _obscurePassword = true;
// //   bool _obscureConfirmPassword = true;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,

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
// //           "Verify Code", // 🟢 Example: Name of previous page (change as needed)
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
// //           child: Form(
// //             key: _formKey,
// //             child: Column(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               crossAxisAlignment: CrossAxisAlignment.center,
// //               children: [
// //                 // 🔹 Larger Image


// //                 // 🔹 Company Logo (Rectangle form)
// //                   Center(
// //                     child: Container(
// //                       width: 200,
// //                       height: 120,
// //                       decoration: BoxDecoration(
// //                         color: Colors.blue.shade100,
// //                         borderRadius: BorderRadius.circular(12), // make corners slightly rounded
// //                         image: const DecorationImage(
// //                           image: AssetImage('assets/reset_password.jpg'),
// //                           fit: BoxFit.cover, // makes image fill the rectangle nicely
// //                         ),
// //                       ),
// //                     ),
// //                   ),

// //                                   // CircleAvatar(
// //                 //   radius: 70, // Increased size
// //                 //   backgroundImage: const AssetImage('assets/reset_password.jpg'),
// //                 //   backgroundColor: Colors.blue.shade50,
// //                 // ),

// //                 const SizedBox(height: 25),

// //                 const Text(
// //                   "Reset Password",
// //                   style: TextStyle(
// //                     fontSize: 22,
// //                     fontWeight: FontWeight.bold,
// //                     color: Colors.blueAccent,
// //                   ),
// //                 ),

// //                 const SizedBox(height: 10),

// //                 const Text(
// //                   "Enter your new password and confirm it",
// //                   style: TextStyle(
// //                     color: Colors.black54,
// //                     fontSize: 20,
// //                   ),
// //                   textAlign: TextAlign.center,
// //                 ),

// //                 const SizedBox(height: 30),

// //                 // 🔹 New Password Field
// //                 _buildPasswordField(
// //                   newPasswordController,
// //                   "Enter New Password",
// //                   _obscurePassword,
// //                   () => setState(() => _obscurePassword = !_obscurePassword),
// //                 ),

// //                 const SizedBox(height: 15),

// //                 // 🔹 Confirm Password Field
// //                 _buildPasswordField(
// //                   confirmPasswordController,
// //                   "Confirm Password",
// //                   _obscureConfirmPassword,
// //                   () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
// //                 ),

// //                 const SizedBox(height: 30),

// //                 // 🔹 Reset Password Button
// //                 SizedBox(
// //                   width: double.infinity,
// //                   child: ElevatedButton(
// //                     onPressed: _resetPassword,
// //                     style: ElevatedButton.styleFrom(
// //                       backgroundColor: Colors.green,
// //                       padding: const EdgeInsets.symmetric(vertical: 14),
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(8),
// //                       ),
// //                     ),
// //                     child: const Text(
// //                       "Reset Password",
// //                       style: TextStyle(
// //                         color: Colors.white,
// //                         fontSize: 16,
// //                         fontWeight: FontWeight.bold,
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   // 🔸 Password Field with Toggle
// //   Widget _buildPasswordField(TextEditingController controller, String hintText,
// //       bool obscureText, VoidCallback toggleVisibility) {
// //     return TextFormField(
// //       controller: controller,
// //       obscureText: obscureText,
// //       decoration: InputDecoration(
// //         prefixIcon: const Icon(Icons.lock, color: Colors.blueAccent),
// //         hintText: hintText,
// //         filled: true,
// //         fillColor: Colors.white,
// //         contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
// //         enabledBorder: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(8),
// //           borderSide: const BorderSide(color: Colors.black12),
// //         ),
// //         focusedBorder: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(8),
// //           borderSide: const BorderSide(color: Colors.blueAccent),
// //         ),
// //         suffixIcon: IconButton(
// //           icon: Icon(
// //             obscureText ? Icons.visibility_off : Icons.visibility,
// //             color: Colors.grey,
// //           ),
// //           onPressed: toggleVisibility,
// //         ),
// //       ),
// //       validator: (value) {
// //         if (value == null || value.isEmpty) {
// //           return 'Please fill in this field';
// //         }
// //         return null;
// //       },
// //     );
// //   }

// //   // 🔸 Top Notification
// //   void _showTopNotification(String message, {Color bgColor = Colors.green}) {
// //     final overlay = Overlay.of(context);
// //     final overlayEntry = OverlayEntry(
// //       builder: (context) => Positioned(
// //         top: MediaQuery.of(context).padding.top + 10,
// //         left: 20,
// //         right: 20,
// //         child: Material(
// //           color: Colors.transparent,
// //           child: Container(
// //             padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
// //             decoration: BoxDecoration(
// //               color: bgColor,
// //               borderRadius: BorderRadius.circular(8),
// //               boxShadow: [
// //                 BoxShadow(
// //                   color: Colors.black26,
// //                   blurRadius: 6,
// //                   offset: const Offset(0, 3),
// //                 ),
// //               ],
// //             ),
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 const Icon(Icons.check_circle, color: Colors.white),
// //                 const SizedBox(width: 10),
// //                 Expanded(
// //                   child: Text(
// //                     message,
// //                     style: const TextStyle(color: Colors.white, fontSize: 14),
// //                     overflow: TextOverflow.ellipsis,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );

// //     overlay.insert(overlayEntry);
// //     Future.delayed(const Duration(seconds: 2), () => overlayEntry.remove());
// //   }

// //   // 🔸 Reset Password Logic
// //   void _resetPassword() {
// //     if (_formKey.currentState!.validate()) {
// //       if (newPasswordController.text != confirmPasswordController.text) {
// //         _showTopNotification("❌ Passwords do not match", bgColor: Colors.redAccent);
// //         return;
// //       }

// //       _showTopNotification("✅ Password reset successful! Redirecting...");

// //       Future.delayed(const Duration(seconds: 2), () {
// //         Navigator.pushAndRemoveUntil(
// //           context,
// //           MaterialPageRoute(builder: (context) => const LoginPage()),
// //           (route) => false,
// //         );
// //       });
// //     }
// //   }
// // }




import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'login_screen.dart';

class ResetPasswordPage extends StatefulWidget {
  final String email;
  final String token;

  const ResetPasswordPage({
    super.key,
    required this.email,
    required this.token,
    required String code,
  });

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool isLoading = false;

  static const Color _blue = Color(0xFF007BFF);
  static const Color _green = Colors.green;

  Future<void> _resetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    if (newPasswordController.text != confirmPasswordController.text) {
      _showTopNotification("❌ Passwords do not match", bgColor: Colors.redAccent);
      return;
    }

    setState(() => isLoading = true);

    try {
      final response = await http.post(
        Uri.parse("http://127.0.0.1:8000/api/reset-password"),
        headers: {"Accept": "application/json"},
        body: {
          "email": widget.email,
          "token": widget.token,
          "password": newPasswordController.text,
          "password_confirmation": confirmPasswordController.text,
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _showTopNotification("✅ Password reset successful!");
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (route) => false,
          );
        });
      } else {
        _showTopNotification(
          data['message'] ?? "Reset failed",
          bgColor: Colors.redAccent,
        );
      }
    } catch (e) {
      _showTopNotification("Server error. Try again.", bgColor: Colors.redAccent);
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
          "Reset Password",
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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ── Icon badge ──
              Center(
                child: Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: _blue.withOpacity(0.07),
                    shape: BoxShape.circle,
                    border: Border.all(color: _blue.withOpacity(0.2)),
                  ),
                  child: const Icon(
                    Icons.lock_open_rounded,
                    color: _blue,
                    size: 44,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              const Center(
                child: Text(
                  "Create New Password",
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
                  "Your new password must be different\nfrom the previous one",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black45,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 36),

              // ── New password ──
              const _FieldLabel(label: "New Password"),
              const SizedBox(height: 6),
              _buildPasswordField(
                controller: newPasswordController,
                hintText: "Enter new password",
                obscureText: _obscurePassword,
                toggleVisibility: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
              ),

              const SizedBox(height: 18),

              // ── Confirm password ──
              const _FieldLabel(label: "Confirm Password"),
              const SizedBox(height: 6),
              _buildPasswordField(
                controller: confirmPasswordController,
                hintText: "Repeat new password",
                obscureText: _obscureConfirmPassword,
                toggleVisibility: () => setState(
                    () => _obscureConfirmPassword = !_obscureConfirmPassword),
              ),

              const SizedBox(height: 32),

              // ── Reset button ──
              GestureDetector(
                onTap: isLoading ? null : _resetPassword,
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
                            Icon(Icons.lock_reset_rounded,
                                color: Colors.white, size: 20),
                            SizedBox(width: 10),
                            Text(
                              "Reset Password",
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
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hintText,
    required bool obscureText,
    required VoidCallback toggleVisibility,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.black87, fontSize: 14),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock_rounded, color: _blue, size: 20),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.black38, fontSize: 14),
        filled: true,
        fillColor: const Color(0xFFF5F8FF),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFD0E4FF)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _blue, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off_rounded : Icons.visibility_rounded,
            color: Colors.grey,
            size: 20,
          ),
          onPressed: toggleVisibility,
        ),
      ),
      validator: (value) =>
          value == null || value.isEmpty ? 'Please fill in this field' : null,
    );
  }

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
    Future.delayed(const Duration(seconds: 2), () => overlayEntry.remove());
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