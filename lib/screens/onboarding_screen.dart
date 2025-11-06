import 'package:flutter/material.dart'; 
import 'home_screen.dart'; 
class OnboardingScreen extends StatefulWidget { 
@override 
_OnboardingScreenState createState() => _OnboardingScreenState(); 
} 

 
   
 
 
class _OnboardingScreenState extends State<OnboardingScreen> { 
  final PageController _controller = PageController(); 
  bool isLastPage = false; 
 
  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      body: Container( 
        padding: EdgeInsets.all(20), 
        child: PageView( 
          controller: _controller, 
          onPageChanged: (index) { 
            setState(() => isLastPage = index == 2); 
          }, 
          children: [ 
            buildPage( 
              image: 'assets/magna_logo.jpeg', 
              title: '', 
              description: 'Apply anytime, anywhere — no long queues, no heavy paperwork. Just your phone, your details, and your dreams.', 
            ), 
            buildPage( 
              image: 'assets/pic1.jpg', 
              title: 'Magna Credit Limited', 
              description: 'Whether it’s personal needs, business expansion, or emergency support — Magna Credit is here to help you move forward', 
            ), 
            buildPage( 
              image: 'assets/pic2.jpg', 

 
   
 
              title: 'Achieve Your Goals', 
              description: 'Turn your plans into action effortlessly.', 
            ), 
          ], 
        ), 
      ), 
      bottomSheet: isLastPage 
          ? TextButton( 
              onPressed: () { 
                Navigator.pushReplacement( 
                  context, 
                  MaterialPageRoute(builder: (_) => HomeScreen()), 
                ); 
              }, 
              child: Container( 
                width: double.infinity, 
                height: 60, 
                color: Colors.deepPurple, 
                alignment: Alignment.center, 
                child: Text( 
                  'Get Started', 
                  style: TextStyle(color: Colors.white, fontSize: 20), 
                ), 
              ), 
            ) 
          : Container( 
              height: 60, 
              child: Row( 
                mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                children: [ 

 
   
 
                  TextButton( 
                    child: Text('Skip'), 
                    onPressed: () => _controller.jumpToPage(2), 
                  ), 
                  Row( 
                    children: [ 
                      TextButton( 
                        child: Text('Next'), 
                        onPressed: () => _controller.nextPage( 
                          duration: Duration(milliseconds: 500), 
                          curve: Curves.easeInOut, 
                        ), 
                      ), 
                    ], 
                  ), 
                ], 
              ), 
            ), 
    ); 
  } 
 
  Widget buildPage({ 
    required String image, 
    required String title, 
    required String description, 
  }) { 
    return Column( 
      mainAxisAlignment: MainAxisAlignment.center, 
      children: [ 
        Image.asset(image, height: 300), 
        SizedBox(height: 30), 

 
   
 
        Text( 
          title, 
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold), 
        ), 
        SizedBox(height: 15), 
        Text( 
          description, 
          textAlign: TextAlign.center, 
          style: TextStyle(fontSize: 18, color: Colors.grey[700]), 
        ), 
      ], 
    ); 
  } 
}