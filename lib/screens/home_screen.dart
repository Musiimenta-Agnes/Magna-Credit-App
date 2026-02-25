

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
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;

//     return Scaffold(
//       backgroundColor: isDark ? Colors.black : Colors.white,

//       appBar: AppBar(
//         backgroundColor: const Color(0xFF007BFF),
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
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: isDark ? Colors.white : const Color(0xFF007BFF),
//                 ),
//               ),

//               const SizedBox(height: 0),

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
//                     color: Colors.green,
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

//               const SizedBox(height: 55),

//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 30),
//                 decoration: BoxDecoration(
//                   color: Colors.green,
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
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 6),
//                     const Text(
//                       "Fast, secure and reliable loans designed for your needs.",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Colors.white70,
//                         fontSize: 15,
//                         height: 1.4,
//                       ),
//                     ),
//                     const SizedBox(height: 16),
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
//                         foregroundColor: Colors.green,
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 5, horizontal: 30),
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

//               const SizedBox(height: 60),

//               // ── PREMIUM LOAN PROCESS ──
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 20),
//                 decoration: BoxDecoration(
//                   color: isDark ? Colors.grey[900] : Colors.white,
//                   borderRadius: BorderRadius.circular(22),
//                   border: Border.all(
//                     color: const Color(0xFF007BFF).withOpacity(0.12),
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: const Color(0xFF007BFF).withOpacity(0.07),
//                       blurRadius: 18,
//                       offset: const Offset(0, 6),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Section title with accent bar
//                     Row(
//                       children: [
//                         Container(
//                           width: 4,
//                           height: 22,
//                           decoration: BoxDecoration(
//                             gradient: const LinearGradient(
//                               begin: Alignment.topCenter,
//                               end: Alignment.bottomCenter,
//                               colors: [Color(0xFF007BFF), Colors.green],
//                             ),
//                             borderRadius: BorderRadius.circular(2),
//                           ),
//                         ),
//                         const SizedBox(width: 10),
//                         const Text(
//                           "Loan Process",
//                           style: TextStyle(
//                             color: Color(0xFF007BFF),
//                             fontSize: 17,
//                             fontWeight: FontWeight.bold,
//                             letterSpacing: 0.3,
//                           ),
//                         ),
//                       ],
//                     ),

//                     const SizedBox(height: 24),

//                     // Steps row
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         _LoanStep(
//                           step: "1",
//                           icon: Icons.login_rounded,
//                           label: "Sign In",
//                           color: const Color(0xFF007BFF),
//                           isDark: isDark,
//                         ),
//                         _StepConnector(),
//                         _LoanStep(
//                           step: "2",
//                           icon: Icons.shield_outlined,
//                           label: "Verification",
//                           color: Colors.green,
//                           isDark: isDark,
//                         ),
//                         _StepConnector(),
//                         _LoanStep(
//                           step: "3",
//                           icon: Icons.payments_rounded,
//                           label: "Disbursement",
//                           color: const Color(0xFF007BFF),
//                           isDark: isDark,
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 20),

//               // ── QUICK STATS STRIP ──
//               Row(
//                 children: [
//                   _StatChip(
//                     value: "24hrs",
//                     label: "Fast Payout",
//                     icon: Icons.bolt_rounded,
//                     color: Colors.green,
//                     isDark: isDark,
//                   ),
//                   const SizedBox(width: 10),
//                   _StatChip(
//                     value: "0%",
//                     label: "Hidden Fees",
//                     icon: Icons.visibility_off_outlined,
//                     color: const Color(0xFF007BFF),
//                     isDark: isDark,
//                   ),
//                   const SizedBox(width: 10),
//                   _StatChip(
//                     value: "100%",
//                     label: "Secure",
//                     icon: Icons.lock_outline_rounded,
//                     color: Colors.green,
//                     isDark: isDark,
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 30),
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
//         backgroundColor: isDark ? Colors.black : Colors.white,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//           BottomNavigationBarItem(icon: Icon(Icons.info_outline), label: "About"),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
//         ],
//       ),
//     );
//   }
// }

