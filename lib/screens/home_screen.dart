import 'package:flutter/material.dart';
import 'about_screen.dart';
import 'terms_and_policy.dart';
import 'profile_page.dart';
import 'settings_page.dart';

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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,

      appBar: AppBar(
        backgroundColor: const Color(0xFF007BFF), // BLUE ALWAYS
        elevation: 3,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.settings, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SettingsPage(),
              ),
            );
          },
        ),
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

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Why Choose Magna",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : const Color(0xFF1A237E),
                ),
              ),
              const SizedBox(height: 18),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _FeatureItem(
                    icon: Icons.flash_on,
                    label: "Fast Approval",
                    color: const Color(0xFF007BFF),
                    textColor: isDark ? Colors.white : Colors.black87,
                  ),
                  _FeatureItem(
                    icon: Icons.account_balance_wallet,
                    label: "High Limits",
                    color: const Color(0xFF00C853),
                    textColor: isDark ? Colors.white : Colors.black87,
                  ),
                  _FeatureItem(
                    icon: Icons.security,
                    label: "Secure",
                    color: const Color(0xFFFFA000),
                    textColor: isDark ? Colors.white : Colors.black87,
                  ),
                ],
              ),

              const SizedBox(height: 36),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 30),
                decoration: BoxDecoration(
                  color: const Color(0xFF1BBE6D),
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

              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[900] : Colors.white,
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
                  children: [
                    Text(
                      "Loan Process",
                      style: TextStyle(
                        color: const Color(0xFF007BFF),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Sign In → Verification → Loan Disbursement",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF007BFF),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        backgroundColor: isDark ? Colors.black : Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.info_outline), label: "About"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color textColor;

  const _FeatureItem({
    required this.icon,
    required this.label,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: textColor,
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
// import 'settings_page.dart';

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
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,

//       appBar: AppBar(
//         elevation: 3,
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(Icons.settings, color: Colors.white),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const SettingsPage(),
//               ),
//             );
//           },
//         ),
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

//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Why Choose Magna",
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                   color: isDark ? Colors.white : const Color(0xFF1A237E),
//                 ),
//               ),
//               const SizedBox(height: 18),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   _FeatureItem(
//                     icon: Icons.flash_on,
//                     label: "Fast Approval",
//                     color: const Color(0xFF007BFF),
//                     textColor: isDark ? Colors.white : Colors.black87,
//                   ),
//                   _FeatureItem(
//                     icon: Icons.account_balance_wallet,
//                     label: "High Limits",
//                     color: const Color(0xFF00C853),
//                     textColor: isDark ? Colors.white : Colors.black87,
//                   ),
//                   _FeatureItem(
//                     icon: Icons.security,
//                     label: "Secure",
//                     color: const Color(0xFFFFA000),
//                     textColor: isDark ? Colors.white : Colors.black87,
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 36),

//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 30),
//                 decoration: BoxDecoration(
//                   color: const Color(0xFF1BBE6D),
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
//                         fontSize: 19,
//                         height: 1.4,
//                       ),
//                     ),
//                     const SizedBox(height: 22),
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const TermsPoliciesPage(),
//                           ),
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.white,
//                         foregroundColor: const Color(0xFF1BBE6D),
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 14, horizontal: 40),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(14),
//                         ),
//                       ),
//                       child: const Text(
//                         "Apply for a Loan",
//                         style: TextStyle(
//                           fontSize: 19,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 40),

//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
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

// class _FeatureItem extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final Color color;
//   final Color textColor;

//   const _FeatureItem({
//     required this.icon,
//     required this.label,
//     required this.color,
//     required this.textColor,
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
//           style: TextStyle(
//             fontSize: 13,
//             fontWeight: FontWeight.w500,
//             color: textColor,
//           ),
//         ),
//       ],
//     );
//   }
// }




// import 'package:flutter/material.dart';
// import 'about_screen.dart';
// import 'terms_and_policy.dart';
// import 'profile_page.dart';
// import 'settings_page.dart'; 

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

//         // ⚙️ SETTINGS ICON (TOP LEFT)
//         leading: IconButton(
//           icon: const Icon(Icons.settings, color: Colors.white),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const SettingsPage(),
//               ),
//             );
//           },
//         ),

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

//               // 🔹 WHY CHOOSE MAGNA
//               const Text(
//                 "Why Choose Magna",
//                 style: TextStyle(
//                   fontSize: 22,
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

//               const SizedBox(height: 36),

//               // WELCOME CARD
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 30),
//                 decoration: BoxDecoration(
//                   color: const Color(0xFF1BBE6D),
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
//                         fontSize: 19,
//                         height: 1.4,
//                       ),
//                     ),
//                     const SizedBox(height: 22),
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const TermsPoliciesPage(),
//                           ),
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.white,
//                         foregroundColor: const Color(0xFF1BBE6D),
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 14, horizontal: 40),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(14),
//                         ),
//                       ),
//                       child: const Text(
//                         "Apply for a Loan",
//                         style: TextStyle(
//                           fontSize: 19,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 40),

//               // 🔹 LOAN PROCESS
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
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
// // import 'about_screen.dart';
// // import 'terms_and_policy.dart';
// // import 'profile_page.dart';

// // class HomePage extends StatefulWidget {
// //   const HomePage({super.key});

// //   @override
// //   State<HomePage> createState() => _HomePageState();
// // }

// // class _HomePageState extends State<HomePage> {
// //   int _selectedIndex = 0;

// //   void _onItemTapped(int index) {
// //     setState(() => _selectedIndex = index);

// //     if (index == 1) {
// //       Navigator.push(
// //         context,
// //         MaterialPageRoute(builder: (context) => const AboutPage()),
// //       );
// //     } else if (index == 2) {
// //       Navigator.push(
// //         context,
// //         MaterialPageRoute(builder: (context) => const ProfilePage()),
// //       );
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: const Color(0xFFF4F7FB),

// //       // 🔵 APP BAR
// //       appBar: AppBar(
// //         backgroundColor: const Color(0xFF007BFF),
// //         elevation: 3,
// //         centerTitle: true,
// //         title: const Text(
// //           "MAGNA CREDIT LIMITED",
// //           style: TextStyle(
// //             fontWeight: FontWeight.bold,
// //             color: Colors.white,
// //             fontSize: 17,
// //             letterSpacing: 0.6,
// //           ),
// //         ),
// //         actions: const [
// //           Padding(
// //             padding: EdgeInsets.only(right: 12),
// //             child: CircleAvatar(
// //               radius: 17,
// //               backgroundImage: AssetImage('assets/magna_logo.jpeg'),
// //             ),
// //           ),
// //         ],
// //       ),

// //       // 🧱 BODY
// //       body: SingleChildScrollView(
// //         child: Padding(
// //           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [

// //               // 🔹 WHY CHOOSE MAGNA (NOW FIRST)
// //               const Text(
// //                 "Why Choose Magna",
// //                 style: TextStyle(
// //                   fontSize: 22,
// //                   fontWeight: FontWeight.bold,
// //                   color: Color(0xFF1A237E),
// //                 ),
// //               ),
// //               const SizedBox(height: 18),

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
// //                     label: "High Limits",
// //                     color: Color(0xFF00C853),
// //                   ),
// //                   _FeatureItem(
// //                     icon: Icons.security,
// //                     label: "Secure",
// //                     color: Color(0xFFFFA000),
// //                   ),
// //                 ],
// //               ),

// //               const SizedBox(height: 36),

// //               // WELCOME CARD (GREEN BACKGROUND)
// //               Container(
// //                 width: double.infinity,
// //                 padding:
// //                     const EdgeInsets.symmetric(horizontal: 22, vertical: 30),
// //                 decoration: BoxDecoration(
// //                   color: const Color(0xFF1BBE6D), // ✅ Solid green
// //                   borderRadius: BorderRadius.circular(20),
// //                   boxShadow: const [
// //                     BoxShadow(
// //                       color: Colors.black12,
// //                       blurRadius: 10,
// //                       offset: Offset(0, 6),
// //                     ),
// //                   ],
// //                 ),
// //                 child: Column(
// //                   children: [
// //                     const Text(
// //                       "Welcome to Magna Credit",
// //                       textAlign: TextAlign.center,
// //                       style: TextStyle(
// //                         color: Colors.white,
// //                         fontSize: 24,
// //                         fontWeight: FontWeight.bold,
// //                       ),
// //                     ),
// //                     const SizedBox(height: 10),
// //                     const Text(
// //                       "Fast, secure and reliable loans designed for your needs.",
// //                       textAlign: TextAlign.center,
// //                       style: TextStyle(
// //                         color: Colors.white70,
// //                         fontSize: 19,
// //                         height: 1.4,
// //                       ),
// //                     ),
// //                     const SizedBox(height: 22),
// //                     ElevatedButton(
// //                       onPressed: () {
// //                         Navigator.push(
// //                           context,
// //                           MaterialPageRoute(
// //                             builder: (context) => const TermsPoliciesPage(),
// //                           ),
// //                         );
// //                       },
// //                       style: ElevatedButton.styleFrom(
// //                         backgroundColor: Colors.white,
// //                         foregroundColor: const Color(0xFF1BBE6D),
// //                         padding: const EdgeInsets.symmetric(
// //                             vertical: 14, horizontal: 40),
// //                         shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(14),
// //                         ),
// //                       ),
// //                       child: const Text(
// //                         "Apply for a Loan",
// //                         style: TextStyle(
// //                           fontSize: 19,
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),

// //               const SizedBox(height: 40),

// //               // 🔹 LOAN PROCESS (LAST)
// //               Container(
// //                 width: double.infinity,
// //                 padding:
// //                     const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
// //                 decoration: BoxDecoration(
// //                   color: Colors.white,
// //                   borderRadius: BorderRadius.circular(18),
// //                   boxShadow: const [
// //                     BoxShadow(
// //                       color: Colors.black12,
// //                       blurRadius: 8,
// //                       offset: Offset(0, 5),
// //                     ),
// //                   ],
// //                 ),
// //                 child: Column(
// //                   children: const [
// //                     Text(
// //                       "Loan Process",
// //                       style: TextStyle(
// //                         color: Color(0xFF007BFF),
// //                         fontSize: 18,
// //                         fontWeight: FontWeight.bold,
// //                       ),
// //                     ),
// //                     SizedBox(height: 12),
// //                     Text(
// //                       "Sign In → Verification → Loan Disbursement",
// //                       textAlign: TextAlign.center,
// //                       style: TextStyle(
// //                         fontSize: 15,
// //                         color: Colors.black87,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),

// //       // 🔻 BOTTOM NAV
// //       bottomNavigationBar: BottomNavigationBar(
// //         currentIndex: _selectedIndex,
// //         selectedItemColor: const Color(0xFF007BFF),
// //         unselectedItemColor: Colors.grey,
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

// // // 🔹 FEATURE ITEM
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
// //           padding: const EdgeInsets.all(14),
// //           decoration: BoxDecoration(
// //             // ignore: deprecated_member_use
// //             color: color.withOpacity(0.12),
// //             shape: BoxShape.circle,
// //           ),
// //           child: Icon(icon, color: color, size: 28),
// //         ),
// //         const SizedBox(height: 8),
// //         Text(
// //           label,
// //           style: const TextStyle(
// //             fontSize: 13,
// //             fontWeight: FontWeight.w500,
// //             color: Colors.black87,
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }
