import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'login_screen.dart';
import 'home_screen.dart';
import 'about_screen.dart';
import 'profile_page.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  int _selectedIndex = 0;

  static const Color _blue = Color(0xFF007BFF);
  static const Color _green = Colors.green;

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

  Future<void> _registerUser() async {
    if (!_formKey.currentState!.validate()) return;

    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('❌ Passwords do not match!'),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    final url = Uri.parse('http://127.0.0.1:8000/api/register');

    final body = {
      'name': nameController.text.trim(),
      'email': emailController.text.trim(),
      'phone': phoneController.text.trim(),
      'password': passwordController.text.trim(),
      'password_confirmation': confirmPasswordController.text.trim(),
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Registration successful!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } else {
        final data = jsonDecode(response.body);
        String errorMessage = 'Registration failed!';
        if (data is Map && data.containsKey('errors')) {
          errorMessage = data['errors'].values
              .map((e) => e[0].toString())
              .join('\n');
        } else if (data.containsKey('message')) {
          errorMessage = data['message'];
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ $errorMessage'),
            backgroundColor: Colors.redAccent,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('❌ Network error: $e'),
          backgroundColor: Colors.redAccent,
          duration: const Duration(seconds: 3),
        ),
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
        backgroundColor: _blue,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Create Account",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            letterSpacing: 0.4,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(3),
          child: Container(
            height: 3,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [_blue, _green]),
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [



 const SizedBox(height: 20),
            // ── Blue hero header ──
            Container(
              // width: double.infinity,
              // padding: const EdgeInsets.fromLTRB(24, 24, 24, 30),
              // decoration: const BoxDecoration(
              //   color: Colors.white,
              //   borderRadius: BorderRadius.only(
              //     bottomLeft: Radius.circular(32),
              //     bottomRight: Radius.circular(32),
              //   ),
              // ),
              child: Column(
                children: [
                  // Logo — premium pill badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/magna_logo.jpeg',
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "MAGNA CREDIT",
                              style: TextStyle(
                                color: Color(0xFF007BFF),
                                fontWeight: FontWeight.w800,
                                fontSize: 13,
                                letterSpacing: 1.2,
                              ),
                            ),
                            Text(
                              "LIMITED",
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                                fontSize: 11,
                                letterSpacing: 2,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height:15),
              
                 
                  Text(
                    "Create your account and apply for a loan",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black.withOpacity(0.8),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // ── Form ──
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 28, 22, 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    _FieldLabel(label: "Full Name", isDark: isDark),
                    const SizedBox(height: 6),
                    _buildTextField(
                      nameController,
                      "Enter your full name",
                      icon: Icons.person_rounded,
                      isDark: isDark,
                    ),

                    const SizedBox(height: 18),
                    _FieldLabel(label: "Email Address", isDark: isDark),
                    const SizedBox(height: 6),
                    _buildTextField(
                      emailController,
                      "Enter your email",
                      keyboardType: TextInputType.emailAddress,
                      icon: Icons.email_rounded,
                      isDark: isDark,
                    ),

                    const SizedBox(height: 18),
                    _FieldLabel(label: "Phone Number", isDark: isDark),
                    const SizedBox(height: 6),
                    _buildTextField(
                      phoneController,
                      "Enter phone number",
                      keyboardType: TextInputType.phone,
                      icon: Icons.phone_rounded,
                      isDark: isDark,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Please fill in this field';
                        if (!RegExp(r'^\d{10}$').hasMatch(value)) return 'Phone must be exactly 10 digits';
                        return null;
                      },
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),

                    const SizedBox(height: 18),
                    _FieldLabel(label: "Password", isDark: isDark),
                    const SizedBox(height: 6),
                    _buildPasswordField(
                      controller: passwordController,
                      hintText: "Create a password",
                      obscureText: _obscurePassword,
                      toggleVisibility: () => setState(() => _obscurePassword = !_obscurePassword),
                      isDark: isDark,
                    ),

                    const SizedBox(height: 18),
                    _FieldLabel(label: "Confirm Password", isDark: isDark),
                    const SizedBox(height: 6),
                    _buildPasswordField(
                      controller: confirmPasswordController,
                      hintText: "Repeat your password",
                      obscureText: _obscureConfirmPassword,
                      toggleVisibility: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                      isDark: isDark,
                    ),

                    const SizedBox(height: 32),

                    // ── Register button ──
                    GestureDetector(
                      onTap: _registerUser,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          color: _green,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.green.withOpacity(0.28),
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.how_to_reg_rounded, color: Colors.white, size: 20),
                            SizedBox(width: 10),
                            Text(
                              "Register",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ── Login link ──
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: TextStyle(
                              fontSize: 14,
                              color: isDark ? Colors.white60 : Colors.black54,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginPage()),
                            ),
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 14,
                                color: _blue,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        currentIndex: _selectedIndex,
        selectedItemColor: _blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.info_outline), label: "About"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  // ── Text field ──
  Widget _buildTextField(
    TextEditingController controller,
    String hintText, {
    required bool isDark,
    TextInputType keyboardType = TextInputType.text,
    IconData? icon,
    String? Function(String?)? validator,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      style: TextStyle(
        color: isDark ? Colors.white : Colors.black87,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: _blue, size: 20),
        hintText: hintText,
        hintStyle: TextStyle(
          color: isDark ? Colors.white38 : Colors.black38,
          fontSize: 14,
        ),
        filled: true,
        fillColor: isDark ? Colors.grey[900] : const Color(0xFFF5F8FF),
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? Colors.white12 : const Color(0xFFD0E4FF),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _blue, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
        ),
      ),
      validator: validator ?? (value) => value == null || value.isEmpty ? 'Please fill in this field' : null,
    );
  }

  // ── Password field ──
  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hintText,
    required bool obscureText,
    required VoidCallback toggleVisibility,
    required bool isDark,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(
        color: isDark ? Colors.white : Colors.black87,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock_rounded, color: _blue, size: 20),
        hintText: hintText,
        hintStyle: TextStyle(
          color: isDark ? Colors.white38 : Colors.black38,
          fontSize: 14,
        ),
        filled: true,
        fillColor: isDark ? Colors.grey[900] : const Color(0xFFF5F8FF),
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? Colors.white12 : const Color(0xFFD0E4FF),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _blue, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off_rounded : Icons.visibility_rounded,
            color: Colors.grey,
            size: 20,
          ),
          onPressed: toggleVisibility,
        ),
      ),
      validator: (value) => value == null || value.isEmpty ? 'Please fill in this field' : null,
    );
  }
}