// // ── Loan Step ──
// class _LoanStep extends StatelessWidget {
//   final String step;
//   final IconData icon;
//   final String label;
//   final Color color;
//   final bool isDark;

//   const _LoanStep({
//     required this.step,
//     required this.icon,
//     required this.label,
//     required this.color,
//     required this.isDark,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           width: 54,
//           height: 54,
//           decoration: BoxDecoration(
//             color: color.withOpacity(0.1),
//             shape: BoxShape.circle,
//             border: Border.all(color: color.withOpacity(0.3), width: 1.5),
//           ),
//           child: Icon(icon, color: color, size: 24),
//         ),
//         const SizedBox(height: 6),
//         Text(
//           "Step $step",
//           style: TextStyle(
//             color: color,
//             fontSize: 10,
//             fontWeight: FontWeight.w700,
//             letterSpacing: 1,
//           ),
//         ),
//         const SizedBox(height: 2),
//         Text(
//           label,
//           style: TextStyle(
//             color: isDark ? Colors.white : Colors.black87,
//             fontSize: 12,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ],
//     );
//   }
// }

// // ── Step Connector (dashed line) ──
// class _StepConnector extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: List.generate(
//         4,
//         (_) => Container(
//           width: 5,
//           height: 1.5,
//           margin: const EdgeInsets.symmetric(horizontal: 1),
//           decoration: BoxDecoration(
//             color: const Color(0xFF007BFF).withOpacity(0.3),
//             borderRadius: BorderRadius.circular(1),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // ── Stat Chip ──
// class _StatChip extends StatelessWidget {
//   final String value;
//   final String label;
//   final IconData icon;
//   final Color color;
//   final bool isDark;

//   const _StatChip({
//     required this.value,
//     required this.label,
//     required this.icon,
//     required this.color,
//     required this.isDark,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
//         decoration: BoxDecoration(
//           color: color.withOpacity(0.07),
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(color: color.withOpacity(0.18)),
//         ),
//         child: Column(
//           children: [
//             Icon(icon, color: color, size: 20),
//             const SizedBox(height: 6),
//             Text(
//               value,
//               style: TextStyle(
//                 color: color,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w800,
//                 letterSpacing: 0.5,
//               ),
//             ),
//             const SizedBox(height: 2),
//             Text(
//               label,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: isDark ? Colors.white70 : Colors.black54,
//                 fontSize: 10,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ── Original Feature Item (unchanged) ──
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





// // import 'package:flutter/material.dart';
// // import 'about_screen.dart';
// // import 'terms_and_policy.dart';
// // import 'profile_page.dart';
// // import 'settings_page.dart'; 

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

// //         // ⚙️ SETTINGS ICON (TOP LEFT)
// //         leading: IconButton(
// //           icon: const Icon(Icons.settings, color: Colors.white),
// //           onPressed: () {
// //             Navigator.push(
// //               context,
// //               MaterialPageRoute(
// //                 builder: (context) => const SettingsPage(),
// //               ),
// //             );
// //           },
// //         ),

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

// //               // 🔹 WHY CHOOSE MAGNA
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

// //               // WELCOME CARD
// //               Container(
// //                 width: double.infinity,
// //                 padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 30),
// //                 decoration: BoxDecoration(
// //                   color: const Color(0xFF1BBE6D),
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

// //               // 🔹 LOAN PROCESS
// //               Container(
// //                 width: double.infinity,
// //                 padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
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


























// // // import 'package:flutter/material.dart';
// // // import 'about_screen.dart';
// // // import 'terms_and_policy.dart';
// // // import 'profile_page.dart';

// // // class HomePage extends StatefulWidget {
// // //   const HomePage({super.key});

// // //   @override
// // //   State<HomePage> createState() => _HomePageState();
// // // }

// // // class _HomePageState extends State<HomePage> {
// // //   int _selectedIndex = 0;

// // //   void _onItemTapped(int index) {
// // //     setState(() => _selectedIndex = index);

