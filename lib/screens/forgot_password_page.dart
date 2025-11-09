



import 'package:flutter/material.dart';
import 'verify_code_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // 🔹 UPDATED APP BAR WITH HEADING
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,

        // 👇 Back arrow icon (unchanged)
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),

        //  NEW: Add a title to show the previous page name
        // You can customize the text here to match the actual previous page title.
        title: const Text(
          "Login", // 🟢 Example: Name of previous page (change as needed)
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
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 🔹 Larger Logo
              Center(
                child: Container(
                  width: 200,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(12), // slightly rounded
                    image: const DecorationImage(
                      image: AssetImage('assets/forgot_password.jpg'),
                      fit: BoxFit.cover, // fills rectangle nicely
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 🔹 Title
              const Text(
                "Forgot Password",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 15),

              // 🔹 Description
              const Text(
                "Enter your email to receive a verification code",
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 17,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 35),

              // 🔹 Email Text Field (with icon)
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  prefixIcon:
                      const Icon(Icons.email, color: Colors.blueAccent),
                  hintText: "Enter your Email",
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.black12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.blueAccent),
                  ),
                ),
              ),
              const SizedBox(height: 35),

              // 🔹 Send Code Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const VerifyCodePage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Send Code",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
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
//     return Scaffold(
//       backgroundColor: Colors.white,

//       // 🔹 Back Arrow (same as RegistrationPage)
//       appBar: AppBar(
//         backgroundColor: Colors.green,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),

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
//                     borderRadius: BorderRadius.circular(12), // make corners slightly rounded
//                     image: const DecorationImage(
//                       image: AssetImage('assets/forgot_password.jpg'),
//                       fit: BoxFit.cover, // makes image fill the rectangle nicely
//                     ),
//                   ),
//                 ),
//               ),


//               // 🔹 Title
//               const Text(
//                 "Forgot Password",
//                 style: TextStyle(
//                   fontSize: 28, // Increased font size
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
//                   fontSize: 17, // Slightly bigger text
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
