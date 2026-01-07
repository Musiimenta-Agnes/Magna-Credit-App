
import 'package:flutter/material.dart';
import 'about_screen.dart';
import 'terms_and_policy.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);

    if (index == 1) {
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
      backgroundColor: const Color(0xFFF4F7FB),

      // 🔵 APP BAR
      appBar: AppBar(
        backgroundColor: const Color(0xFF007BFF),
        elevation: 3,
        centerTitle: true,
        title: const Text(
          "MAGNA CREDIT LIMITED",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 17,
            letterSpacing: 0.6,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: CircleAvatar(
              radius: 17,
              backgroundImage: AssetImage('assets/magna_logo.jpeg'),
            ),
          ),
        ],
      ),

      // 🧱 BODY
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // 🔹 WHY CHOOSE MAGNA (NOW FIRST)
              const Text(
                "Why Choose Magna",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(height: 18),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  _FeatureItem(
                    icon: Icons.flash_on,
                    label: "Fast Approval",
                    color: Color(0xFF007BFF),
                  ),
                  _FeatureItem(
                    icon: Icons.account_balance_wallet,
                    label: "High Limits",
                    color: Color(0xFF00C853),
                  ),
                  _FeatureItem(
                    icon: Icons.security,
                    label: "Secure",
                    color: Color(0xFFFFA000),
                  ),
                ],
              ),

              const SizedBox(height: 36),

              // WELCOME CARD (GREEN BACKGROUND)
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 30),
                decoration: BoxDecoration(
                  color: const Color(0xFF1BBE6D), // ✅ Solid green
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      "Welcome to Magna Credit",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Fast, secure and reliable loans designed for your needs.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 19,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 22),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TermsPoliciesPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF1BBE6D),
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        "Apply for a Loan",
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // 🔹 LOAN PROCESS (LAST)
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: const [
                    Text(
                      "Loan Process",
                      style: TextStyle(
                        color: Color(0xFF007BFF),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Sign In → Verification → Loan Disbursement",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // 🔻 BOTTOM NAV
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF007BFF),
        unselectedItemColor: Colors.grey,
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

// 🔹 FEATURE ITEM
class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _FeatureItem({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            // ignore: deprecated_member_use
            color: color.withOpacity(0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}

















// import 'package:flutter/material.dart';
// import 'about_screen.dart';
// import 'terms_and_policy.dart';
// import 'profile_page.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _selectedIndex = 0;

//   void _onItemTapped(int index) {
//     setState(() => _selectedIndex = index);

//     if (index == 1) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => const AboutPage()),
//       );
//     } else if (index == 2) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => const ProfilePage()),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF4F7FB),

//       // 🔵 APP BAR
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF007BFF),
//         elevation: 3,
//         centerTitle: true,
//         title: const Text(
//           "MAGNA CREDIT LIMITED",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//             fontSize: 17,
//             letterSpacing: 0.6,
//           ),
//         ),
//         actions: const [
//           Padding(
//             padding: EdgeInsets.only(right: 12),
//             child: CircleAvatar(
//               radius: 17,
//               backgroundImage: AssetImage('assets/magna_logo.jpeg'),
//             ),
//           ),
//         ],
//       ),

//       // 🧱 BODY
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [

//               // 🌟 WELCOME CARD
//               Container(
//                 width: double.infinity,
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 22, vertical: 28),
//                 decoration: BoxDecoration(
//                   gradient: const LinearGradient(
//                     colors: [
//                       Color(0xFF007BFF),
//                       Color(0xFF00C853),
//                     ],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   borderRadius: BorderRadius.circular(20),
//                   boxShadow: const [
//                     BoxShadow(
//                       color: Colors.black12,
//                       blurRadius: 10,
//                       offset: Offset(0, 6),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   children: [
//                     const Text(
//                       "Welcome to Magna Credit",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     const Text(
//                       "Fast, secure and reliable loans designed for your needs.",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Colors.white70,
//                         fontSize: 15,
//                         height: 1.4,
//                       ),
//                     ),
//                     const SizedBox(height: 22),
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) =>
//                                   const TermsPoliciesPage()),
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.white,
//                         foregroundColor: const Color(0xFF007BFF),
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 14, horizontal: 40),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(14),
//                         ),
//                       ),
//                       child: const Text(
//                         "Apply for a Loan",
//                         style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 36),

//               // 🔹 WHY CHOOSE
//               const Text(
//                 "Why Choose Magna",
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF1A237E),
//                 ),
//               ),
//               const SizedBox(height: 18),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: const [
//                   _FeatureItem(
//                     icon: Icons.flash_on,
//                     label: "Fast Approval",
//                     color: Color(0xFF007BFF),
//                   ),
//                   _FeatureItem(
//                     icon: Icons.account_balance_wallet,
//                     label: "High Limits",
//                     color: Color(0xFF00C853),
//                   ),
//                   _FeatureItem(
//                     icon: Icons.security,
//                     label: "Secure",
//                     color: Color(0xFFFFA000),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 40),