// // //     if (index == 1) {
// // //       Navigator.push(
// // //         context,
// // //         MaterialPageRoute(builder: (context) => const AboutPage()),
// // //       );
// // //     } else if (index == 2) {
// // //       Navigator.push(
// // //         context,
// // //         MaterialPageRoute(builder: (context) => const ProfilePage()),
// // //       );
// // //     }
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       backgroundColor: const Color(0xFFF4F7FB),

// // //       // 🔵 APP BAR
// // //       appBar: AppBar(
// // //         backgroundColor: const Color(0xFF007BFF),
// // //         elevation: 3,
// // //         centerTitle: true,
// // //         title: const Text(
// // //           "MAGNA CREDIT LIMITED",
// // //           style: TextStyle(
// // //             fontWeight: FontWeight.bold,
// // //             color: Colors.white,
// // //             fontSize: 17,
// // //             letterSpacing: 0.6,
// // //           ),
// // //         ),
// // //         actions: const [
// // //           Padding(
// // //             padding: EdgeInsets.only(right: 12),
// // //             child: CircleAvatar(
// // //               radius: 17,
// // //               backgroundImage: AssetImage('assets/magna_logo.jpeg'),
// // //             ),
// // //           ),
// // //         ],
// // //       ),

// // //       // 🧱 BODY
// // //       body: SingleChildScrollView(
// // //         child: Padding(
// // //           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
// // //           child: Column(
// // //             crossAxisAlignment: CrossAxisAlignment.start,
// // //             children: [

// // //               // 🔹 WHY CHOOSE MAGNA (NOW FIRST)
// // //               const Text(
// // //                 "Why Choose Magna",
// // //                 style: TextStyle(
// // //                   fontSize: 22,
// // //                   fontWeight: FontWeight.bold,
// // //                   color: Color(0xFF1A237E),
// // //                 ),
// // //               ),
// // //               const SizedBox(height: 18),

// // //               Row(
// // //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                 children: const [
// // //                   _FeatureItem(
// // //                     icon: Icons.flash_on,
// // //                     label: "Fast Approval",
// // //                     color: Color(0xFF007BFF),
// // //                   ),
// // //                   _FeatureItem(
// // //                     icon: Icons.account_balance_wallet,
// // //                     label: "High Limits",
// // //                     color: Color(0xFF00C853),
// // //                   ),
// // //                   _FeatureItem(
// // //                     icon: Icons.security,
// // //                     label: "Secure",
// // //                     color: Color(0xFFFFA000),
// // //                   ),
// // //                 ],
// // //               ),

// // //               const SizedBox(height: 36),

// // //               // WELCOME CARD (GREEN BACKGROUND)
// // //               Container(
// // //                 width: double.infinity,
// // //                 padding:
// // //                     const EdgeInsets.symmetric(horizontal: 22, vertical: 30),
// // //                 decoration: BoxDecoration(
// // //                   color: const Color(0xFF1BBE6D), // ✅ Solid green
// // //                   borderRadius: BorderRadius.circular(20),
// // //                   boxShadow: const [
// // //                     BoxShadow(
// // //                       color: Colors.black12,
// // //                       blurRadius: 10,
// // //                       offset: Offset(0, 6),
// // //                     ),
// // //                   ],
// // //                 ),
// // //                 child: Column(
// // //                   children: [
// // //                     const Text(
// // //                       "Welcome to Magna Credit",
// // //                       textAlign: TextAlign.center,
// // //                       style: TextStyle(
// // //                         color: Colors.white,
// // //                         fontSize: 24,
// // //                         fontWeight: FontWeight.bold,
// // //                       ),
// // //                     ),
// // //                     const SizedBox(height: 10),
// // //                     const Text(
// // //                       "Fast, secure and reliable loans designed for your needs.",
// // //                       textAlign: TextAlign.center,
// // //                       style: TextStyle(
// // //                         color: Colors.white70,
// // //                         fontSize: 19,
// // //                         height: 1.4,
// // //                       ),
// // //                     ),
// // //                     const SizedBox(height: 22),
// // //                     ElevatedButton(
// // //                       onPressed: () {
// // //                         Navigator.push(
// // //                           context,
// // //                           MaterialPageRoute(
// // //                             builder: (context) => const TermsPoliciesPage(),
// // //                           ),
// // //                         );
// // //                       },
// // //                       style: ElevatedButton.styleFrom(
// // //                         backgroundColor: Colors.white,
// // //                         foregroundColor: const Color(0xFF1BBE6D),
// // //                         padding: const EdgeInsets.symmetric(
// // //                             vertical: 14, horizontal: 40),
// // //                         shape: RoundedRectangleBorder(
// // //                           borderRadius: BorderRadius.circular(14),
// // //                         ),
// // //                       ),
// // //                       child: const Text(
// // //                         "Apply for a Loan",
// // //                         style: TextStyle(
// // //                           fontSize: 19,
// // //                           fontWeight: FontWeight.bold,
// // //                         ),
// // //                       ),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),

