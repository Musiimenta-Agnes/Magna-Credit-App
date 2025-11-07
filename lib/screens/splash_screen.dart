import 'dart:async';
import 'package:flutter/material.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Fade-in animation for logo
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward();

    // Move to Onboarding after 3 seconds
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green, // Deep teal green (matches theme)
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ✅ Circular Logo
              Container(
                height: 110,
                width: 110,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  image: const DecorationImage(
                    image: AssetImage('assets/magna_logo.jpeg'), // your logo
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 25),

              // ✅ Tagline Text
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "Fast, simple, and reliable loans\nright at your fingertips",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // ✅ Progress Indicator
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 2.5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}















// import 'dart:async'; 
// import 'package:flutter/material.dart'; 
// import 'onboarding_screen.dart'; 
 
// class SplashScreen extends StatefulWidget { 
//   @override 
//   _SplashScreenState createState() => _SplashScreenState(); 
// } 
 
// class _SplashScreenState extends State<SplashScreen> { 
//   @override 
//   void initState() { 
//   super.initState(); 
 
//     // Move to Onboarding after 3 seconds 
//     Timer(Duration(seconds: 3), () { 
//       Navigator.pushReplacement( 
//         context, 
//         MaterialPageRoute(builder: (context) => OnboardingScreen()), 
//       ); 
//     }); 

   

//   } 
 
//   @override 
//   Widget build(BuildContext context) { 
//     return Scaffold( 
//       backgroundColor: Colors.deepPurple, 
//       body: Center( 
//         child: Column( 
//           mainAxisAlignment: MainAxisAlignment.center, 
//           children: [ 
//             // App logo or icon 
//             Image.asset('assets/logo.png', height: 100), 
//             SizedBox(height: 20), 
//             Text( 
//               "Fast, simple, and reliable loans right at your fingertips", 
//               style: TextStyle( 
//                 color: Colors.white, 
//                 fontSize: 24, 
//                 fontWeight: FontWeight.bold, 
//               ), 
//             ), 
//             SizedBox(height: 40), 
//             CircularProgressIndicator(color: Colors.white), 
//           ], 
//         ), 
//       ), 
//     ); 
//   } 
// } 