//               // 🔹 LOAN PROCESS
//               Container(
//                 width: double.infinity,
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(18),
//                   boxShadow: const [
//                     BoxShadow(
//                       color: Colors.black12,
//                       blurRadius: 8,
//                       offset: Offset(0, 5),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   children: const [
//                     Text(
//                       "Loan Process",
//                       style: TextStyle(
//                         color: Color(0xFF007BFF),
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 12),
//                     Text(
//                       "Sign In → Verification → Loan Disbursement",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 15,
//                         color: Colors.black87,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),

//       // 🔻 BOTTOM NAV
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         selectedItemColor: const Color(0xFF007BFF),
//         unselectedItemColor: Colors.grey,
//         type: BottomNavigationBarType.fixed,
//         onTap: _onItemTapped,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//           BottomNavigationBarItem(icon: Icon(Icons.info_outline), label: "About"),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
//         ],
//       ),
//     );
//   }
// }

// // 🔹 FEATURE ITEM
// class _FeatureItem extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final Color color;

//   const _FeatureItem({
//     required this.icon,
//     required this.label,
//     required this.color,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           padding: const EdgeInsets.all(14),
//           decoration: BoxDecoration(
//             color: color.withOpacity(0.12),
//             shape: BoxShape.circle,
//           ),
//           child: Icon(icon, color: color, size: 28),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 13,
//             fontWeight: FontWeight.w500,
//             color: Colors.black87,
//           ),
//         ),
//       ],
//     );
//   }
// }












// // import 'package:flutter/material.dart';
// // // import 'signup_screen.dart';
// // import 'about_screen.dart';
// // import 'terms_and_policy.dart';
// // import 'profile_page.dart'; // ✅ Make sure you have this file

// // class HomePage extends StatefulWidget {
// //   const HomePage({super.key});

// //   @override
// //   State<HomePage> createState() => _HomePageState();
// // }

// // class _HomePageState extends State<HomePage> {
// //   int _selectedIndex = 0;

// //   // Handle bottom navigation taps
// //   void _onItemTapped(int index) {
// //     setState(() {
// //       _selectedIndex = index;
// //     });

// //     if (index == 0) {
// //       // Home (stay here)
// //     } else if (index == 1) {
// //       // Navigate to About Page
// //       Navigator.push(
// //         context,
// //         MaterialPageRoute(builder: (context) => const AboutPage()),
// //       );
// //     } else if (index == 2) {
// //       // Navigate to Profile Page
// //       Navigator.push(
// //         context,
// //         MaterialPageRoute(builder: (context) => const ProfilePage()),
// //       );
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: const Color(0xFFF5F8FA),
// //       appBar: AppBar(
// //         backgroundColor: const Color(0xFF007BFF),
// //         elevation: 4,
// //         title: const Text(
// //           "MAGNA CREDIT LIMITED",
// //           style: TextStyle(
// //             fontWeight: FontWeight.bold,
// //             color: Colors.white,
// //             fontSize: 18,
// //             letterSpacing: 0.5,
// //           ),
// //         ),
// //         centerTitle: true,
// //         actions: [
// //           Padding(
// //             padding: const EdgeInsets.only(right: 12),
// //             child: CircleAvatar(
// //               backgroundColor: Colors.white,
// //               radius: 18,
// //               backgroundImage: AssetImage('assets/magna_logo.jpeg'),
// //             ),
// //           ),
// //         ],
// //       ),

