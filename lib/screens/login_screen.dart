// import 'package:flutter/material.dart';
// import 'forgot_password_page.dart';
// import 'home_screen.dart';
// import 'signup_screen.dart';
// import 'first_loan_application.dart';
// import 'profile_page.dart';
// import 'about_screen.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   bool _obscurePassword = true;
//   int _selectedIndex = 0;

//   // Bottom Navigation
//   void _onItemTapped(int index) {
//     setState(() => _selectedIndex = index);

//     switch (index) {
//       case 0: // Home
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const HomePage()),
//         );
//         break;

//       case 1: // About
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const AboutPage()),
//         );
//         break;

//       case 2: // Profile
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const ProfilePage()),
//         );
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;

//     return Scaffold(
//       backgroundColor: theme.scaffoldBackgroundColor,

//       appBar: AppBar(
//         backgroundColor: const Color(0xFF007BFF),
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: theme.appBarTheme.foregroundColor),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           "Login",
//           style: TextStyle(
//             color: theme.appBarTheme.foregroundColor,
//             fontSize: 20,
//           ),
//         ),
//         centerTitle: true,
//       ),

//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 // App Logo
//                 Center(
//                   child: Container(
//                     width: 200,
//                     height: 120,
//                     decoration: BoxDecoration(
//                       color: Colors.blue.shade100,
//                       borderRadius: BorderRadius.circular(12),
//                       image: const DecorationImage(
//                         image: AssetImage('assets/magna_logo.jpeg'),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 25),

//                 Text(
//                   "",
//                   style: TextStyle(
//                     fontSize: 26,
//                     fontWeight: FontWeight.bold,
//                     color: isDark ? Colors.white : Colors.black87,
//                   ),
//                 ),

//                 const SizedBox(height: 8),

//                 Text(
//                   "Login to your account and apply for a loan",
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: isDark ? Colors.white70 : Colors.black,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),

//                 const SizedBox(height: 30),

//                 _buildTextField(
//                   emailController,
//                   "Enter Email:",
//                   icon: Icons.email,
//                   keyboardType: TextInputType.emailAddress,
//                   isDark: isDark,
//                 ),
//                 const SizedBox(height: 15),

//                 _buildTextField(
//                   phoneController,
//                   "Enter Phone:",
//                   icon: Icons.phone,
//                   keyboardType: TextInputType.phone,
//                   isDark: isDark,
//                 ),
//                 const SizedBox(height: 15),

//                 // Password Field
//                 TextFormField(
//                   controller: passwordController,
//                   obscureText: _obscurePassword,
//                   decoration: InputDecoration(
//                     prefixIcon:
//                         const Icon(Icons.lock, color: Color(0xFF007BFF)),
//                     hintText: "Enter Password:",
//                     filled: true,
//                     fillColor: isDark ? Colors.grey[900] : Colors.white,
//                     contentPadding: const EdgeInsets.symmetric(
//                         vertical: 14, horizontal: 15),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(6),
//                       borderSide: BorderSide(
//                           color: isDark ? Colors.white12 : Colors.black12),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(6),
//                       borderSide: const BorderSide(color: Color(0xFF007BFF)),
//                     ),
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _obscurePassword
//                             ? Icons.visibility_off
//                             : Icons.visibility,
//                         color: Colors.grey,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _obscurePassword = !_obscurePassword;
//                         });
//                       },
//                     ),
//                   ),
//                   validator: (value) =>
//                       value == null || value.isEmpty
//                           ? 'Please enter your password'
//                           : null,
//                   style: TextStyle(
//                     color: isDark ? Colors.white : Colors.black,
//                   ),
//                 ),

//                 const SizedBox(height: 15),

//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const ForgotPasswordPage(),
//                         ),
//                       );
//                     },
//                     child: Text(
//                       "Forgot Password?",
//                       style: TextStyle(
//                         color: const Color(0xFF007BFF),
//                         fontWeight: FontWeight.bold,
//                         fontSize: 15,
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 30),

//                 // LOGIN BUTTON → Goes to Loan Application Page
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: _loginUser,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green,
//                       padding: const EdgeInsets.symmetric(vertical: 14),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: const Text(
//                       "Login",
//                       style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 30),

//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Don’t have an account? ",
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: isDark ? Colors.white70 : Colors.black54,
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const RegistrationPage()),
//                         );
//                       },
//                       child: const Text(
//                         "Register",
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Color(0xFF007BFF),
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),

