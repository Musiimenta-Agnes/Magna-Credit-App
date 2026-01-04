


import 'package:flutter/material.dart';
import 'reset_password_page.dart';

class VerifyCodePage extends StatelessWidget {
  const VerifyCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController codeController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,

      // // 🔹 AppBar with Back Arrow (like Registration Page)
      // appBar: AppBar(
      //   backgroundColor: Colors.green,
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back, color: Colors.white),
      //     onPressed: () => Navigator.pop(context),
      //   ),
      // ),

      
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
          "Forgot Password", // 🟢 Example: Name of previous page (change as needed)
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 🔹 Larger Image
                
                  Center(
                    child: Container(
                      width: 200,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(12), // make corners slightly rounded
                        image: const DecorationImage(
                          image: AssetImage('assets/verify.jpg'),
                          fit: BoxFit.cover, // makes image fill the rectangle nicely
                        ),
                      ),
                    ),
                  ),

              
              // CircleAvatar(
              //   radius: 55, // Increased size
              //   backgroundImage: const AssetImage('assets/veryfy.jpg'),
              //   backgroundColor: Colors.blue.shade50,
              // ),

              const SizedBox(height: 25),

              const Text(
                "Verification Code",
                style: TextStyle(
                  fontSize: 22, // Slightly bigger
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Enter the verification code sent to your email",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              // 🔹 Code Input Field
              TextField(
                controller: codeController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter Code",
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 15, horizontal: 10),
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

              const SizedBox(height: 30),

              // 🔹 Verify Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ResetPasswordPage()),
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
                    "Verify",
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
    );
  }
}