// // //               const SizedBox(height: 40),

// // //               // 🔹 LOAN PROCESS (LAST)
// // //               Container(
// // //                 width: double.infinity,
// // //                 padding:
// // //                     const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
// // //                 decoration: BoxDecoration(
// // //                   color: Colors.white,
// // //                   borderRadius: BorderRadius.circular(18),
// // //                   boxShadow: const [
// // //                     BoxShadow(
// // //                       color: Colors.black12,
// // //                       blurRadius: 8,
// // //                       offset: Offset(0, 5),
// // //                     ),
// // //                   ],
// // //                 ),
// // //                 child: Column(
// // //                   children: const [
// // //                     Text(
// // //                       "Loan Process",
// // //                       style: TextStyle(
// // //                         color: Color(0xFF007BFF),
// // //                         fontSize: 18,
// // //                         fontWeight: FontWeight.bold,
// // //                       ),
// // //                     ),
// // //                     SizedBox(height: 12),
// // //                     Text(
// // //                       "Sign In → Verification → Loan Disbursement",
// // //                       textAlign: TextAlign.center,
// // //                       style: TextStyle(
// // //                         fontSize: 15,
// // //                         color: Colors.black87,
// // //                       ),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       ),

// // //       // 🔻 BOTTOM NAV
// // //       bottomNavigationBar: BottomNavigationBar(
// // //         currentIndex: _selectedIndex,
// // //         selectedItemColor: const Color(0xFF007BFF),
// // //         unselectedItemColor: Colors.grey,
// // //         type: BottomNavigationBarType.fixed,
// // //         onTap: _onItemTapped,
// // //         items: const [
// // //           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
// // //           BottomNavigationBarItem(icon: Icon(Icons.info_outline), label: "About"),
// // //           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }

// // // // 🔹 FEATURE ITEM
// // // class _FeatureItem extends StatelessWidget {
// // //   final IconData icon;
// // //   final String label;
// // //   final Color color;