//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: theme.scaffoldBackgroundColor,
//         currentIndex: _selectedIndex,
//         selectedItemColor: const Color(0xFF007BFF),
//         unselectedItemColor: isDark ? Colors.white54 : Colors.grey,
//         onTap: _onItemTapped,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.info_outline), label: "About"),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
//         ],
//       ),
//     );
//   }

//   // Textfield component
//   Widget _buildTextField(
//     TextEditingController controller,
//     String hintText, {
//     required bool isDark,
//     TextInputType keyboardType = TextInputType.text,
//     IconData? icon,
//   }) {
//     return TextFormField(
//       controller: controller,
//       keyboardType: keyboardType,
//       style: TextStyle(color: isDark ? Colors.white : Colors.black),
//       decoration: InputDecoration(
//         prefixIcon: Icon(icon, color: const Color(0xFF007BFF)),
//         hintText: hintText,
//         filled: true,
//         fillColor: isDark ? Colors.grey[900] : Colors.white,
//         contentPadding:
//             const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(6),
//           borderSide: BorderSide(
//               color: isDark ? Colors.white12 : Colors.black12),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(6),
//           borderSide: const BorderSide(color: Color(0xFF007BFF)),
//         ),
//       ),
//       validator: (value) =>
//           value == null || value.isEmpty ? 'Please fill in this field' : null,
//     );
//   }

//   // UPDATED LOGIN → Connects to backend and handles success/failure
//   void _loginUser() async {
//     if (_formKey.currentState!.validate()) {
//       final email = emailController.text.trim();
//       final password = passwordController.text.trim();

//       final url = Uri.parse('http://127.0.0.1:8000/api/login'); 

//       try {
//         final response = await http.post(
//           url,
//           headers: {'Accept': 'application/json'},
//           body: {
//             'email': email,
//             'password': password,
//           },
//         );

//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);

//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(
//                 '✅ ${data['message']}',
//                 style: TextStyle(
//                     color: Theme.of(context).brightness == Brightness.dark
//                         ? Colors.white
//                         : Colors.white),
//               ),
//               backgroundColor: Colors.green,
//               duration: const Duration(seconds: 2),
//             ),
//           );

//           // Navigate to LoanApplicationPage after short delay
//           Future.delayed(const Duration(seconds: 2), () {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => const LoanApplicationPage()),
//             );
//           });
//         } else {
//           final data = jsonDecode(response.body);
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(
//                 '❌ ${data['message']}',
//                 style: TextStyle(
//                     color: Theme.of(context).brightness == Brightness.dark
//                         ? Colors.white
//                         : Colors.white),
//               ),
//               backgroundColor: Colors.red,
//               duration: const Duration(seconds: 2),
//             ),
//           );
//         }
//       } catch (e) {
//         // Connection or parsing error
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               '❌ Something went wrong. Please try again.',
//               style: TextStyle(
//                   color: Theme.of(context).brightness == Brightness.dark
//                       ? Colors.white
//                       : Colors.white),
//             ),
//             backgroundColor: Colors.red,
//             duration: const Duration(seconds: 2),
//           ),
//         );
//       }
//     }
//   }
// }




















// import 'package:flutter/material.dart';
// import 'forgot_password_page.dart';
// import 'home_screen.dart';
// import 'signup_screen.dart';
// import 'first_loan_application.dart';
// import 'profile_page.dart';
// import 'about_screen.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   bool _obscurePassword = true;
//   int _selectedIndex = 0;

//   // Bottom Navigation
//   void _onItemTapped(int index) {
//     setState(() => _selectedIndex = index);

//     switch (index) {
//       case 0: // Home
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const HomePage()),
//         );
//         break;

//       case 1: // About
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const AboutPage()),
//         );
//         break;

//       case 2: // Profile
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const ProfilePage()),
//         );
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;

//     return Scaffold(
//       backgroundColor: theme.scaffoldBackgroundColor,

//       appBar: AppBar(
//         backgroundColor: const Color(0xFF007BFF),
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: theme.appBarTheme.foregroundColor),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           "Login",
//           style: TextStyle(
//             color: theme.appBarTheme.foregroundColor,
//             fontSize: 20,
//           ),
//         ),
//         centerTitle: true,
//       ),

//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 // App Logo
//                 Center(
//                   child: Container(
//                     width: 200,
//                     height: 120,
//                     decoration: BoxDecoration(
//                       color: Colors.blue.shade100,
//                       borderRadius: BorderRadius.circular(12),
//                       image: const DecorationImage(
//                         image: AssetImage('assets/magna_logo.jpeg'),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 25),

