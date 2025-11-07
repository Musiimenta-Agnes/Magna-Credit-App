import 'package:flutter/material.dart';
import 'package:magna_credit_app/screens/home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // 🌈 Gradient background for a premium look
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green, Colors.green], // green to aqua
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _controller,
                  onPageChanged: (index) {
                    setState(() => isLastPage = index == 2);
                  },
                  children: [
                    buildPage(
                      image: 'assets/pic2.jpg',
                      title: 'Fast Loan Access',
                      description:
                          'Apply anytime, anywhere — no long queues, no paperwork. Just your phone, your details, and your dreams.',
                    ),
                    buildPage(
                      image: 'assets/pic1.jpg',
                      title: 'Magna Credit Limited',
                      description:
                          'Whether for personal needs, business growth, or emergencies — Magna Credit helps you move forward with ease.',
                    ),
                    buildPage(
                      image: 'assets/pic2.jpg',
                      title: 'Achieve Your Goals',
                      description:
                          'Turn your plans into action effortlessly. Secure, fast, and reliable financing you can trust.',
                    ),
                  ],
                ),
              ),

              // 👇 Smooth Page Indicators
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 8,
                      width: _controller.hasClients &&
                              _controller.page?.round() == index
                          ? 20
                          : 8,
                      decoration: BoxDecoration(
                        color: _controller.hasClients &&
                                _controller.page?.round() == index
                            ? Colors.white
                            : Colors.white54,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),

              // 👇 Bottom navigation (Skip / Next / Get Started)
              Container(
                height: 65,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: isLastPage
                    ? ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const HomePage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
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
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => _controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Next',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPage({
    required String image,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 🖼 Rounded image with shadow
          Container(
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 30),

          // ✨ Title
          Text(
            title,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),

          // 💬 Description
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white70,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
































// import 'package:flutter/material.dart';
// import 'package:magna_credit_app/screens/home_screen.dart'; 
// // import 'home_screen.dart'; 


// class OnboardingScreen extends StatefulWidget { 
// @override 
// _OnboardingScreenState createState() => _OnboardingScreenState(); 
// } 

 
// class _OnboardingScreenState extends State<OnboardingScreen> { 
//   final PageController _controller = PageController(); 
//   bool isLastPage = false; 
 
//   @override 
//   Widget build(BuildContext context) { 
//     return Scaffold( 
//       body: Container( 
//         padding: EdgeInsets.all(20), 
//         child: PageView( 
//           controller: _controller, 
//           onPageChanged: (index) { 
//             setState(() => isLastPage = index == 2); 
//           }, 
//           children: [ 
//             buildPage( 
//               image: 'assets/pic2.jpg', 
//               title: '', 
//               description: 'Apply anytime, anywhere — no long queues, no heavy paperwork. Just your phone, your details, and your dreams.', 
//             ), 
//             buildPage( 
//               image: 'assets/pic1.jpg', 
//               title: 'Magna Credit Limited', 
//               description: 'Whether it’s personal needs, business expansion, or emergency support — Magna Credit is here to help you move forward', 
//             ), 
//             buildPage( 
//               image: 'assets/pic2.jpg', 

 
   
 
//               title: 'Achieve Your Goals', 
//               description: 'Turn your plans into action effortlessly.', 
//             ), 
//           ], 
//         ), 
//       ), 
//       bottomSheet: isLastPage 
//           ? TextButton( 
//               onPressed: () { 
//                 Navigator.pushReplacement( 
//                   context, 
//                   MaterialPageRoute(builder: (_) => HomePage()), 
//                 ); 
//               }, 
//               child: Container( 
//                 width: double.infinity, 
//                 height: 60, 
//                 color: Colors.deepPurple, 
//                 alignment: Alignment.center, 
//                 child: Text( 
//                   'Get Started', 
//                   style: TextStyle(color: Colors.white, fontSize: 20), 
//                 ), 
//               ), 
//             ) 
//           : Container( 
//               height: 60, 
//               child: Row( 
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween, 
//                 children: [ 

 
   
 
//                   TextButton( 
//                     child: Text('Skip'), 
//                     onPressed: () => _controller.jumpToPage(2), 
//                   ), 
//                   Row( 
//                     children: [ 
//                       TextButton( 
//                         child: Text('Next'), 
//                         onPressed: () => _controller.nextPage( 
//                           duration: Duration(milliseconds: 500), 
//                           curve: Curves.easeInOut, 
//                         ), 
//                       ), 
//                     ], 
//                   ), 
//                 ], 
//               ), 
//             ), 
//     ); 
//   } 
 
//   Widget buildPage({ 
//     required String image, 
//     required String title, 
//     required String description, 
//   }) { 
//     return Column( 
//       mainAxisAlignment: MainAxisAlignment.center, 
//       children: [ 
//         Image.asset(image, height: 300), 
//         SizedBox(height: 30), 

 
   
 
//         Text( 
//           title, 
//           style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold), 
//         ), 
//         SizedBox(height: 15), 
//         Text( 
//           description, 
//           textAlign: TextAlign.center, 
//           style: TextStyle(fontSize: 18, color: Colors.grey[700]), 
//         ), 
//       ], 
//     ); 
//   } 
// }