// ── Field label widget ──
class _FieldLabel extends StatelessWidget {
  final String label;
  final bool isDark;

  const _FieldLabel({required this.label, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: isDark ? Colors.white70 : Colors.black87,
        letterSpacing: 0.2,
      ),
    );
  }
}

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'login_screen.dart';
// import 'home_screen.dart';
// import 'about_screen.dart';
// import 'profile_page.dart';

// class RegistrationPage extends StatefulWidget {
//   const RegistrationPage({super.key});

//   @override
//   State<RegistrationPage> createState() => _RegistrationPageState();
// }

// class _RegistrationPageState extends State<RegistrationPage> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPasswordController = TextEditingController();

//   bool _obscurePassword = true;
//   bool _obscureConfirmPassword = true;
//   int _selectedIndex = 0;

//   void _onItemTapped(int index) {
//     setState(() => _selectedIndex = index);

//     switch (index) {
//       case 0:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const HomePage()),
//         );
//         break;
//       case 1:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const AboutPage()),
//         );
//         break;
//       case 2:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const ProfilePage()),
//         );
//         break;
//     }
//   }

//   // ---------------- HTTP POST to Laravel API ----------------
//   Future<void> _registerUser() async {
//     if (!_formKey.currentState!.validate()) return;

//     if (passwordController.text != confirmPasswordController.text) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('❌ Passwords do not match!'),
//           backgroundColor: Colors.redAccent,
//           duration: Duration(seconds: 2),
//         ),
//       );
//       return;
//     }

//     final url = Uri.parse('http://127.0.0.1:8000/api/register'); // your backend URL

//     final body = {
//       'name': nameController.text.trim(),
//       'email': emailController.text.trim(),
//       'phone': phoneController.text.trim(),
//       'password': passwordController.text.trim(),
//       'password_confirmation': confirmPasswordController.text.trim(),
//     };