//                 Text(
//                   "",
//                   style: TextStyle(
//                     fontSize: 26,
//                     fontWeight: FontWeight.bold,
//                     color: isDark ? Colors.white : Colors.black87,
//                   ),
//                 ),

//                 const SizedBox(height: 8),

//                 Text(
//                   "Login to your account and apply for a loan",
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: isDark ? Colors.white70 : Colors.black,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),

//                 const SizedBox(height: 30),

//                 _buildTextField(
//                   emailController,
//                   "Enter Email:",
//                   icon: Icons.email,
//                   keyboardType: TextInputType.emailAddress,
//                   isDark: isDark,
//                 ),
//                 const SizedBox(height: 15),

//                 _buildTextField(
//                   phoneController,
//                   "Enter Phone:",
//                   icon: Icons.phone,
//                   keyboardType: TextInputType.phone,
//                   isDark: isDark,
//                 ),
//                 const SizedBox(height: 15),

//                 // Password Field
//                 TextFormField(
//                   controller: passwordController,
//                   obscureText: _obscurePassword,
//                   decoration: InputDecoration(
//                     prefixIcon:
//                         const Icon(Icons.lock, color: Color(0xFF007BFF)),
//                     hintText: "Enter Password:",
//                     filled: true,
//                     fillColor: isDark ? Colors.grey[900] : Colors.white,
//                     contentPadding: const EdgeInsets.symmetric(
//                         vertical: 14, horizontal: 15),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(6),
//                       borderSide: BorderSide(
//                           color: isDark ? Colors.white12 : Colors.black12),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(6),
//                       borderSide: const BorderSide(color: Color(0xFF007BFF)),
//                     ),
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _obscurePassword
//                             ? Icons.visibility_off
//                             : Icons.visibility,
//                         color: Colors.grey,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _obscurePassword = !_obscurePassword;
//                         });
//                       },
//                     ),
//                   ),
//                   validator: (value) =>
//                       value == null || value.isEmpty
//                           ? 'Please enter your password'
//                           : null,
//                   style: TextStyle(
//                     color: isDark ? Colors.white : Colors.black,
//                   ),
//                 ),

//                 const SizedBox(height: 15),

//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const ForgotPasswordPage(),
//                         ),
//                       );
//                     },
//                     child: Text(
//                       "Forgot Password?",
//                       style: TextStyle(
//                         color: const Color(0xFF007BFF),
//                         fontWeight: FontWeight.bold,
//                         fontSize: 15,
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 30),

//                 // LOGIN BUTTON → Goes to Loan Application Page
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: _loginUser,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green,
//                       padding: const EdgeInsets.symmetric(vertical: 14),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: const Text(
//                       "Login",
//                       style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 30),

//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Don’t have an account? ",
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: isDark ? Colors.white70 : Colors.black54,
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const RegistrationPage()),
//                         );
//                       },
//                       child: const Text(
//                         "Register",
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Color(0xFF007BFF),
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),

//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: theme.scaffoldBackgroundColor,
//         currentIndex: _selectedIndex,
//         selectedItemColor: const Color(0xFF007BFF),
//         unselectedItemColor: isDark ? Colors.white54 : Colors.grey,
//         onTap: _onItemTapped,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.info_outline), label: "About"),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
//         ],
//       ),
//     );
//   }

//   // Textfield component
//   Widget _buildTextField(
//     TextEditingController controller,
//     String hintText, {
//     required bool isDark,
//     TextInputType keyboardType = TextInputType.text,
//     IconData? icon,
//   }) {
//     return TextFormField(
//       controller: controller,
//       keyboardType: keyboardType,
//       style: TextStyle(color: isDark ? Colors.white : Colors.black),
//       decoration: InputDecoration(
//         prefixIcon: Icon(icon, color: const Color(0xFF007BFF)),
//         hintText: hintText,
//         filled: true,
//         fillColor: isDark ? Colors.grey[900] : Colors.white,
//         contentPadding:
//             const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(6),
//           borderSide: BorderSide(
//               color: isDark ? Colors.white12 : Colors.black12),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(6),
//           borderSide: const BorderSide(color: Color(0xFF007BFF)),
//         ),
//       ),
//       validator: (value) =>
//           value == null || value.isEmpty ? 'Please fill in this field' : null,
//     );
//   }

