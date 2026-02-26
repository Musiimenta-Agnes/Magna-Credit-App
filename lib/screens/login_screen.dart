

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

//   static const Color _blue = Color(0xFF007BFF);
//   static const Color _green = Colors.green;

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
//       backgroundColor: isDark ? Colors.black : Colors.white,

//       appBar: AppBar(
//         backgroundColor: _blue,
//         elevation: 0,
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           "Login",
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 18,
//             letterSpacing: 0.4,
//           ),
//         ),
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(3),
//           child: Container(
//             height: 3,
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(colors: [_blue, _green]),
//             ),
//           ),
//         ),
//       ),

//       body: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         padding: const EdgeInsets.fromLTRB(22, 36, 22, 20),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [

//               // ── Logo pill badge (same as registration) ──
//               Center(
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                   decoration: BoxDecoration(
//                     color: isDark ? Colors.grey[900] : Colors.white,
//                     borderRadius: BorderRadius.circular(16),
//                     border: Border.all(color: _blue.withOpacity(0.15)),
//                     boxShadow: [
//                       BoxShadow(
//                         color: _blue.withOpacity(0.12),
//                         blurRadius: 16,
//                         offset: const Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(8),
//                         child: Image.asset(
//                           'assets/magna_logo.jpeg',
//                           width: 40,
//                           height: 40,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       const SizedBox(width: 10),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: const [
//                           Text(
//                             "MAGNA CREDIT",
//                             style: TextStyle(
//                               color: _blue,
//                               fontWeight: FontWeight.w800,
//                               fontSize: 13,
//                               letterSpacing: 1.2,
//                             ),
//                           ),
//                           Text(
//                             "LIMITED",
//                             style: TextStyle(
//                               color: _green,
//                               fontWeight: FontWeight.w600,
//                               fontSize: 11,
//                               letterSpacing: 2,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 28),

//               // ── Welcome text ──
//               Center(
//                 child: Column(
//                   children: [
//                     Text(
//                       "Welcome Back",
//                       style: TextStyle(
//                         fontSize: 22,
//                         fontWeight: FontWeight.w800,
//                         color: isDark ? Colors.white : Colors.black87,
//                         letterSpacing: 0.3,
//                       ),
//                     ),
//                     const SizedBox(height: 6),
//                     Text(
//                       "Login to your account and apply for a loan",
//                       style: TextStyle(
//                         fontSize: 13,
//                         color: isDark ? Colors.white54 : Colors.black45,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 32),

//               // ── Email ──
//               _FieldLabel(label: "Email Address", isDark: isDark),
//               const SizedBox(height: 6),
//               _buildTextField(
//                 emailController,
//                 "Enter your email",
//                 icon: Icons.email_rounded,
//                 keyboardType: TextInputType.emailAddress,
//                 isDark: isDark,
//               ),

//               const SizedBox(height: 18),

//               // ── Phone ──
//               _FieldLabel(label: "Phone Number", isDark: isDark),
//               const SizedBox(height: 6),
//               _buildTextField(
//                 phoneController,
//                 "Enter your phone number",
//                 icon: Icons.phone_rounded,
//                 keyboardType: TextInputType.phone,
//                 isDark: isDark,
//               ),

//               const SizedBox(height: 18),

//               // ── Password ──
//               _FieldLabel(label: "Password", isDark: isDark),
//               const SizedBox(height: 6),
//               TextFormField(
//                 controller: passwordController,
//                 obscureText: _obscurePassword,
//                 style: TextStyle(
//                   color: isDark ? Colors.white : Colors.black87,
//                   fontSize: 14,
//                 ),
//                 decoration: InputDecoration(
//                   prefixIcon: const Icon(Icons.lock_rounded, color: _blue, size: 20),
//                   hintText: "Enter your password",
//                   hintStyle: TextStyle(
//                     color: isDark ? Colors.white38 : Colors.black38,
//                     fontSize: 14,
//                   ),
//                   filled: true,
//                   fillColor: isDark ? Colors.grey[900] : const Color(0xFFF5F8FF),
//                   contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide(
//                       color: isDark ? Colors.white12 : const Color(0xFFD0E4FF),
//                     ),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: const BorderSide(color: _blue, width: 1.5),
//                   ),
//                   errorBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: const BorderSide(color: Colors.redAccent),
//                   ),
//                   focusedErrorBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
//                   ),
//                   suffixIcon: IconButton(
//                     icon: Icon(
//                       _obscurePassword ? Icons.visibility_off_rounded : Icons.visibility_rounded,
//                       color: Colors.grey,
//                       size: 20,
//                     ),
//                     onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
//                   ),
//                 ),
//                 validator: (value) =>
//                     value == null || value.isEmpty ? 'Please enter your password' : null,
//               ),

//               const SizedBox(height: 12),

//               // ── Forgot password ──
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => const ForgotPasswordPage()),
//                     );
//                   },
//                   child: const Text(
//                     "Forgot Password?",
//                     style: TextStyle(
//                       color: _blue,
//                       fontWeight: FontWeight.w600,
//                       fontSize: 13,
//                     ),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 32),

//               // ── Login button ──
//               GestureDetector(
//                 onTap: _loginUser,
//                 child: Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.symmetric(vertical: 15),
//                   decoration: BoxDecoration(
//                     color: _green,
//                     borderRadius: BorderRadius.circular(14),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.green.withOpacity(0.28),
//                         blurRadius: 16,
//                         offset: const Offset(0, 6),
//                       ),
//                     ],
//                   ),
//                   child: const Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.login_rounded, color: Colors.white, size: 20),
//                       SizedBox(width: 10),
//                       Text(
//                         "Login",
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.white,
//                           fontWeight: FontWeight.w700,
//                           letterSpacing: 0.5,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 24),

//               // ── Register link ──
//               Center(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Don't have an account? ",
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: isDark ? Colors.white60 : Colors.black54,
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => const RegistrationPage()),
//                         );
//                       },
//                       child: const Text(
//                         "Register",
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: _blue,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 10),
//             ],
//           ),
//         ),
//       ),

//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: isDark ? Colors.black : Colors.white,
//         currentIndex: _selectedIndex,
//         selectedItemColor: _blue,
//         unselectedItemColor: Colors.grey,
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
//       style: TextStyle(
//         color: isDark ? Colors.white : Colors.black87,
//         fontSize: 14,
//       ),
//       decoration: InputDecoration(
//         prefixIcon: Icon(icon, color: _blue, size: 20),
//         hintText: hintText,
//         hintStyle: TextStyle(
//           color: isDark ? Colors.white38 : Colors.black38,
//           fontSize: 14,
//         ),
//         filled: true,
//         fillColor: isDark ? Colors.grey[900] : const Color(0xFFF5F8FF),
//         contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(
//             color: isDark ? Colors.white12 : const Color(0xFFD0E4FF),
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: _blue, width: 1.5),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: Colors.redAccent),
//         ),
//         focusedErrorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
//         ),
//       ),
//       validator: (value) =>
//           value == null || value.isEmpty ? 'Please fill in this field' : null,
//     );
//   }

//   void _loginUser() async {
//     if (_formKey.currentState!.validate()) {
//       final email = emailController.text.trim();
//       final phone = phoneController.text.trim();
//       final password = passwordController.text.trim();

//       final url = Uri.parse('http://localhost:8000/api/login');

//       try {
//         final response = await http.post(
//           url,
//           headers: {'Accept': 'application/json'},
//           body: {
//             'email': email,
//             'phone': phone,
//             'password': password,
//           },
//         );

//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);

//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('✅ ${data['message']}'),
//               backgroundColor: Colors.green,
//               duration: const Duration(seconds: 2),
//             ),
//           );

//           Future.delayed(const Duration(seconds: 2), () {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => const LoanApplicationPage()),
//             );
//           });
//         } else {
//           final data = jsonDecode(response.body);
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('❌ ${data['message']}'),
//               backgroundColor: Colors.red,
//               duration: const Duration(seconds: 2),
//             ),
//           );
//         }
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('❌ Something went wrong. Please try again.'),
//             backgroundColor: Colors.red,
//             duration: Duration(seconds: 2),
//           ),
//         );
//       }
//     }
//   }
// }

// // ── Field label widget ──
// class _FieldLabel extends StatelessWidget {
//   final String label;
//   final bool isDark;

//   const _FieldLabel({required this.label, required this.isDark});

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       label,
//       style: TextStyle(
//         fontSize: 13,
//         fontWeight: FontWeight.w600,
//         color: isDark ? Colors.white70 : Colors.black87,
//         letterSpacing: 0.2,
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  bool _isLoading = false;
  int _selectedIndex = 0;

  static const Color _blue = Color(0xFF007BFF);
  static const Color _green = Colors.green;

  void _showTopSnackBar(String message, {bool isError = false}) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 12,
        left: 16,
        right: 16,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: isError ? Colors.redAccent : Colors.green,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 12, offset: const Offset(0, 4)),
              ],
            ),
            child: Row(
              children: [
                Icon(isError ? Icons.error_rounded : Icons.check_circle_rounded, color: Colors.white, size: 20),
                const SizedBox(width: 10),
                Expanded(child: Text(message, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14))),
              ],
            ),
          ),
        ),
      ),
    );
    overlay.insert(overlayEntry);
    Future.delayed(const Duration(seconds: 3), () => overlayEntry.remove());
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    switch (index) {
      case 0: Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage())); break;
      case 1: Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AboutPage())); break;
      case 2: Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ProfilePage())); break;
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
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
        title: const Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18, letterSpacing: 0.4)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(3),
          child: Container(height: 3, decoration: const BoxDecoration(gradient: LinearGradient(colors: [_blue, _green]))),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(22, 36, 22, 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[900] : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: _blue.withOpacity(0.15)),
                    boxShadow: [BoxShadow(color: _blue.withOpacity(0.12), blurRadius: 16, offset: const Offset(0, 4))],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.asset('assets/magna_logo.jpeg', width: 40, height: 40, fit: BoxFit.cover)),
                      const SizedBox(width: 10),
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                        Text("MAGNA CREDIT", style: TextStyle(color: _blue, fontWeight: FontWeight.w800, fontSize: 13, letterSpacing: 1.2)),
                        Text("LIMITED", style: TextStyle(color: _green, fontWeight: FontWeight.w600, fontSize: 11, letterSpacing: 2)),
                      ]),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 28),
              Center(child: Column(children: [
                Text("Welcome Back", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: isDark ? Colors.white : Colors.black87)),
                const SizedBox(height: 6),
                Text("Login to your account and apply for a loan", style: TextStyle(fontSize: 13, color: isDark ? Colors.white54 : Colors.black45), textAlign: TextAlign.center),
              ])),
              const SizedBox(height: 32),
              _FieldLabel(label: "Email Address", isDark: isDark),
              const SizedBox(height: 6),
              _buildTextField(emailController, "Enter your email", icon: Icons.email_rounded, keyboardType: TextInputType.emailAddress, isDark: isDark),
              const SizedBox(height: 18),
              _FieldLabel(label: "Phone Number", isDark: isDark),
              const SizedBox(height: 6),
              _buildTextField(phoneController, "Enter your phone number", icon: Icons.phone_rounded, keyboardType: TextInputType.phone, isDark: isDark,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Please fill in this field';
                  if (v.length != 10) return 'Phone must be exactly 10 digits';
                  return null;
                }),
              const SizedBox(height: 18),
              _FieldLabel(label: "Password", isDark: isDark),
              const SizedBox(height: 6),
              TextFormField(
                controller: passwordController,
                obscureText: _obscurePassword,
                style: TextStyle(color: isDark ? Colors.white : Colors.black87, fontSize: 14),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock_rounded, color: _blue, size: 20),
                  hintText: "Enter your password",
                  hintStyle: TextStyle(color: isDark ? Colors.white38 : Colors.black38, fontSize: 14),
                  filled: true,
                  fillColor: isDark ? Colors.grey[900] : const Color(0xFFF5F8FF),
                  contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: isDark ? Colors.white12 : const Color(0xFFD0E4FF))),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: _blue, width: 1.5)),
                  errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.redAccent)),
                  focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.redAccent, width: 1.5)),
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword ? Icons.visibility_off_rounded : Icons.visibility_rounded, color: Colors.grey, size: 20),
                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
                validator: (v) => v == null || v.isEmpty ? 'Please enter your password' : null,
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ForgotPasswordPage())),
                  child: const Text("Forgot Password?", style: TextStyle(color: _blue, fontWeight: FontWeight.w600, fontSize: 13)),
                ),
              ),
              const SizedBox(height: 32),
              GestureDetector(
                onTap: _isLoading ? null : _loginUser,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: _isLoading ? _green.withOpacity(0.6) : _green,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.28), blurRadius: 16, offset: const Offset(0, 6))],
                  ),
                  child: _isLoading
                      ? const Center(child: SizedBox(width: 22, height: 22, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5)))
                      : const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Icon(Icons.login_rounded, color: Colors.white, size: 20),
                          SizedBox(width: 10),
                          Text("Login", style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700, letterSpacing: 0.5)),
                        ]),
                ),
              ),
              const SizedBox(height: 24),
              Center(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text("Don't have an account? ", style: TextStyle(fontSize: 14, color: isDark ? Colors.white60 : Colors.black54)),
                GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegistrationPage())),
                  child: const Text("Register", style: TextStyle(fontSize: 14, color: _blue, fontWeight: FontWeight.w700)),
                ),
              ])),
              const SizedBox(height: 10),
            ],
          ),
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

  Widget _buildTextField(TextEditingController controller, String hintText, {
    required bool isDark, TextInputType keyboardType = TextInputType.text,
    IconData? icon, List<TextInputFormatter>? inputFormatters, String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      style: TextStyle(color: isDark ? Colors.white : Colors.black87, fontSize: 14),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: _blue, size: 20),
        hintText: hintText,
        hintStyle: TextStyle(color: isDark ? Colors.white38 : Colors.black38, fontSize: 14),
        filled: true,
        fillColor: isDark ? Colors.grey[900] : const Color(0xFFF5F8FF),
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: isDark ? Colors.white12 : const Color(0xFFD0E4FF))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: _blue, width: 1.5)),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.redAccent)),
        focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.redAccent, width: 1.5)),
      ),
      validator: validator ?? (v) => v == null || v.isEmpty ? 'Please fill in this field' : null,
    );
  }

  Future<void> _loginUser() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    try {
      final response = await http.post(
        Uri.parse('http://localhost:8000/api/login'),
        headers: {'Accept': 'application/json', 'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'email': emailController.text.trim(), 'phone': phoneController.text.trim(), 'password': passwordController.text.trim()},
      );

      print('Login status: ${response.statusCode}');
      print('Login body: ${response.body}');

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['status'] == true) {


        _showTopSnackBar(data['message'] ?? 'Login successful!');
        await Future.delayed(const Duration(milliseconds: 800));
        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoanApplicationPage()),
        );
      } else {
        // ❌ Wrong credentials — red notification, stay on page
        _showTopSnackBar(data['message'] ?? 'Invalid email, phone, or password.', isError: true);
      }
    } catch (e) {
      print('Login error: $e');
      _showTopSnackBar('Something went wrong. Please try again.', isError: true);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
}

class _FieldLabel extends StatelessWidget {
  final String label;
  final bool isDark;
  const _FieldLabel({required this.label, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: isDark ? Colors.white70 : Colors.black87, letterSpacing: 0.2));
  }
}