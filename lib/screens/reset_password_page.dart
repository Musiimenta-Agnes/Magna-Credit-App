
import 'package:flutter/material.dart';
import 'login_screen.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // 🔹 UPDATED APP BAR WITH HEADING
      appBar: AppBar(
        backgroundColor: Color(0xFF007BFF),
        elevation: 0,

        // 👇 Back arrow icon (unchanged)
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),

        //  NEW: Add a title to show the previous page name
        // You can customize the text here to match the actual previous page title.
        title: const Text(
          "Verify Code", // 🟢 Example: Name of previous page (change as needed)
          style: TextStyle(
            color: Colors.white, // makes the title text white
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),

        // 👇 Center title for symmetry (optional)
        centerTitle: true,
      ),
      // 🔹 END OF APP BAR UPDATE

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 🔹 Larger Image


                // 🔹 Company Logo (Rectangle form)
                  Center(
                    child: Container(
                      width: 200,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(12), // make corners slightly rounded
                        image: const DecorationImage(
                          image: AssetImage('assets/reset_password.jpg'),
                          fit: BoxFit.cover, // makes image fill the rectangle nicely
                        ),
                      ),
                    ),
                  ),

                                  // CircleAvatar(
                //   radius: 70, // Increased size
                //   backgroundImage: const AssetImage('assets/reset_password.jpg'),
                //   backgroundColor: Colors.blue.shade50,
                // ),

                const SizedBox(height: 25),

                const Text(
                  "Reset Password",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Enter your new password and confirm it",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 30),

                // 🔹 New Password Field
                _buildPasswordField(
                  newPasswordController,
                  "Enter New Password",
                  _obscurePassword,
                  () => setState(() => _obscurePassword = !_obscurePassword),
                ),

                const SizedBox(height: 15),

                // 🔹 Confirm Password Field
                _buildPasswordField(
                  confirmPasswordController,
                  "Confirm Password",
                  _obscureConfirmPassword,
                  () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                ),

                const SizedBox(height: 30),

                // 🔹 Reset Password Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _resetPassword,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Reset Password",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 🔸 Password Field with Toggle
  Widget _buildPasswordField(TextEditingController controller, String hintText,
      bool obscureText, VoidCallback toggleVisibility) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock, color: Colors.blueAccent),
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.black12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.blueAccent),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: toggleVisibility,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please fill in this field';
        }
        return null;
      },
    );
  }

  // 🔸 Top Notification
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
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.check_circle, color: Colors.white),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    Future.delayed(const Duration(seconds: 2), () => overlayEntry.remove());
  }

  // 🔸 Reset Password Logic
  void _resetPassword() {
    if (_formKey.currentState!.validate()) {
      if (newPasswordController.text != confirmPasswordController.text) {
        _showTopNotification("❌ Passwords do not match", bgColor: Colors.redAccent);
        return;
      }

      _showTopNotification("✅ Password reset successful! Redirecting...");

      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (route) => false,
        );
      });
    }
  }
}


























// import 'package:flutter/material.dart';
// import 'login_screen.dart';

// class ResetPasswordPage extends StatefulWidget {
//   const ResetPasswordPage({super.key});

//   @override
//   State<ResetPasswordPage> createState() => _ResetPasswordPageState();
// }

// class _ResetPasswordPageState extends State<ResetPasswordPage> {
//   final TextEditingController newPasswordController = TextEditingController();
//   final TextEditingController confirmPasswordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();

//   bool _obscurePassword = true;
//   bool _obscureConfirmPassword = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 CircleAvatar(
//                   radius: 40,
//                   backgroundImage: const AssetImage('assets/reset_password.jpg'),
//                 ),
//                 const SizedBox(height: 20),
//                 const Text(
//                   "Reset Password",
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 const Text(
//                   "Enter your new password and confirm it",
//                   style: TextStyle(
//                     color: Colors.blueAccent,
//                     fontSize: 13,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 25),

//                 _buildPasswordField(
//                   newPasswordController,
//                   "Enter New Password",
//                   _obscurePassword,
//                   () {
//                     setState(() => _obscurePassword = !_obscurePassword);
//                   },
//                 ),
//                 const SizedBox(height: 15),
//                 _buildPasswordField(
//                   confirmPasswordController,
//                   "Confirm Password",
//                   _obscureConfirmPassword,
//                   () {
//                     setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);
//                   },
//                 ),

//                 const SizedBox(height: 25),

//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: _resetPassword,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green,
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: const Text(
//                       "Reset Password",
//                       style: TextStyle(color: Colors.white, fontSize: 16),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // 🔹 Password TextField with toggle
//   Widget _buildPasswordField(TextEditingController controller, String hintText,
//       bool obscureText, VoidCallback toggleVisibility) {
//     return TextFormField(
//       controller: controller,
//       obscureText: obscureText,
//       decoration: InputDecoration(
//         hintText: hintText,
//         filled: true,
//         fillColor: Colors.grey[100],
//         contentPadding:
//             const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: const BorderSide(color: Colors.black12),
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

//   // 🔹 Custom top notification banner
//   void _showTopNotification(String message, {Color bgColor = Colors.green}) {
//     final overlay = Overlay.of(context);
//     final overlayEntry = OverlayEntry(
//       builder: (context) => Positioned(
//         top: MediaQuery.of(context).padding.top + 10,
//         left: 20,
//         right: 20,
//         child: Material(
//           color: Colors.transparent,
//           child: AnimatedSlide(
//             duration: const Duration(milliseconds: 300),
//             offset: const Offset(0, 0),
//             child: Container(
//               padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//               decoration: BoxDecoration(
//                 color: bgColor,
//                 borderRadius: BorderRadius.circular(8),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black26,
//                     blurRadius: 6,
//                     offset: const Offset(0, 3),
//                   ),
//                 ],
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Icon(Icons.check_circle, color: Colors.white),
//                   const SizedBox(width: 10),
//                   Expanded(
//                     child: Text(
//                       message,
//                       style: const TextStyle(color: Colors.white, fontSize: 14),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );

//     overlay.insert(overlayEntry);

//     // Remove after delay
//     Future.delayed(const Duration(seconds: 2), () {
//       overlayEntry.remove();
//     });
//   }

//   // 🔹 Handle reset logic
//   void _resetPassword() {
//     if (_formKey.currentState!.validate()) {
//       if (newPasswordController.text != confirmPasswordController.text) {
//         _showTopNotification("❌ Passwords do not match", bgColor: Colors.redAccent);
//         return;
//       }

//       // ✅ Successful password reset
//       _showTopNotification("✅ Password reset successful! Redirecting...");

//       // Redirect to login after short delay
//       Future.delayed(const Duration(seconds: 2), () {
//         Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (context) => const LoginPage()),
//           (route) => false,
//         );
//       });
//     }
//   }
// }