//   // LOGIN → Redirect to LoanApplicationPage
//   void _loginUser() {
//     if (_formKey.currentState!.validate()) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             '✅ Welcome back!',
//             style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.white),
//           ),
//           backgroundColor: Colors.green,
//           duration: const Duration(seconds: 2),
//         ),
//       );

//       Future.delayed(const Duration(seconds: 2), () {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const LoanApplicationPage()),
//         );
//       });
//     }
//   }
// }


import 'package:flutter/material.dart';
import 'forgot_password_page.dart';
import 'home_screen.dart';
import 'signup_screen.dart';
import 'first_loan_application.dart';
import 'profile_page.dart';
import 'about_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _obscurePassword = true;
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        break;

      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AboutPage()),
        );
        break;

      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProfilePage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: const Color(0xFF007BFF),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.appBarTheme.foregroundColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Login",
          style: TextStyle(
            color: theme.appBarTheme.foregroundColor,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Center(
                  child: Container(
                    width: 200,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(12),
                      image: const DecorationImage(
                        image: AssetImage('assets/magna_logo.jpeg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Text(
                  "",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Login to your account and apply for a loan",
                  style: TextStyle(
                    fontSize: 16,
                    color: isDark ? Colors.white70 : Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),

                _buildTextField(
                  emailController,
                  "Enter Email:",
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  isDark: isDark,
                ),
                const SizedBox(height: 15),

                _buildTextField(
                  phoneController,
                  "Enter Phone:",
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  isDark: isDark,
                ),
                const SizedBox(height: 15),

                TextFormField(
                  controller: passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    prefixIcon:
                        const Icon(Icons.lock, color: Color(0xFF007BFF)),
                    hintText: "Enter Password:",
                    filled: true,
                    fillColor: isDark ? Colors.grey[900] : Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 15),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(
                          color: isDark ? Colors.white12 : Colors.black12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(color: Color(0xFF007BFF)),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty
                          ? 'Please enter your password'
                          : null,
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),

                const SizedBox(height: 15),

                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPasswordPage(),
                        ),
                      );
                    },
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Color(0xFF007BFF),
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _loginUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don’t have an account? ",
                      style: TextStyle(
                        fontSize: 16,
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegistrationPage()),
                        );
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF007BFF),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF007BFF),
        unselectedItemColor: isDark ? Colors.white54 : Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.info_outline), label: "About"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hintText, {
    required bool isDark,
    TextInputType keyboardType = TextInputType.text,
    IconData? icon,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(color: isDark ? Colors.white : Colors.black),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: const Color(0xFF007BFF)),
        hintText: hintText,
        filled: true,
        fillColor: isDark ? Colors.grey[900] : Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
              color: isDark ? Colors.white12 : Colors.black12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Color(0xFF007BFF)),
        ),
      ),
      validator: (value) =>
          value == null || value.isEmpty ? 'Please fill in this field' : null,
    );
  }

  void _loginUser() async {
    if (_formKey.currentState!.validate()) {
      final email = emailController.text.trim();
      final phone = phoneController.text.trim(); // ✅ ADDED
      final password = passwordController.text.trim();

      final url = Uri.parse('http://127.0.0.1:8000/api/login');

      try {
        final response = await http.post(
          url,
          headers: {'Accept': 'application/json'},
          body: {
            'email': email,
            'phone': phone, // ✅ ADDED
            'password': password,
          },
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('✅ ${data['message']}'),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
            ),
          );

          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const LoanApplicationPage()),
            );
          });
        } else {
          final data = jsonDecode(response.body);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('❌ ${data['message']}'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('❌ Something went wrong. Please try again.'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }
}

















// import 'package:flutter/material.dart';
// import 'forgot_password_page.dart';
// import 'home_screen.dart';
// import 'signup_screen.dart';
// import 'first_loan_application.dart';
// import 'profile_page.dart';
// import 'about_screen.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   bool _obscurePassword = true;
//   int _selectedIndex = 0;

//   // Bottom Navigation
//   void _onItemTapped(int index) {
//     setState(() => _selectedIndex = index);

//     switch (index) {
//       case 0: // Home
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const HomePage()),
//         );
//         break;

//       case 1: // About
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const AboutPage()),
//         );
//         break;

//       case 2: // Profile
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const ProfilePage()),
//         );
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,

//       appBar: AppBar(
//         backgroundColor: Colors.blueAccent,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           "Go Back",
//           style: TextStyle(color: Colors.white, fontSize: 20),
//         ),
//         centerTitle: true,
//       ),

