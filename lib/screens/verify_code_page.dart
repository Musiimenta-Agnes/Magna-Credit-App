// import 'package:flutter/material.dart';
// import 'reset_password_page.dart';

// class VerifyCodePage extends StatelessWidget {
//   const VerifyCodePage({super.key, required String email});

//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController codeController = TextEditingController();
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;

//     Color background = isDark ? Colors.black : Colors.white;
//     Color textColor = isDark ? Colors.white : Colors.black;
//     Color subtitleColor = isDark ? Colors.white70 : Colors.black54;
//     Color fillColor = isDark ? Colors.black12 : Colors.grey[100]!;

//     return Scaffold(
//       backgroundColor: background,

//       appBar: AppBar(
//         backgroundColor: const Color(0xFF007BFF),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           "Back to Forget Password",
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

//               Text(
//                 "Verification Code",
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.blueAccent,
//                 ),
//               ),

//               const SizedBox(height: 10),

//               Text(
//                 "Enter the verification code sent to your email",
//                 style: TextStyle(
//                   color: subtitleColor,
//                   fontSize: 20,
//                 ),
//                 textAlign: TextAlign.center,
//               ),

//               const SizedBox(height: 30),

//               TextField(
//                 controller: codeController,
//                 textAlign: TextAlign.center,
//                 keyboardType: TextInputType.number,
//                 style: TextStyle(color: textColor),
//                 decoration: InputDecoration(
//                   hintText: "Enter Code",
//                   hintStyle: TextStyle(color: textColor.withOpacity(0.6)),
//                   filled: true,
//                   fillColor: fillColor,
//                   contentPadding: const EdgeInsets.symmetric(
//                       vertical: 15, horizontal: 10),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: const BorderSide(color: Colors.black12),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: const BorderSide(color: Colors.blueAccent),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 30),

//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const ResetPasswordPage()),
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
//                     "Verify",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
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




import 'package:flutter/material.dart';
import 'reset_password_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VerifyCodePage extends StatefulWidget {
  final String email;
  const VerifyCodePage({super.key, required this.email});

  @override
  State<VerifyCodePage> createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends State<VerifyCodePage> {
  final TextEditingController codeController = TextEditingController();
  bool isLoading = false;

  Future<void> verifyCode() async {
    final code = codeController.text.trim();
    if (code.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter the code")));
      return;
    }

    setState(() => isLoading = true);

    try {
      final response = await http.post(
        Uri.parse("[http://127.0.0.1:8000/api/forgot-password/verify-code"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": widget.email, "code": code}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResetPasswordPage(email: widget.email, code: code),
          ),
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(data['message'])));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to verify code. Try again.")));
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
    Color fillColor = isDark ? Colors.black12 : Colors.grey[100]!;

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
          "Back to Forget Password",
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          child: Column(
            children: [
              Center(
                child: Container(
                  width: 200,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(12),
                    image: const DecorationImage(
                      image: AssetImage('assets/verify.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Text(
                "Verification Code",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueAccent),
              ),
              const SizedBox(height: 10),
              Text(
                "Enter the verification code sent to your email",
                style: TextStyle(color: subtitleColor, fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              TextField(
                controller: codeController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                style: TextStyle(color: textColor),
                decoration: InputDecoration(
                  hintText: "Enter Code",
                  hintStyle: TextStyle(color: textColor.withOpacity(0.6)),
                  filled: true,
                  fillColor: fillColor,
                  contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.black12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.blueAccent),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : verifyCode,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "Verify",
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
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
// import 'reset_password_page.dart';

// class VerifyCodePage extends StatelessWidget {
//   const VerifyCodePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController codeController = TextEditingController();

//     return Scaffold(
//       backgroundColor: Colors.white,

//       // // 🔹 AppBar with Back Arrow (like Registration Page)
//       // appBar: AppBar(
//       //   backgroundColor: Colors.green,
//       //   elevation: 0,
//       //   leading: IconButton(
//       //     icon: const Icon(Icons.arrow_back, color: Colors.white),
//       //     onPressed: () => Navigator.pop(context),
//       //   ),
//       // ),

      
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
//           "Forgot Password", // 🟢 Example: Name of previous page (change as needed)
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
//           padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               // 🔹 Larger Image
                
//                   Center(
//                     child: Container(
//                       width: 200,
//                       height: 120,
//                       decoration: BoxDecoration(
//                         color: Colors.blue.shade100,
//                         borderRadius: BorderRadius.circular(12), // make corners slightly rounded
//                         image: const DecorationImage(
//                           image: AssetImage('assets/verify.jpg'),
//                           fit: BoxFit.cover, // makes image fill the rectangle nicely
//                         ),
//                       ),
//                     ),
//                   ),

              
//               // CircleAvatar(
//               //   radius: 55, // Increased size
//               //   backgroundImage: const AssetImage('assets/veryfy.jpg'),
//               //   backgroundColor: Colors.blue.shade50,
//               // ),

//               const SizedBox(height: 25),

//               const Text(
//                 "Verification Code",
//                 style: TextStyle(
//                   fontSize: 22, // Slightly bigger
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

//               // 🔹 Code Input Field
//               TextField(
//                 controller: codeController,
//                 textAlign: TextAlign.center,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(
//                   hintText: "Enter Code",
//                   hintStyle: const TextStyle(color: Colors.grey),
//                   filled: true,
//                   fillColor: Colors.grey[100],
//                   contentPadding: const EdgeInsets.symmetric(
//                       vertical: 15, horizontal: 10),
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

//               const SizedBox(height: 30),

//               // 🔹 Verify Button
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const ResetPasswordPage()),
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
//                     "Verify",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
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