// //       // BODY CONTENT
// //       body: SingleChildScrollView(
// //         child: Padding(
// //           padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.center,
// //             children: [
// //               // 🌟 Welcome Banner
// //               Container(
// //                 padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 25),
// //                 decoration: BoxDecoration(
// //                   gradient: const LinearGradient(
// //                     colors: [Color(0xFF007BFF), Color.fromARGB(255, 27, 229, 33)],
// //                     begin: Alignment.topLeft,
// //                     end: Alignment.bottomRight,
// //                   ),
// //                   borderRadius: BorderRadius.circular(18),
// //                   boxShadow: [
// //                     BoxShadow(
// //                       color: Colors.black12,
// //                       blurRadius: 8,
// //                       offset: Offset(0, 4),
// //                     ),
// //                   ],
// //                 ),
// //                 child: Column(
// //                   children: [
// //                     Center(
// //                       child: const Text(
// //                         "Welcome to Magna Credit",
// //                         style: TextStyle(
// //                           color: Colors.white,
// //                           fontSize: 28,
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                       ),
// //                     ),
// //                     const SizedBox(height: 6),
// //                     const Text(
// //                       "Fast, easy, and reliable loans at your fingertips!",
// //                       style: TextStyle(
// //                         color: Colors.white70,
// //                         fontSize: 20,
// //                         fontWeight: FontWeight.bold,
// //                       ),
// //                       textAlign: TextAlign.center,
// //                     ),
// //                     const SizedBox(height: 15),
// //                     ElevatedButton(
// //                       onPressed: () {
// //                         Navigator.push(
// //                           context,
// //                           MaterialPageRoute(
// //                               builder: (context) => const TermsPoliciesPage()),
// //                         );
// //                       },
// //                       style: ElevatedButton.styleFrom(
// //                         backgroundColor: Colors.white,
// //                         foregroundColor: const Color(0xFF007BFF),
// //                         padding: const EdgeInsets.symmetric(
// //                             vertical: 12, horizontal: 35),
// //                         shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(10),
// //                         ),
// //                         elevation: 2,
// //                       ),
// //                       child: const Text(
// //                         "Apply for a Loan",
// //                         style:
// //                             TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),

// //               const SizedBox(height: 30),

// //               //  Why Choose Magna
// //               const Align(
// //                 alignment: Alignment.centerLeft,
// //                 child: Text(
// //                   "Why Choose Magna",
// //                   style: TextStyle(
// //                     fontSize: 20,
// //                     fontWeight: FontWeight.bold,
// //                     color: Colors.blueAccent,
// //                   ),
// //                 ),
// //               ),
// //               const SizedBox(height: 15),

// //               // 🔷 Features
// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: const [
// //                   _FeatureItem(
// //                     icon: Icons.flash_on,
// //                     label: "Fast Approval",
// //                     color: Color(0xFF007BFF),
// //                   ),
// //                   _FeatureItem(
// //                     icon: Icons.account_balance_wallet,
// //                     label: "High Quota",
// //                     color: Color(0xFF00C853),
// //                   ),
// //                   _FeatureItem(
// //                     icon: Icons.thumb_up,
// //                     label: "Trusted Service",
// //                     color: Color(0xFFFFC107),
// //                   ),
// //                 ],
// //               ),

              

// //               const SizedBox(height: 35),

