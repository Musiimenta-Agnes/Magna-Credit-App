
// import 'package:flutter/material.dart';
// import 'package:magna_credit_app/screens/home_screen.dart';

// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({super.key});

//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> {
//   final PageController _controller = PageController();
//   int currentPage = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: PageView(
//                 controller: _controller,
//                 onPageChanged: (index) {
//                   setState(() => currentPage = index);
//                 },
//                 children: const [
//                   _OnboardPage(
//                     image: 'assets/loan.jpg',
//                     title: 'Fast Loan Access',
//                     description:
//                         'Apply anytime, anywhere with zero paperwork and quick approvals straight from your phone.',
//                   ),
//                   _OnboardPage(
//                     image: 'assets/pic3.jpg',
//                     title: 'Magna Credit Limited',
//                     description:
//                         'Flexible financing for personal needs, business growth, and emergencies you can trust.',
//                   ),
//                   _OnboardPage(
//                     image: 'assets/pic1.jpg',
//                     title: 'Achieve Your Goals',
//                     description:
//                         'Turn your plans into reality with secure, fast, and reliable financial support.',
//                   ),
//                 ],
//               ),
//             ),

//             /// Page indicators
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: List.generate(
//                   3,
//                   (index) => AnimatedContainer(
//                     duration: const Duration(milliseconds: 300),
//                     margin: const EdgeInsets.symmetric(horizontal: 5),
//                     height: 8,
//                     width: currentPage == index ? 22 : 8,
//                     decoration: BoxDecoration(
//                       color: currentPage == index
//                           ? Colors.green
//                           : Colors.grey.shade300,
//                       borderRadius: BorderRadius.circular(7),
//                     ),
//                   ),
//                 ),
//               ),
//             ),

//             /// Bottom buttons
//             Padding(
//               padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
//               child: currentPage == 2
//                   ? SizedBox(
//                       width: double.infinity,
//                       height: 48,
//                       child: ElevatedButton(
//                         onPressed: () {
//                           Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                               builder: (_) => const HomePage(),
//                             ),
//                           );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.green,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(14),
//                           ),
//                         ),
//                         child: const Text(
//                           'Get Started',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     )
//                   : Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         TextButton(
//                           onPressed: () => _controller.jumpToPage(2),
//                           child: const Text(
//                             'Skip',
//                             style: TextStyle(
//                               color: Colors.grey,
//                               fontSize: 16,
//                             ),
//                           ),
//                         ),
//                         ElevatedButton(
//                           onPressed: () => _controller.nextPage(
//                             duration: const Duration(milliseconds: 400),
//                             curve: Curves.easeInOut,
//                           ),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.green,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(14),
//                             ),
//                           ),
//                           child: const Padding(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: 18, vertical: 10),
//                             child: Text(
//                               'Next',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// /// ====================
// /// Onboarding Page Widget
// /// ====================
// class _OnboardPage extends StatelessWidget {
//   final String image;
//   final String title;
//   final String description;

//   const _OnboardPage({
//     required this.image,
//     required this.title,
//     required this.description,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return SingleChildScrollView(
//           child: ConstrainedBox(
//             constraints: BoxConstraints(
//               minHeight: constraints.maxHeight,
//             ),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   /// Image card
//                   Container(
//                     height: 250,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: Colors.white,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.08),
//                           blurRadius: 15,
//                           offset: const Offset(0, 6),
//                         ),
//                       ],
//                       image: DecorationImage(
//                         image: AssetImage(image),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 32),

//                   /// Title
//                   Text(
//                     title,
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(
//                       fontSize: 26,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF1F2937),
//                     ),
//                   ),

//                   const SizedBox(height: 14),

//                   /// Description
//                   Text(
//                     description,
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.grey.shade600,
//                       height: 1.6,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }





import 'package:flutter/material.dart';
import 'package:magna_credit_app/screens/home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  final PageController _controller = PageController();
  int currentPage = 0;

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  static const Color _blue = Color(0xFF007BFF);
  static const Color _green = Colors.green;

  final List<_OnboardData> _pages = const [
    _OnboardData(
      image: 'assets/loan.jpg',
      title: 'Fast Loan Access',
      description:
          'Apply anytime, anywhere with zero paperwork and quick approvals straight from your phone.',
      icon: Icons.flash_on_rounded,
      accentColor: Color(0xFF007BFF),
    ),
    _OnboardData(
      image: 'assets/pic3.jpg',
      title: 'Magna Credit Limited',
      description:
          'Flexible financing for personal needs, business growth, and emergencies you can trust.',
      icon: Icons.account_balance_rounded,
      accentColor: Colors.green,
    ),
    _OnboardData(
      image: 'assets/pic1.jpg',
      title: 'Achieve Your Goals',
      description:
          'Turn your plans into reality with secure, fast, and reliable financial support.',
      icon: Icons.emoji_events_rounded,
      accentColor: Color(0xFF007BFF),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeAnimation =
        CurvedAnimation(parent: _fadeController, curve: Curves.easeOut);
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    _fadeController.reset();
    _fadeController.forward();
    setState(() => currentPage = index);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [

            // ── Top bar: logo + skip ──
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Mini brand badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 7),
                    decoration: BoxDecoration(
                      color: _blue.withOpacity(0.07),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: _blue.withOpacity(0.18)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: _green,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          "MAGNA CREDIT",
                          style: TextStyle(
                            color: _blue,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Skip button
                  if (currentPage < 2)
                    GestureDetector(
                      onTap: () => _controller.jumpToPage(2),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 7),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "Skip",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                  else
                    const SizedBox(width: 60),
                ],
              ),
            ),

            // ── PageView ──
            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: _onPageChanged,
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return _OnboardPage(
                    data: _pages[index],
                    fadeAnimation: _fadeAnimation,
                  );
                },
              ),
            ),

            // ── Dot indicators ──
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeInOut,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 8,
                    width: currentPage == index ? 28 : 8,
                    decoration: BoxDecoration(
                      color: currentPage == index
                          ? (index == 1 ? _green : _blue)
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),

            // ── Bottom buttons ──
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
              child: currentPage == 2
                  ? GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const HomePage()),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          color: _green,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.green.withOpacity(0.3),
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.rocket_launch_rounded,
                                color: Colors.white, size: 20),
                            SizedBox(width: 10),
                            Text(
                              "Get Started",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: 0.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Step counter
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Text(
                            "${currentPage + 1} / 3",
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        // Next button
                        GestureDetector(
                          onTap: () => _controller.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 13),
                            decoration: BoxDecoration(
                              color: _blue,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: _blue.withOpacity(0.3),
                                  blurRadius: 14,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: const Row(
                              children: [
                                Text(
                                  "Next",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(Icons.arrow_forward_rounded,
                                    color: Colors.white, size: 18),
                              ],
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

// ── Data model ──
class _OnboardData {
  final String image;
  final String title;
  final String description;
  final IconData icon;
  final Color accentColor;

  const _OnboardData({
    required this.image,
    required this.title,
    required this.description,
    required this.icon,
    required this.accentColor,
  });
}

// ── Onboard Page Widget ──
class _OnboardPage extends StatelessWidget {
  final _OnboardData data;
  final Animation<double> fadeAnimation;

  const _OnboardPage({
    required this.data,
    required this.fadeAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // ── Image card with overlay badge ──
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 260,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: data.accentColor.withOpacity(0.18),
                        blurRadius: 24,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    image: DecorationImage(
                      image: AssetImage(data.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Subtle gradient overlay at bottom of image
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.25),
                        ],
                      ),
                    ),
                  ),
                ),

                // Icon badge on bottom-right of image
                Positioned(
                  bottom: -18,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: data.accentColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: data.accentColor.withOpacity(0.35),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(data.icon, color: Colors.white, size: 22),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 42),

            // ── Title ──
            Text(
              data.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: Color(0xFF0D1B2A),
                letterSpacing: 0.3,
              ),
            ),

            const SizedBox(height: 14),

            // ── Description ──
            Text(
              data.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
                height: 1.7,
                letterSpacing: 0.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}