// // //   const _FeatureItem({
// // //     required this.icon,
// // //     required this.label,
// // //     required this.color,
// // //   });

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Column(
// // //       children: [
// // //         Container(
// // //           padding: const EdgeInsets.all(14),
// // //           decoration: BoxDecoration(
// // //             // ignore: deprecated_member_use
// // //             color: color.withOpacity(0.12),
// // //             shape: BoxShape.circle,
// // //           ),
// // //           child: Icon(icon, color: color, size: 28),
// // //         ),
// // //         const SizedBox(height: 8),
// // //         Text(
// // //           label,
// // //           style: const TextStyle(
// // //             fontSize: 13,
// // //             fontWeight: FontWeight.w500,
// // //             color: Colors.black87,
// // //           ),
// // //         ),
// // //       ],
// // //     );
// // //   }
// // // }












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
        backgroundColor: const Color(0xFF007BFF),
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        // ── Logo on the left ──
        leading: Padding(
          padding: const EdgeInsets.all(9),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 1.5),
            ),
            child: const CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage('assets/magna_logo.jpeg'),
            ),
          ),
        ),
        title: const Text(
          "MAGNA CREDIT",
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
            fontSize: 16,
            letterSpacing: 1.5,
          ),
        ),
        // ── Three-dot menu on the right ──
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert_rounded, color: Colors.white),
            color: isDark ? const Color(0xFF1A1A2E) : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            offset: const Offset(0, 48),
            onSelected: (value) {
              if (value == 'settings') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                  ),
                );
              }
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                value: 'settings',
                child: Row(
                  children: [
                    Icon(Icons.settings_rounded,
                        color: isDark
                            ? Colors.white70
                            : const Color(0xFF007BFF),
                        size: 18),
                    const SizedBox(width: 10),
                    Text(
                      "Settings",
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(3),
          child: Container(
            height: 3,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF007BFF), Colors.green],
              ),
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Greeting header ──
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Good Day 👋",
                        style: TextStyle(
                          fontSize: 13,
                          color: isDark ? Colors.white54 : Colors.black45,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Why Choose Magna?",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: isDark ? Colors.white : const Color(0xFF007BFF),
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.green.withOpacity(0.3)),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.circle, color: Colors.green, size: 8),
                        SizedBox(width: 5),
                        Text(
                          "Active",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 22),

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
                    color: Colors.green,
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

              const SizedBox(height: 28),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 30),
                decoration: BoxDecoration(
                  color: Colors.green,
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
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "Fast, secure and reliable loans designed for your needs.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 16),
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
                        foregroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        "Apply for a Loan",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 60),

              // ── PREMIUM LOAN PROCESS ──
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 20),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[900] : Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: const Color(0xFF007BFF).withOpacity(0.12),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF007BFF).withOpacity(0.07),
                      blurRadius: 18,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section title with accent bar
                    Row(
                      children: [
                        Container(
                          width: 4,
                          height: 22,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xFF007BFF), Colors.green],
                            ),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          "Loan Process",
                          style: TextStyle(
                            color: Color(0xFF007BFF),
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Steps row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _LoanStep(
                          step: "1",
                          icon: Icons.login_rounded,
                          label: "Sign In",
                          color: const Color(0xFF007BFF),
                          isDark: isDark,
                        ),
                        _StepConnector(),
                        _LoanStep(
                          step: "2",
                          icon: Icons.shield_outlined,
                          label: "Verification",
                          color: Colors.green,
                          isDark: isDark,
                        ),
                        _StepConnector(),
                        _LoanStep(
                          step: "3",
                          icon: Icons.payments_rounded,
                          label: "Disbursement",
                          color: const Color(0xFF007BFF),
                          isDark: isDark,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ── QUICK STATS STRIP ──
              Row(
                children: [
                  _StatChip(
                    value: "24hrs",
                    label: "Fast Payout",
                    icon: Icons.bolt_rounded,
                    color: Colors.green,
                    isDark: isDark,
                  ),
                  const SizedBox(width: 10),
                  _StatChip(
                    value: "0%",
                    label: "Hidden Fees",
                    icon: Icons.visibility_off_outlined,
                    color: const Color(0xFF007BFF),
                    isDark: isDark,
                  ),
                  const SizedBox(width: 10),
                  _StatChip(
                    value: "100%",
                    label: "Secure",
                    icon: Icons.lock_outline_rounded,
                    color: Colors.green,
                    isDark: isDark,
                  ),
                ],
              ),

              const SizedBox(height: 30),
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

// ── Loan Step ──
class _LoanStep extends StatelessWidget {
  final String step;
  final IconData icon;
  final String label;
  final Color color;
  final bool isDark;

  const _LoanStep({
    required this.step,
    required this.icon,
    required this.label,
    required this.color,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
            border: Border.all(color: color.withOpacity(0.3), width: 1.5),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 6),
        Text(
          "Step $step",
          style: TextStyle(
            color: color,
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black87,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// ── Step Connector (dashed line) ──
class _StepConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        4,
        (_) => Container(
          width: 5,
          height: 1.5,
          margin: const EdgeInsets.symmetric(horizontal: 1),
          decoration: BoxDecoration(
            color: const Color(0xFF007BFF).withOpacity(0.3),
            borderRadius: BorderRadius.circular(1),
          ),
        ),
      ),
    );
  }
}

// ── Stat Chip ──
class _StatChip extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color color;
  final bool isDark;

  const _StatChip({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.07),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.18)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 6),
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 16,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isDark ? Colors.white70 : Colors.black54,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Original Feature Item (unchanged) ──
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