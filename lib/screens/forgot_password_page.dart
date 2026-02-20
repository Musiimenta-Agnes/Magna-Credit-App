import 'package:flutter/material.dart';
import 'verify_code_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  bool isLoading = false;

  Future<void> sendCode() async {
    final email = emailController.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Please enter your email")));
      return;
    }

    setState(() => isLoading = true);

    try {
      final response = await http.post(
        Uri.parse("[http://127.0.0.1:8000/api/forgot-password/send-code"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Navigate to VerifyCodePage with email
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VerifyCodePage(email: email),
          ),
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(data['message'])));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to send code. Try again.")),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Color background = isDark ? Colors.black : Colors.white;
    Color textColor = isDark ? Colors.white : Colors.black;
    Color subtitleColor = isDark ? Colors.white70 : Colors.black54;
    Color fillColor = isDark ? Colors.grey[900]! : Colors.white;

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: const Color(0xFF007BFF),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Go to Login",
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200,
                height: 150,
                decoration: BoxDecoration(
                  color: fillColor,
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: AssetImage('assets/forgot_password.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Forgot Password",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: textColor),
              ),
              const SizedBox(height: 15),
              Text(
                "Enter your email to receive a verification code",
                style: TextStyle(color: subtitleColor, fontSize: 17),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 35),
              TextField(
                controller: emailController,
                style: TextStyle(color: textColor),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email, color: const Color(0xFF007BFF)),
                  hintText: "Enter your Email",
                  hintStyle: TextStyle(color: textColor.withOpacity(0.6)),
                  filled: true,
                  fillColor: fillColor,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: isDark ? Colors.white12 : Colors.black12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFF007BFF)),
                  ),
                ),
              ),
              const SizedBox(height: 35),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : sendCode,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "Send Code",
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
















// import 'package:flutter/material.dart';
// import 'verify_code_page.dart';

// class ForgotPasswordPage extends StatefulWidget {
//   const ForgotPasswordPage({super.key});

//   @override
//   State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
// }

// class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
//   final TextEditingController emailController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Scaffold(
//       backgroundColor: theme.scaffoldBackgroundColor,

//       appBar: AppBar(
//         backgroundColor: theme.primaryColor,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: theme.appBarTheme.foregroundColor),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           "Login",
//           style: TextStyle(
//             color: theme.appBarTheme.foregroundColor,
//             fontSize: 20,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         centerTitle: true,
//       ),

//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 width: 200,
//                 height: 150,
//                 decoration: BoxDecoration(
//                   color: theme.cardColor,
//                   borderRadius: BorderRadius.circular(12),
//                   image: const DecorationImage(
//                     image: AssetImage('assets/forgot_password.jpg'),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 20),

//               Text(
//                 "Forgot Password",
//                 style: theme.textTheme.headlineSmall?.copyWith(
//                   fontWeight: FontWeight.bold,
//                   color: theme.textTheme.headlineSmall?.color,
//                 ),
//               ),

//               const SizedBox(height: 15),

//               Text(
//                 "Enter your email to receive a verification code",
//                 style: theme.textTheme.bodyMedium?.copyWith(
//                   color: theme.primaryColor,
//                   fontSize: 17,
//                 ),
//                 textAlign: TextAlign.center,
//               ),

//               const SizedBox(height: 35),

//               TextField(
//                 controller: emailController,
//                 decoration: InputDecoration(
//                   prefixIcon: Icon(Icons.email, color: theme.primaryColor),
//                   hintText: "Enter your Email",
//                   filled: true,
//                   fillColor: theme.cardColor,
//                   contentPadding:
//                       const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: BorderSide(color: theme.dividerColor),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: BorderSide(color: theme.primaryColor),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 35),

//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const VerifyCodePage(),
//                       ),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: theme.primaryColor,
//                     padding: const EdgeInsets.symmetric(vertical: 14),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: Text(
//                     "Send Code",
//                     style: TextStyle(
//                       color: theme.appBarTheme.foregroundColor,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }











































// import 'package:flutter/material.dart';
// import 'verify_code_page.dart';

// class ForgotPasswordPage extends StatefulWidget {
//   const ForgotPasswordPage({super.key});

//   @override
//   State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
// }

// class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
//   final TextEditingController emailController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,

//       // 🔹 UPDATED APP BAR WITH HEADING
//       appBar: AppBar(
//         backgroundColor: Color(0xFF007BFF),
//         elevation: 0,

//         // 👇 Back arrow icon (unchanged)
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),

//         //  NEW: Add a title to show the previous page name
//         // You can customize the text here to match the actual previous page title.
//         title: const Text(
//           "Login", // 🟢 Example: Name of previous page (change as needed)
//           style: TextStyle(
//             color: Colors.white, // makes the title text white
//             fontSize: 20,
//             fontWeight: FontWeight.w600,
//           ),
//         ),

//         // 👇 Center title for symmetry (optional)
//         centerTitle: true,
//       ),
//       // 🔹 END OF APP BAR UPDATE

//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // 🔹 Larger Logo
//               Center(
//                 child: Container(
//                   width: 200,
//                   height: 150,
//                   decoration: BoxDecoration(
//                     color: Colors.blue.shade100,
//                     borderRadius: BorderRadius.circular(12), // slightly rounded
//                     image: const DecorationImage(
//                       image: AssetImage('assets/forgot_password.jpg'),
//                       fit: BoxFit.cover, // fills rectangle nicely
//                     ),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 20),

//               // 🔹 Title
//               const Text(
//                 "Forgot Password",
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black87,
//                 ),
//               ),
//               const SizedBox(height: 15),

//               // 🔹 Description
//               const Text(
//                 "Enter your email to receive a verification code",
//                 style: TextStyle(
//                   color: Colors.blueAccent,
//                   fontSize: 17,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 35),

//               // 🔹 Email Text Field (with icon)
//               TextField(
//                 controller: emailController,
//                 decoration: InputDecoration(
//                   prefixIcon:
//                       const Icon(Icons.email, color: Colors.blueAccent),
//                   hintText: "Enter your Email",
//                   filled: true,
//                   fillColor: Colors.grey[100],
//                   contentPadding:
//                       const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: const BorderSide(color: Colors.black12),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: const BorderSide(color: Colors.blueAccent),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 35),

//               // 🔹 Send Code Button
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const VerifyCodePage(),
//                       ),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green,
//                     padding: const EdgeInsets.symmetric(vertical: 14),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: const Text(
//                     "Send Code",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

