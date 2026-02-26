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

  // ── Top notification overlay ──
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
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(
                  isError ? Icons.error_rounded : Icons.check_circle_rounded,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
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
      case 0:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
        break;
      case 1:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AboutPage()));
        break;
      case 2:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ProfilePage()));
        break;
    }
  }

  Future<void> _registerUser() async {
    if (!_formKey.currentState!.validate()) return;

    if (passwordController.text != confirmPasswordController.text) {
      _showTopSnackBar('Passwords do not match!', isError: true);
      return;
    }

    final url = Uri.parse('http://localhost:8000/api/register');

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
        _showTopSnackBar('Registration successful!');
        await Future.delayed(const Duration(milliseconds: 800));
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
        _showTopSnackBar(errorMessage, isError: true);
      }
    } catch (e) {
      _showTopSnackBar('Network error. Please try again.', isError: true);
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

            // ── Logo hero ──
            Container(
              child: Column(
                children: [
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
                  const SizedBox(height: 15),
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
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Please fill in this field';
                        if (value.length != 10) return 'Phone must be exactly 10 digits';
                        return null;
                      },
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