// //               // 🔹 Loan Process
// //               Container(
// //                 width: double.infinity,
// //                 padding:
// //                     const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
// //                 decoration: BoxDecoration(
// //                   color: Colors.white,
// //                   borderRadius: BorderRadius.circular(14),
// //                   boxShadow: [
// //                     BoxShadow(
// //                       color: Colors.black12.withOpacity(0.08),
// //                       blurRadius: 8,
// //                       offset: const Offset(0, 4),
// //                     ),
// //                   ],
// //                 ),
// //                 child: Column(
// //                   children: const [
// //                     Text(
// //                       "Loan Process",
// //                       style: TextStyle(
// //                         color: Colors.blueAccent,
// //                         fontSize: 18,
// //                         fontWeight: FontWeight.bold,
// //                       ),
// //                     ),
// //                     SizedBox(height: 10),
// //                     Text(
// //                       "Sign In  ➜  Verification  ➜  Loan Disbursement",
// //                       style: TextStyle(
// //                         fontSize: 16,
// //                         color: Colors.black87,
// //                       ),
// //                       textAlign: TextAlign.center,
// //                     ),
// //                   ],
// //                 ),
// //               ),

// //               const SizedBox(height: 40),

// //               // 💵 Loan Info Box
// //               Container(
// //                 width: double.infinity,
// //                 padding:
// //                     const EdgeInsets.symmetric(vertical: 30, horizontal: 18),
// //                 decoration: BoxDecoration(
// //                   gradient: const LinearGradient(
// //                     colors: [Color(0xFF00C853), Color(0xFF009688)],
// //                     begin: Alignment.topLeft,
// //                     end: Alignment.bottomRight,
// //                   ),
// //                   borderRadius: BorderRadius.circular(15),
// //                   boxShadow: [
// //                     BoxShadow(
// //                       color: Colors.black12,
// //                       blurRadius: 10,
// //                       offset: Offset(0, 5),
// //                     ),
// //                   ],
// //                 ),
// //                 child: Column(
// //                   children: [
// //                     const Text(
// //                       "Maximum Amount:\nUGX 5,000,000",
// //                       textAlign: TextAlign.center,
// //                       style: TextStyle(
// //                         fontSize: 17,
// //                         color: Colors.white,
// //                         fontWeight: FontWeight.bold,
// //                       ),
// //                     ),
// //                     const SizedBox(height: 15),
// //                     OutlinedButton(
// //                       onPressed: () {
// //                         Navigator.push(
// //                           context,
// //                           MaterialPageRoute(
// //                               builder: (context) => const TermsPoliciesPage()),
// //                         );
// //                       },
// //                       style: OutlinedButton.styleFrom(
// //                         side: const BorderSide(color: Colors.white),
// //                         foregroundColor: Colors.white,
// //                         padding: const EdgeInsets.symmetric(
// //                             vertical: 12, horizontal: 35),
// //                         shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(10),
// //                         ),
// //                       ),
// //                       child: const Text(
// //                         "Apply Now",
// //                         style: TextStyle(fontSize: 20),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),

// //       // 🌍 Updated Bottom Navigation Bar
// //       bottomNavigationBar: BottomNavigationBar(
// //         backgroundColor: Colors.white,
// //         elevation: 8,
// //         currentIndex: _selectedIndex,
// //         selectedItemColor: const Color(0xFF007BFF),
// //         unselectedItemColor: Colors.grey,
// //         showUnselectedLabels: true,
// //         type: BottomNavigationBarType.fixed,
// //         onTap: _onItemTapped,
// //         items: const [
// //           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
// //           BottomNavigationBarItem(icon: Icon(Icons.info_outline), label: "About"),
// //           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // class _FeatureItem extends StatelessWidget {
// //   final IconData icon;
// //   final String label;
// //   final Color color;

// //   const _FeatureItem({
// //     required this.icon,
// //     required this.label,
// //     required this.color,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       children: [
// //         Container(
// //           decoration: BoxDecoration(
// //             color: color.withOpacity(0.1),
// //             shape: BoxShape.circle,
// //           ),
// //           padding: const EdgeInsets.all(15),
// //           child: Icon(icon, color: color, size: 30),
// //         ),
// //         const SizedBox(height: 8),
// //         Text(
// //           label,
// //           style: const TextStyle(
// //             fontSize: 13,
// //             color: Colors.black87,
// //             fontWeight: FontWeight.w500,
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }
