import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'about_screen.dart';
import 'profile_page.dart';
import 'signup_screen.dart';
// import 'first_loan_application.dart'; 

class TermsPoliciesPage extends StatefulWidget {
  const TermsPoliciesPage({super.key});

  @override
  State<TermsPoliciesPage> createState() => _TermsPoliciesPageState();
}

class _TermsPoliciesPageState extends State<TermsPoliciesPage> {
  bool isChecked = false;
  int _selectedIndex = 0;

  // 🔹 Bottom Navigation
  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AboutPage()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfilePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FA),

      appBar: AppBar(
        backgroundColor: const Color(0xFF007BFF),
        elevation: 4,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 26),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Terms & Policies",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),

      // BODY
body: SingleChildScrollView(
  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      // --- PAGE HEADER (NO CONTAINER, NO GRADIENT) ---
      const Text(
        "Please read the terms and loan policies carefully before applying for a loan with Magna Credit Limited.",
        style: TextStyle(
          color: Colors.green,   // 🔵 Blue heading text
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.left,     // You can change to center if you want
      ),

      const SizedBox(height: 20),


      // // BODY
      // body: SingleChildScrollView(
      //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       // --- PAGE HEADER ---
      //       Container(
      //         padding: const EdgeInsets.all(18),
      //         decoration: BoxDecoration(
      //           gradient: const LinearGradient(
      //             colors: [Color(0xFF007BFF), Color.fromARGB(255, 27, 229, 33)],
      //             begin: Alignment.topLeft,
      //             end: Alignment.bottomRight,
      //           ),
      //           borderRadius: BorderRadius.circular(16),
      //           boxShadow: [
      //             BoxShadow(
      //               color: Colors.black12,
      //               blurRadius: 6,
      //               offset: Offset(0, 3),
      //             )
      //           ],
      //         ),
      //         child: const Text(
      //           "Please read the terms and loan policies carefully before applying for a loan with Magna Credit Limited.",
      //           style: TextStyle(
      //             color: Colors.white,
      //             fontSize: 17,
      //             fontWeight: FontWeight.w600,
      //           ),
      //           textAlign: TextAlign.center,
      //         ),
      //       ),

            const SizedBox(height: 25),

            // TERMS AND POLICIES TEXT
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.black12.withOpacity(0.10),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  )
                ],
              ),
              child: const Text(
                """
Magna Credit Limited Loans Terms & Policies:

1. All clients applying for a loan must provide collateral that is valued at **two times (2×)** the loan amount they request.

2. The collateral must be **valid, legally owned**, and must be **handed over to the Magna Credit Limited office** before the loan is approved.

3. Every client must fill in a **Loan Agreement Form** at the office physically before any loan can be processed.

4. A client is not allowed to proceed to the loan application form until they have **read, understood, and accepted** these terms and policies.

5. Failure to follow these policies will result in loan denial.

By checking the box below, you confirm that you have read and understood all the terms and policies listed above.
                """,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.45,
                  color: Colors.black87,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // CHECKBOX
            Row(
              children: [
                Checkbox(
                  activeColor: Colors.green,
                  value: isChecked,
                  onChanged: (value) {
                    setState(() => isChecked = value!);
                  },
                ),
                const Expanded(
                  child: Text(
                    "I have read and understood the terms and policies.",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            // NEXT BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (!isChecked) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Please read and accept the terms and policies first.",
                        ),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 2),
                      ),
                    );
                    return;
                  }

                  // If checked → go to loan form
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegistrationPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isChecked ? Colors.green : Colors.grey, // disable-like style
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Next",
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),

      // BOTTOM NAVIGATION
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 8,
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF007BFF),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.info_outline), label: "About"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