//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 // App Logo
//                 Center(
//                   child: Container(
//                     width: 200,
//                     height: 120,
//                     decoration: BoxDecoration(
//                       color: Colors.blue.shade100,
//                       borderRadius: BorderRadius.circular(12),
//                       image: const DecorationImage(
//                         image: AssetImage('assets/magna_logo.jpeg'),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 25),

//                 const Text(
//                   "LOGIN",
//                   style: TextStyle(
//                     fontSize: 26,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black87,
//                   ),
//                 ),

//                 const SizedBox(height: 8),

//                 const Text(
//                   "Login to your account and apply for a loan",
//                   style: TextStyle(fontSize: 16, color: Colors.black),
//                   textAlign: TextAlign.center,
//                 ),

//                 const SizedBox(height: 30),

//                 _buildTextField(
//                   emailController,
//                   "Enter Email:",
//                   icon: Icons.email,
//                   keyboardType: TextInputType.emailAddress,
//                 ),
//                 const SizedBox(height: 15),

//                 _buildTextField(
//                   phoneController,
//                   "Enter Phone:",
//                   icon: Icons.phone,
//                   keyboardType: TextInputType.phone,
//                 ),
//                 const SizedBox(height: 15),

//                 // Password Field
//                 TextFormField(
//                   controller: passwordController,
//                   obscureText: _obscurePassword,
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(Icons.lock, color: Colors.blueAccent),
//                     hintText: "Enter Password:",
//                     filled: true,
//                     fillColor: Colors.white,
//                     contentPadding: const EdgeInsets.symmetric(
//                         vertical: 14, horizontal: 15),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(6),
//                       borderSide: const BorderSide(color: Colors.black12),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(6),
//                       borderSide: const BorderSide(color: Colors.blueAccent),
//                     ),
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _obscurePassword
//                             ? Icons.visibility_off
//                             : Icons.visibility,
//                         color: Colors.grey,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _obscurePassword = !_obscurePassword;
//                         });
//                       },
//                     ),
//                   ),
//                   validator: (value) =>
//                       value == null || value.isEmpty ? 'Please enter your password' : null,
//                 ),

//                 const SizedBox(height: 15),

//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const ForgotPasswordPage(),
//                         ),
//                       );
//                     },
//                     child: const Text(
//                       "Forgot Password?",
//                       style: TextStyle(
//                         color: Colors.blueAccent,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 15,
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 30),

//                 // LOGIN BUTTON → Goes to Loan Application Page
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: _loginUser,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green,
//                       padding: const EdgeInsets.symmetric(vertical: 14),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: const Text(
//                       "Login",
//                       style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 30),

//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text(
//                       "Don’t have an account? ",
//                       style: TextStyle(fontSize: 16, color: Colors.black54),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const RegistrationPage()),
//                         );
//                       },
//                       child: const Text(
//                         "Register",
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.blueAccent,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),

//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: Colors.white,
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.blueAccent,
//         unselectedItemColor: Colors.grey,
//         onTap: _onItemTapped,
//         items: const [
//           BottomNavigationBarItem(
//               icon: Icon(Icons.home), label: "Home"),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.info_outline), label: "About"),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.person), label: "Profile"),
//         ],
//       ),
//     );
//   }

//   // Textfield component
//   Widget _buildTextField(
//     TextEditingController controller,
//     String hintText, {
//     TextInputType keyboardType = TextInputType.text,
//     IconData? icon,
//   }) {
//     return TextFormField(
//       controller: controller,
//       keyboardType: keyboardType,
//       decoration: InputDecoration(
//         prefixIcon: Icon(icon, color: Color(0xFF007BFF)),
//         hintText: hintText,
//         filled: true,
//         fillColor: Colors.white,
//         contentPadding:
//             const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(6),
//           borderSide: const BorderSide(color: Colors.black12),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(6),
//           borderSide: const BorderSide(color: Color(0xFF007BFF)),
//         ),
//       ),
//       validator: (value) =>
//           value == null || value.isEmpty ? 'Please fill in this field' : null,
//     );
//   }

//   // LOGIN → Redirect to LoanApplicationPage
//   void _loginUser() {
//     if (_formKey.currentState!.validate()) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('✅ Welcome back!'),
//           backgroundColor: Colors.green,
//           duration: Duration(seconds: 2),
//         ),
//       );

//       Future.delayed(const Duration(seconds: 2), () {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const LoanApplicationPage()),
//         );
//       });
//     }
//   }
// }