//     try {
//       final response = await http.post(
//         url,
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//         },
//         body: jsonEncode(body),
//       );

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('✅ Registration successful!'),
//             backgroundColor: Colors.green,
//             duration: Duration(seconds: 2),
//           ),
//         );

//         // Navigate to login page
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const LoginPage()),
//         );
//       } else {
//         // Handle validation errors from Laravel
//         final data = jsonDecode(response.body);
//         String errorMessage = 'Registration failed!';
//         if (data is Map && data.containsKey('errors')) {
//           errorMessage = data['errors'].values
//               .map((e) => e[0].toString())
//               .join('\n');
//         } else if (data.containsKey('message')) {
//           errorMessage = data['message'];
//         }

//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('❌ $errorMessage'),
//             backgroundColor: Colors.redAccent,
//             duration: const Duration(seconds: 3),
//           ),
//         );
//       }
//     } catch (e) {
//       // Network / CORS / other exceptions
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('❌ Network error: $e'),
//           backgroundColor: Colors.redAccent,
//           duration: const Duration(seconds: 3),
//         ),
//       );
//     }
//   }

//   // ---------------- UI Code ----------------
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
//           "Go to Home",
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
//                 Container(
//                   width: 200,
//                   height: 120,
//                   decoration: BoxDecoration(
//                     color: Colors.blue.shade100,
//                     borderRadius: BorderRadius.circular(12),
//                     image: const DecorationImage(
//                       image: AssetImage('assets/magna_logo.jpeg'),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 25),
//                 Text(
//                   "REGISTER",
//                   style: TextStyle(
//                     fontSize: 26,
//                     fontWeight: FontWeight.bold,
//                     color: isDark ? Colors.white : Colors.black87,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   "Create your account and apply for a loan",
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: isDark ? Colors.white70 : Colors.black,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 30),
//                 _buildTextField(nameController, "Enter Name:", icon: Icons.person, isDark: isDark),
//                 const SizedBox(height: 15),
//                 _buildTextField(emailController, "Enter Email:", keyboardType: TextInputType.emailAddress, icon: Icons.email, isDark: isDark),
//                 const SizedBox(height: 15),
//                 _buildTextField(
//                   phoneController,
//                   "Enter Phone:",
//                   keyboardType: TextInputType.phone,
//                   icon: Icons.phone,
//                   isDark: isDark,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) return 'Please fill in this field';
//                     if (!RegExp(r'^\d{10}$').hasMatch(value)) return 'Phone must be exactly 10 digits';
//                     return null;
//                   },
//                   inputFormatters: [FilteringTextInputFormatter.digitsOnly], // <-- prevents letters
//                 ),
//                 const SizedBox(height: 15),
//                 _buildPasswordField(controller: passwordController, hintText: "Enter Password:", obscureText: _obscurePassword, toggleVisibility: () {
//                   setState(() => _obscurePassword = !_obscurePassword);
//                 }, isDark: isDark),
//                 const SizedBox(height: 15),
//                 _buildPasswordField(controller: confirmPasswordController, hintText: "Confirm Password:", obscureText: _obscureConfirmPassword, toggleVisibility: () {
//                   setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);
//                 }, isDark: isDark),
//                 const SizedBox(height: 30),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: _registerUser,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green,
//                       padding: const EdgeInsets.symmetric(vertical: 14),
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                     ),
//                     child: const Text(
//                       "Register",
//                       style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text("Already have an account? ", style: TextStyle(fontSize: 16, color: isDark ? Colors.white70 : Colors.black54)),
//                     GestureDetector(
//                       onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage())),
//                       child: const Text("Login", style: TextStyle(fontSize: 16, color: Color(0xFF007BFF), fontWeight: FontWeight.bold)),
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
//           BottomNavigationBarItem(icon: Icon(Icons.info_outline), label: "About"),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
//         ],
//       ),
//     );
//   }

