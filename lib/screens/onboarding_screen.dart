
import 'package:flutter/material.dart';
import 'package:magna_credit_app/screens/home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (index) {
                  setState(() => currentPage = index);
                },
                children: const [
                  _OnboardPage(
                    image: 'assets/loan.jpg',
                    title: 'Fast Loan Access',
                    description:
                        'Apply anytime, anywhere with zero paperwork and quick approvals straight from your phone.',
                  ),
                  _OnboardPage(
                    image: 'assets/pic3.jpg',
                    title: 'Magna Credit Limited',
                    description:
                        'Flexible financing for personal needs, business growth, and emergencies you can trust.',
                  ),
                  _OnboardPage(
                    image: 'assets/pic1.jpg',
                    title: 'Achieve Your Goals',
                    description:
                        'Turn your plans into reality with secure, fast, and reliable financial support.',
                  ),
                ],
              ),
            ),

            /// Page indicators
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    height: 8,
                    width: currentPage == index ? 22 : 8,
                    decoration: BoxDecoration(
                      color: currentPage == index
                          ? Colors.green
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                ),
              ),
            ),

            /// Bottom buttons
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: currentPage == 2
                  ? SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const HomePage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () => _controller.jumpToPage(2),
                          child: const Text(
                            'Skip',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => _controller.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 18, vertical: 10),
                            child: Text(
                              'Next',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ====================
/// Onboarding Page Widget
/// ====================
class _OnboardPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const _OnboardPage({
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// Image card
                  Container(
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 15,
                          offset: const Offset(0, 6),
                        ),
                      ],
                      image: DecorationImage(
                        image: AssetImage(image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  /// Title
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),

                  const SizedBox(height: 14),

                  /// Description
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
































// import 'package:flutter/material.dart';
// import 'package:magna_credit_app/screens/home_screen.dart';

// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({super.key});

//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> {
//   final PageController _controller = PageController();
//   bool isLastPage = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         //  Gradient background for a premium look
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors:  [Color.fromARGB(255, 27, 229, 33), Color(0xFF007BFF)], // green to aqua
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: SafeArea(
//           child: Column(
//             children: [
//               Expanded(
//                 child: PageView(
//                   controller: _controller,
//                   onPageChanged: (index) {
//                     setState(() => isLastPage = index == 2);
//                   },
//                   children: [
//                     buildPage(
//                       image: 'assets/loan.jpg',
//                       title: 'Fast Loan Access',
//                       description:
//                           'Apply anytime, anywhere — no long queues, no paperwork. Just your phone, your details, and your dreams.',
//                     ),
//                     buildPage(
//                       image: 'assets/pic3.jpg',
//                       title: 'Magna Credit Limited',
//                       description:
//                           'Whether for personal needs, business growth, or emergencies — Magna Credit helps you move forward with ease.',
//                     ),
//                     buildPage(
//                       image: 'assets/pic1.jpg',
//                       title: 'Achieve Your Goals',
//                       description:
//                           'Turn your plans into action effortlessly. Secure, fast, and reliable financing you can trust.',
//                     ),
//                   ],
//                 ),
//               ),

//               // 👇 Smooth Page Indicators
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 15),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: List.generate(
//                     3,
//                     (index) => AnimatedContainer(
//                       duration: const Duration(milliseconds: 400),
//                       margin: const EdgeInsets.symmetric(horizontal: 4),
//                       height: 8,
//                       width: _controller.hasClients &&
//                               _controller.page?.round() == index
//                           ? 20
//                           : 8,
//                       decoration: BoxDecoration(
//                         color: _controller.hasClients &&
//                                 _controller.page?.round() == index
//                             ? Colors.black
//                             : Colors.black,
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),

//               // 👇 Bottom navigation (Skip / Next / Get Started)
//               Container(
//                 height: 43,
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: isLastPage
//                     ? ElevatedButton(
//                         onPressed: () {
//                           Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (_) => const HomePage()),
//                           );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.white,
//                           foregroundColor: Colors.green,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         child: const Text(
//                           'Get Started',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       )
//                     : Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           TextButton(
//                             onPressed: () => _controller.jumpToPage(2),
//                             child: const Text(
//                               'Skip',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 25,
//                               ),
//                             ),
//                           ),
//                           ElevatedButton(
//                             onPressed: () => _controller.nextPage(
//                               duration: const Duration(milliseconds: 500),
//                               curve: Curves.easeInOut,
//                             ),
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.white,
//                               foregroundColor: Colors.green,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                             ),
//                             child: const Text(
//                               'Next',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 18,

//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildPage({
//     required String image,
//     required String title,
//     required String description,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           // 🖼 Rounded image with shadow
//           Container(
//             height: 160,
//             width: 220,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black26,
//                   blurRadius: 5,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//               image: DecorationImage(
//                 image: AssetImage(image),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),

//           // ✨ Title
//           Text(
//             title,
//             style: const TextStyle(
//               fontSize: 30,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//               letterSpacing: 0.5,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 12),

//           // 💬 Description
//           Text(
//             description,
//             textAlign: TextAlign.center,
//             style: const TextStyle(
//               fontSize: 20,
//               color: Colors.white,
//               height: 1.5,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


















