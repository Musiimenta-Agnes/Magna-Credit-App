import 'package:flutter/material.dart';

class ApplicationSuccessPage extends StatelessWidget {
  const ApplicationSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: const Color(0xFF007BFF), // same blue
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          "Application Complete",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // Success Icon
              Container(
                padding: const EdgeInsets.all(18),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF007BFF),
                ),
                child: const Icon(
                  Icons.check,
                  size: 40,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Application Complete",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 25),

              // Green Info Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      "Thank you for applying for a loan with Magna Credit Limited!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(height: 15),

                    Text(
                      "We’ve received your application and it’s now under review by our credit team.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),

                    SizedBox(height: 15),

                    Text(
                      "You’ll receive a notification via email once a decision has been made.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),

                    SizedBox(height: 10),

                    Text(
                      "If additional information is needed, one of our officers will reach out to you.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Home Button
              SizedBox(
                width: 150,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.green),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    "Home",
                    style: TextStyle(
                      color: Colors.green,
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