//   Widget _buildTextField(
//     TextEditingController controller,
//     String hintText, {
//     required bool isDark,
//     TextInputType keyboardType = TextInputType.text,
//     IconData? icon,
//     String? Function(String?)? validator,
//     List<TextInputFormatter>? inputFormatters, // <-- added
//   }) {
//     return TextFormField(
//       controller: controller,
//       keyboardType: keyboardType,
//       inputFormatters: inputFormatters, // <-- applied
//       style: TextStyle(color: isDark ? Colors.white : Colors.black),
//       decoration: InputDecoration(
//         prefixIcon: Icon(icon, color: const Color(0xFF007BFF)),
//         hintText: hintText,
//         filled: true,
//         fillColor: isDark ? Colors.grey[900] : Colors.white,
//         contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(6),
//           borderSide: BorderSide(color: isDark ? Colors.white12 : Colors.black12),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(6),
//           borderSide: const BorderSide(color: Color(0xFF007BFF)),
//         ),
//       ),
//       validator: validator ?? (value) => value == null || value.isEmpty ? 'Please fill in this field' : null,
//     );
//   }

//   Widget _buildPasswordField({
//     required TextEditingController controller,
//     required String hintText,
//     required bool obscureText,
//     required VoidCallback toggleVisibility,
//     required bool isDark,
//   }) {
//     return TextFormField(
//       controller: controller,
//       obscureText: obscureText,
//       decoration: InputDecoration(
//         prefixIcon: const Icon(Icons.lock, color: Color(0xFF007BFF)),
//         hintText: hintText,
//         filled: true,
//         fillColor: isDark ? Colors.grey[900] : Colors.white,
//         contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(6),
//           borderSide: BorderSide(color: isDark ? Colors.white12 : Colors.black12),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(6),
//           borderSide: const BorderSide(color: Color(0xFF007BFF)),
//         ),
//         suffixIcon: IconButton(
//           icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility, color: Colors.grey),
//           onPressed: toggleVisibility,
//         ),
//       ),
//       style: TextStyle(color: isDark ? Colors.white : Colors.black),
//       validator: (value) => value == null || value.isEmpty ? 'Please fill in this field' : null,
//     );
//   }
// }


















// import 'package:flutter/material.dart';
// import 'login_screen.dart';
// import 'home_screen.dart';
// import 'about_screen.dart';
// import 'profile_page.dart';

// class RegistrationPage extends StatefulWidget {
//   const RegistrationPage({super.key});

//   @override
//   State<RegistrationPage> createState() => _RegistrationPageState();
// }

// class _RegistrationPageState extends State<RegistrationPage> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPasswordController = TextEditingController();

//   bool _obscurePassword = true;
//   bool _obscureConfirmPassword = true;
//   int _selectedIndex = 0;

//   void _onItemTapped(int index) {
//     setState(() => _selectedIndex = index);

//     switch (index) {
//       case 0:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const HomePage()),
//         );
//         break;

//       case 1:
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const AboutPage()),
//         );
//         break;

//       case 2:
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
//           "Go to Home",
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
//                   "REGISTER",
//                   style: TextStyle(
//                     fontSize: 26,
//                     fontWeight: FontWeight.bold,
//                     color: isDark ? Colors.white : Colors.black87,
//                   ),
//                 ),

//                 const SizedBox(height: 8),

//                 Text(
//                   "Create your account and apply for a loan",
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: isDark ? Colors.white70 : Colors.black,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),

//                 const SizedBox(height: 30),

//                 _buildTextField(
//                   nameController,
//                   "Enter Name:",
//                   icon: Icons.person,
//                   isDark: isDark,
//                 ),

//                 const SizedBox(height: 15),

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

//                 _buildPasswordField(
//                   controller: passwordController,
//                   hintText: "Enter Password:",
//                   obscureText: _obscurePassword,
//                   toggleVisibility: () {
//                     setState(() {
//                       _obscurePassword = !_obscurePassword;
//                     });
//                   },
//                   isDark: isDark,
//                 ),

//                 const SizedBox(height: 15),

//                 _buildPasswordField(
//                   controller: confirmPasswordController,
//                   hintText: "Confirm Password:",
//                   obscureText: _obscureConfirmPassword,
//                   toggleVisibility: () {
//                     setState(() {
//                       _obscureConfirmPassword = !_obscureConfirmPassword;
//                     });
//                   },
//                   isDark: isDark,
//                 ),

//                 const SizedBox(height: 30),

//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: _registerUser,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green,
//                       padding: const EdgeInsets.symmetric(vertical: 14),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: const Text(
//                       "Register",
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
//                       "Already have an account? ",
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: isDark ? Colors.white70 : Colors.black54,
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => const LoginPage()),
//                         );
//                       },
//                       child: const Text(
//                         "Login",
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
//           BottomNavigationBarItem(icon: Icon(Icons.info_outline), label: "About"),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
//         ],
//       ),
//     );
//   }

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
//         contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(6),
//           borderSide: BorderSide(color: isDark ? Colors.white12 : Colors.black12),
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

//   Widget _buildPasswordField({
//     required TextEditingController controller,
//     required String hintText,
//     required bool obscureText,
//     required VoidCallback toggleVisibility,
//     required bool isDark,
//   }) {
//     return TextFormField(
//       controller: controller,
//       obscureText: obscureText,
//       decoration: InputDecoration(
//         prefixIcon: const Icon(Icons.lock, color: Color(0xFF007BFF)),
//         hintText: hintText,
//         filled: true,
//         fillColor: isDark ? Colors.grey[900] : Colors.white,
//         contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(6),
//           borderSide: BorderSide(color: isDark ? Colors.white12 : Colors.black12),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(6),
//           borderSide: const BorderSide(color: Color(0xFF007BFF)),
//         ),
//         suffixIcon: IconButton(
//           icon: Icon(
//             obscureText ? Icons.visibility_off : Icons.visibility,
//             color: Colors.grey,
//           ),
//           onPressed: toggleVisibility,
//         ),
//       ),
//       style: TextStyle(color: isDark ? Colors.white : Colors.black),
//       validator: (value) =>
//           value == null || value.isEmpty ? 'Please fill in this field' : null,
//     );
//   }

//   void _registerUser() {
//     if (_formKey.currentState!.validate()) {
//       if (passwordController.text != confirmPasswordController.text) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('❌ Passwords do not match!'),
//             backgroundColor: Colors.redAccent,
//             duration: Duration(seconds: 2),
//           ),
//         );
//         return;
//       }

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('✅ Registration successful!'),
//           backgroundColor: Colors.green,
//           duration: Duration(seconds: 2),
//         ),
//       );
//     }
//   }
// }


















// // import 'package:flutter/material.dart';
// // import 'login_screen.dart';
// // import 'home_screen.dart';
// // import 'about_screen.dart';
// // import 'profile_page.dart';

// // class RegistrationPage extends StatefulWidget {
// //   const RegistrationPage({super.key});

// //   @override
// //   State<RegistrationPage> createState() => _RegistrationPageState();
// // }

// // class _RegistrationPageState extends State<RegistrationPage> {
// //   final _formKey = GlobalKey<FormState>();

// //   final TextEditingController nameController = TextEditingController();
// //   final TextEditingController emailController = TextEditingController();
// //   final TextEditingController phoneController = TextEditingController();
// //   final TextEditingController passwordController = TextEditingController();
// //   final TextEditingController confirmPasswordController =
// //       TextEditingController();

// //   bool _obscurePassword = true;
// //   bool _obscureConfirmPassword = true;
// //   int _selectedIndex = 0;

// //   void _onItemTapped(int index) {
// //     setState(() => _selectedIndex = index);

// //     switch (index) {
// //       case 0:
// //         Navigator.pushReplacement(
// //           context,
// //           MaterialPageRoute(builder: (context) => const HomePage()),
// //         );
// //         break;
// //       case 1:
// //         Navigator.pushReplacement(
// //           context,
// //           MaterialPageRoute(builder: (context) => const AboutPage()),
// //         );
// //         break;
// //       case 2:
// //         Navigator.pushReplacement(
// //           context,
// //           MaterialPageRoute(builder: (context) => const ProfilePage()),
// //         );
// //         break;
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final theme = Theme.of(context);
// //     final isDark = theme.brightness == Brightness.dark;

// //     return Scaffold(
// //       backgroundColor: theme.scaffoldBackgroundColor,

// //       appBar: AppBar(
// //         backgroundColor: theme.primaryColor,
// //         elevation: 0,
// //         leading: IconButton(
// //           icon: Icon(Icons.arrow_back, color: theme.appBarTheme.foregroundColor),
// //           onPressed: () => Navigator.pop(context),
// //         ),
// //         title: Text(
// //           "Go to Home",
// //           style: TextStyle(
// //             color: theme.appBarTheme.foregroundColor,
// //             fontSize: 20,
// //             fontWeight: FontWeight.w600,
// //           ),
// //         ),
// //         centerTitle: true,
// //       ),

// //       body: SafeArea(
// //         child: SingleChildScrollView(
// //           padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20)
// //               .copyWith(bottom: 120),
// //           child: Form(
// //             key: _formKey,
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.center,
// //               children: [
// //                 Center(
// //                   child: Container(
// //                     width: 200,
// //                     height: 120,
// //                     decoration: BoxDecoration(
// //                       color: isDark ? Colors.grey[850] : Colors.blue.shade100,
// //                       borderRadius: BorderRadius.circular(12),
// //                       image: const DecorationImage(
// //                         image: AssetImage('assets/magna_logo.jpeg'),
// //                         fit: BoxFit.cover,
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //                 const SizedBox(height: 20),

// //                 Text(
// //                   "Create your account with Magna Credit Limited",
// //                   style: TextStyle(
// //                     fontSize: 18,
// //                     color: isDark ? Colors.white : Colors.black,
// //                   ),
// //                   textAlign: TextAlign.center,
// //                 ),

// //                 const SizedBox(height: 30),

// //                 _buildTextField(
// //                   nameController,
// //                   "Enter Name:",
// //                   icon: Icons.person,
// //                   isDark: isDark,
// //                   theme: theme,
// //                 ),
// //                 const SizedBox(height: 15),

// //                 _buildTextField(
// //                   emailController,
// //                   "Enter Email:",
// //                   keyboardType: TextInputType.emailAddress,
// //                   icon: Icons.email,
// //                   isDark: isDark,
// //                   theme: theme,
// //                 ),
// //                 const SizedBox(height: 15),

// //                 _buildTextField(
// //                   phoneController,
// //                   "Enter Phone:",
// //                   keyboardType: TextInputType.phone,
// //                   icon: Icons.phone,
// //                   isDark: isDark,
// //                   theme: theme,
// //                 ),
// //                 const SizedBox(height: 15),

// //                 _buildPasswordField(
// //                   controller: passwordController,
// //                   hintText: "Enter Password:",
// //                   obscureText: _obscurePassword,
// //                   toggleVisibility: () {
// //                     setState(() => _obscurePassword = !_obscurePassword);
// //                   },
// //                   isDark: isDark,
// //                   theme: theme,
// //                 ),
// //                 const SizedBox(height: 15),

// //                 _buildPasswordField(
// //                   controller: confirmPasswordController,
// //                   hintText: "Confirm Password:",
// //                   obscureText: _obscureConfirmPassword,
// //                   toggleVisibility: () {
// //                     setState(() =>
// //                         _obscureConfirmPassword = !_obscureConfirmPassword);
// //                   },
// //                   isDark: isDark,
// //                   theme: theme,
// //                 ),
// //                 const SizedBox(height: 30),

// //                 SizedBox(
// //                   width: double.infinity,
// //                   child: ElevatedButton(
// //                     onPressed: _registerUser,
// //                     style: ElevatedButton.styleFrom(
// //                       backgroundColor: Colors.green,
// //                       padding: const EdgeInsets.symmetric(vertical: 14),
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(8),
// //                       ),
// //                     ),
// //                     child: const Text(
// //                       "Submit",
// //                       style: TextStyle(fontSize: 16, color: Colors.white),
// //                     ),
// //                   ),
// //                 ),

// //                 const SizedBox(height: 30),

// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   children: [
// //                     Text(
// //                       "Already have an account? ",
// //                       style: TextStyle(
// //                         fontSize: 16,
// //                         color: isDark ? Colors.white70 : Colors.black54,
// //                       ),
// //                     ),
// //                     GestureDetector(
// //                       onTap: () {
// //                         _navigateWithFade(context, const LoginPage());
// //                       },
// //                       child: Text(
// //                         "Login",
// //                         style: TextStyle(
// //                           fontSize: 16,
// //                           color: theme.primaryColor,
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),

// //       bottomNavigationBar: BottomNavigationBar(
// //         backgroundColor: theme.scaffoldBackgroundColor,
// //         currentIndex: _selectedIndex,
// //         selectedItemColor: theme.primaryColor,
// //         unselectedItemColor: isDark ? Colors.white54 : Colors.grey,
// //         onTap: _onItemTapped,
// //         items: const [
// //           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
// //           BottomNavigationBarItem(icon: Icon(Icons.info_outline), label: "About"),
// //           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildTextField(
// //       TextEditingController controller,
// //       String hintText, {
// //         TextInputType keyboardType = TextInputType.text,
// //         IconData? icon,
// //         required bool isDark,
// //         required ThemeData theme,
// //       }) {
// //     return TextFormField(
// //       controller: controller,
// //       keyboardType: keyboardType,
// //       decoration: InputDecoration(
// //         prefixIcon: Icon(icon, color: theme.primaryColor),
// //         hintText: hintText,
// //         filled: true,
// //         fillColor: theme.cardColor,
// //         contentPadding:
// //             const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
// //         enabledBorder: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(6),
// //           borderSide: BorderSide(color: theme.dividerColor),
// //         ),
// //         focusedBorder: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(6),
// //           borderSide: BorderSide(color: theme.primaryColor),
// //         ),
// //       ),
// //       style: TextStyle(color: isDark ? Colors.white : Colors.black),
// //       validator: (value) {
// //         if (value == null || value.isEmpty) {
// //           return 'Please fill in this field';
// //         }
// //         return null;
// //       },
// //     );
// //   }

// //   Widget _buildPasswordField({
// //     required TextEditingController controller,
// //     required String hintText,
// //     required bool obscureText,
// //     required VoidCallback toggleVisibility,
// //     required bool isDark,
// //     required ThemeData theme,
// //   }) {
// //     return TextFormField(
// //       controller: controller,
// //       obscureText: obscureText,
// //       decoration: InputDecoration(
// //         prefixIcon: Icon(Icons.lock, color: theme.primaryColor),
// //         hintText: hintText,
// //         filled: true,
// //         fillColor: theme.cardColor,
// //         contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
// //         enabledBorder: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(6),
// //           borderSide: BorderSide(color: theme.dividerColor),
// //         ),
// //         focusedBorder: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(6),
// //           borderSide: BorderSide(color: theme.primaryColor),
// //         ),
// //         suffixIcon: IconButton(
// //           icon: Icon(
// //             obscureText ? Icons.visibility_off : Icons.visibility,
// //             color: isDark ? Colors.white70 : Colors.grey,
// //           ),
// //           onPressed: toggleVisibility,
// //         ),
// //       ),
// //       style: TextStyle(color: isDark ? Colors.white : Colors.black),
// //       validator: (value) {
// //         if (value == null || value.isEmpty) {
// //           return 'Please fill in this field';
// //         }
// //         return null;
// //       },
// //     );
// //   }

// //   void _registerUser() {
// //     if (_formKey.currentState!.validate()) {
// //       if (passwordController.text != confirmPasswordController.text) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           const SnackBar(
// //             content: Text('❌ Passwords do not match!'),
// //             backgroundColor: Colors.redAccent,
// //             duration: Duration(seconds: 2),
// //           ),
// //         );
// //         return;
// //       }

// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(
// //           content: Text('✅ Registration successful! Redirecting to Login...'),
// //           backgroundColor: Colors.green,
// //           duration: Duration(seconds: 2),
// //         ),
// //       );

// //       Future.delayed(const Duration(seconds: 2), () {
// //         _navigateWithFade(context, const LoginPage());
// //       });
// //     }
// //   }

// //   void _navigateWithFade(BuildContext context, Widget page) {
// //     Navigator.of(context).pushReplacement(PageRouteBuilder(
// //       transitionDuration: const Duration(milliseconds: 600),
// //       pageBuilder: (context, animation, secondaryAnimation) =>
// //           FadeTransition(opacity: animation, child: page),
// //     ));
// //   }
// // }
