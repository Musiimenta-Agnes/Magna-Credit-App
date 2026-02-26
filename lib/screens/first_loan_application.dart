import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'login_screen.dart';
import 'second_loan_application.dart';

class LoanApplicationPage extends StatefulWidget {
  const LoanApplicationPage({super.key});

  @override
  State<LoanApplicationPage> createState() => _LoanApplicationPageState();
}

class _LoanApplicationPageState extends State<LoanApplicationPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController bioInfoController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController otherContactController = TextEditingController();

  String? selectedGender;
  bool _isLoading = false;

  static const Color _blue = Color(0xFF007BFF);
  static const Color _green = Colors.green;

  final String apiUrl = "http://localhost:8000/api/loan-applications";
  int userId = 1;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : const Color(0xFFF5F8FA),

      appBar: AppBar(
        backgroundColor: _blue,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginPage()),
            );
          },
        ),
        title: const Text(
          "Loan Application",
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

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(18, 24, 18, 30),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // ── Step indicator ──
                _StepIndicator(currentStep: 1),

                const SizedBox(height: 22),

                // ── Section card ──
                _FormCard(
                  isDark: isDark,
                  title: "Personal Information",
                  icon: Icons.person_rounded,
                  subtitle: "Fill in your details for loan verification.",
                  children: [
                    _buildField(
                      nameController, "Full Name",
                      icon: Icons.badge_rounded, isDark: isDark,
                    ),
                    _buildField(
                      contactController, "Phone Number",
                      icon: Icons.phone_rounded, isDark: isDark,
                      keyboardType: TextInputType.phone,
                    ),
                    _buildField(
                      emailController, "Email Address",
                      icon: Icons.email_rounded, isDark: isDark,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    _buildField(
                      bioInfoController, "Bio Information",
                      icon: Icons.info_outline_rounded, isDark: isDark,
                      maxLines: 3,
                    ),
                    _buildField(
                      locationController, "Location",
                      icon: Icons.location_on_rounded, isDark: isDark,
                    ),
                    _buildField(
                      otherContactController, "Other Contact",
                      icon: Icons.phone_in_talk_rounded, isDark: isDark,
                      keyboardType: TextInputType.phone,
                    ),
                    _buildDropdown(
                      label: "Gender",
                      value: selectedGender,
                      items: ["Male", "Female", "Other"],
                      icon: Icons.wc_rounded,
                      isDark: isDark,
                      onChanged: (v) => setState(() => selectedGender = v),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                // ── Next button ──
                GestureDetector(
                  onTap: _isLoading ? null : _submitLoanApplication,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      color: _green,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.28),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: _isLoading
                        ? const Center(
                            child: SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.5,
                              ),
                            ),
                          )
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Next",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.4,
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
        ),
      ),
    );
  }

  Widget _buildField(
    TextEditingController controller,
    String label, {
    required IconData icon,
    required bool isDark,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        style: TextStyle(
            color: isDark ? Colors.white : Colors.black87, fontSize: 14),
        decoration: _fieldDecoration(label, icon, isDark),
        validator: (v) =>
            v == null || v.isEmpty ? "Please fill in this field" : null,
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required IconData icon,
    required bool isDark,
    required Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: DropdownButtonFormField<String>(
        value: value,
        style: TextStyle(
            color: isDark ? Colors.white : Colors.black87, fontSize: 14),
        dropdownColor: isDark ? Colors.grey[900] : Colors.white,
        decoration: _fieldDecoration(label, icon, isDark),
        items: items
            .map((g) => DropdownMenuItem(
                  value: g,
                  child: Text(g,
                      style: TextStyle(
                          color: isDark ? Colors.white : Colors.black87)),
                ))
            .toList(),
        onChanged: onChanged,
        validator: (v) => v == null ? "Please select $label" : null,
      ),
    );
  }

  InputDecoration _fieldDecoration(
      String label, IconData icon, bool isDark) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
          color: isDark ? Colors.white54 : Colors.black45, fontSize: 13),
      prefixIcon: Icon(icon, color: const Color(0xFF007BFF), size: 18),
      filled: true,
      fillColor: isDark ? Colors.grey[850] : const Color(0xFFF5F8FF),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 13, horizontal: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: isDark ? Colors.white12 : const Color(0xFFD0E4FF),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide:
            const BorderSide(color: Color(0xFF007BFF), width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide:
            const BorderSide(color: Colors.redAccent, width: 1.5),
      ),
    );
  }

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

  Future<void> _submitLoanApplication() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'user_id': userId,
          'name': nameController.text.trim(),
          'contact': contactController.text.trim(),
          'email': emailController.text.trim(),
          'bio_info': bioInfoController.text.trim(),
          'location': locationController.text.trim(),
          'other_contact': otherContactController.text.trim(),
          'gender': selectedGender,
        }),
      );

      // Debug logs — remove after testing
      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Clear all form fields
        nameController.clear();
        contactController.clear();
        emailController.clear();
        bioInfoController.clear();
        locationController.clear();
        otherContactController.clear();
        setState(() => selectedGender = null);

        _showTopSnackBar('Loan application submitted successfully!');

        // Navigate to next page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => LoanApplicationPage2(
              loanApplicationId: data['data']['id'],
            ),
          ),
        );
      } else {
        final errorMessage = data['message'] ?? "Failed to submit loan application";
        _showTopSnackBar(errorMessage, isError: true);
      }
    } catch (e) {
      print('Exception: $e');
      _showTopSnackBar('Error: $e', isError: true);
    } finally {
      setState(() => _isLoading = false);
    }
  }
}

// ── Shared step indicator ──
class _StepIndicator extends StatelessWidget {
  final int currentStep;

  const _StepIndicator({required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _Step(number: 1, label: "Personal", isActive: currentStep >= 1, isDone: currentStep > 1),
        _StepLine(isActive: currentStep > 1),
        _Step(number: 2, label: "Details", isActive: currentStep >= 2, isDone: currentStep > 2),
        _StepLine(isActive: currentStep > 2),
        _Step(number: 3, label: "Submit", isActive: currentStep >= 3, isDone: false),
      ],
    );
  }
}

class _Step extends StatelessWidget {
  final int number;
  final String label;
  final bool isActive;
  final bool isDone;

  static const Color _blue = Color(0xFF007BFF);

  const _Step({
    required this.number,
    required this.label,
    required this.isActive,
    required this.isDone,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: isActive ? _blue : Colors.grey.shade200,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: isDone
                ? const Icon(Icons.check_rounded, color: Colors.white, size: 16)
                : Text(
                    "$number",
                    style: TextStyle(
                      color: isActive ? Colors.white : Colors.grey,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: isActive ? _blue : Colors.grey,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

class _StepLine extends StatelessWidget {
  final bool isActive;
  const _StepLine({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.only(bottom: 16, left: 4, right: 4),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF007BFF) : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}

// ── Shared form card ──
class _FormCard extends StatelessWidget {
  final bool isDark;
  final String title;
  final IconData icon;
  final String subtitle;
  final List<Widget> children;

  static const Color _blue = Color(0xFF007BFF);
  static const Color _green = Colors.green;

  const _FormCard({
    required this.isDark,
    required this.title,
    required this.icon,
    required this.subtitle,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _blue.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 20,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [_blue, _green],
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 10),
              Icon(icon, color: _blue, size: 18),
              const SizedBox(width: 6),
              Text(
                title,
                style: const TextStyle(
                  color: _blue,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 14),
            child: Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: isDark ? Colors.white38 : Colors.black38,
              ),
            ),
          ),
          const SizedBox(height: 18),
          ...children,
        ],
      ),
    );
  }
}










// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'login_screen.dart';
// import 'second_loan_application.dart';

// class LoanApplicationPage extends StatefulWidget {
//   const LoanApplicationPage({super.key});

//   @override
//   State<LoanApplicationPage> createState() => _LoanApplicationPageState();
// }

// class _LoanApplicationPageState extends State<LoanApplicationPage> {
//   final _formKey = GlobalKey<FormState>();

//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController contactController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController bioInfoController = TextEditingController();
//   final TextEditingController locationController = TextEditingController();
//   final TextEditingController otherContactController = TextEditingController();

//   String? selectedGender;
//   bool _isLoading = false;

//   static const Color _blue = Color(0xFF007BFF);
//   static const Color _green = Colors.green;

//   final String apiUrl = "http://localhost:8000/api/loan-applications";
//   int userId = 1;

//   @override
//   Widget build(BuildContext context) {
//     final bool isDark = Theme.of(context).brightness == Brightness.dark;

//     return Scaffold(
//       backgroundColor: isDark ? Colors.black : const Color(0xFFF5F8FA),

//       appBar: AppBar(
//         backgroundColor: _blue,
//         elevation: 0,
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (_) => const LoginPage()),
//             );
//           },
//         ),
//         title: const Text(
//           "Loan Application",
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

//       body: SafeArea(
//         child: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           padding: const EdgeInsets.fromLTRB(18, 24, 18, 30),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [

//                 // ── Step indicator ──
//                 _StepIndicator(currentStep: 1),

//                 const SizedBox(height: 22),

//                 // ── Section card ──
//                 _FormCard(
//                   isDark: isDark,
//                   title: "Personal Information",
//                   icon: Icons.person_rounded,
//                   subtitle: "Fill in your details for loan verification.",
//                   children: [
//                     _buildField(
//                       nameController, "Full Name",
//                       icon: Icons.badge_rounded, isDark: isDark,
//                     ),
//                     _buildField(
//                       contactController, "Phone Number",
//                       icon: Icons.phone_rounded, isDark: isDark,
//                       keyboardType: TextInputType.phone,
//                     ),
//                     _buildField(
//                       emailController, "Email Address",
//                       icon: Icons.email_rounded, isDark: isDark,
//                       keyboardType: TextInputType.emailAddress,
//                     ),
//                     _buildField(
//                       bioInfoController, "Bio Information",
//                       icon: Icons.info_outline_rounded, isDark: isDark,
//                       maxLines: 3,
//                     ),
//                     _buildField(
//                       locationController, "Location",
//                       icon: Icons.location_on_rounded, isDark: isDark,
//                     ),
//                     _buildField(
//                       otherContactController, "Other Contact",
//                       icon: Icons.phone_in_talk_rounded, isDark: isDark,
//                       keyboardType: TextInputType.phone,
//                     ),
//                     _buildDropdown(
//                       label: "Gender",
//                       value: selectedGender,
//                       items: ["Male", "Female", "Other"],
//                       icon: Icons.wc_rounded,
//                       isDark: isDark,
//                       onChanged: (v) => setState(() => selectedGender = v),
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 28),

//                 // ── Next button ──
//                 GestureDetector(
//                   onTap: _isLoading ? null : _submitLoanApplication,
//                   child: Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.symmetric(vertical: 15),
//                     decoration: BoxDecoration(
//                       color: _green,
//                       borderRadius: BorderRadius.circular(16),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.green.withOpacity(0.28),
//                           blurRadius: 16,
//                           offset: const Offset(0, 6),
//                         ),
//                       ],
//                     ),
//                     child: _isLoading
//                         ? const Center(
//                             child: SizedBox(
//                               width: 22,
//                               height: 22,
//                               child: CircularProgressIndicator(
//                                 color: Colors.white,
//                                 strokeWidth: 2.5,
//                               ),
//                             ),
//                           )
//                         : const Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 "Next",
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.w700,
//                                   letterSpacing: 0.4,
//                                 ),
//                               ),
//                               SizedBox(width: 8),
//                               Icon(Icons.arrow_forward_rounded,
//                                   color: Colors.white, size: 18),
//                             ],
//                           ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildField(
//     TextEditingController controller,
//     String label, {
//     required IconData icon,
//     required bool isDark,
//     TextInputType keyboardType = TextInputType.text,
//     int maxLines = 1,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 14),
//       child: TextFormField(
//         controller: controller,
//         keyboardType: keyboardType,
//         maxLines: maxLines,
//         style: TextStyle(
//             color: isDark ? Colors.white : Colors.black87, fontSize: 14),
//         decoration: _fieldDecoration(label, icon, isDark),
//         validator: (v) =>
//             v == null || v.isEmpty ? "Please fill in this field" : null,
//       ),
//     );
//   }

//   Widget _buildDropdown({
//     required String label,
//     required String? value,
//     required List<String> items,
//     required IconData icon,
//     required bool isDark,
//     required Function(String?) onChanged,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 14),
//       child: DropdownButtonFormField<String>(
//         value: value,
//         style: TextStyle(
//             color: isDark ? Colors.white : Colors.black87, fontSize: 14),
//         dropdownColor: isDark ? Colors.grey[900] : Colors.white,
//         decoration: _fieldDecoration(label, icon, isDark),
//         items: items
//             .map((g) => DropdownMenuItem(
//                   value: g,
//                   child: Text(g,
//                       style: TextStyle(
//                           color: isDark ? Colors.white : Colors.black87)),
//                 ))
//             .toList(),
//         onChanged: onChanged,
//         validator: (v) => v == null ? "Please select $label" : null,
//       ),
//     );
//   }

//   InputDecoration _fieldDecoration(
//       String label, IconData icon, bool isDark) {
//     return InputDecoration(
//       labelText: label,
//       labelStyle: TextStyle(
//           color: isDark ? Colors.white54 : Colors.black45, fontSize: 13),
//       prefixIcon: Icon(icon, color: const Color(0xFF007BFF), size: 18),
//       filled: true,
//       fillColor: isDark ? Colors.grey[850] : const Color(0xFFF5F8FF),
//       contentPadding:
//           const EdgeInsets.symmetric(vertical: 13, horizontal: 14),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide(
//           color: isDark ? Colors.white12 : const Color(0xFFD0E4FF),
//         ),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide:
//             const BorderSide(color: Color(0xFF007BFF), width: 1.5),
//       ),
//       errorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: const BorderSide(color: Colors.redAccent),
//       ),
//       focusedErrorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide:
//             const BorderSide(color: Colors.redAccent, width: 1.5),
//       ),
//     );
//   }

//   Future<void> _submitLoanApplication() async {
//     if (!_formKey.currentState!.validate()) return;
//     setState(() => _isLoading = true);

//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           'user_id': userId,
//           'name': nameController.text.trim(),
//           'contact': contactController.text.trim(),
//           'email': emailController.text.trim(),
//           'bio_info': bioInfoController.text.trim(),
//           'location': locationController.text.trim(),
//           'other_contact': otherContactController.text.trim(),
//           'gender': selectedGender,
//         }),
//       );

//       final data = jsonDecode(response.body);

//       if (response.statusCode == 201 && data['success'] == true) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//               content: Text(data['message']),
//               backgroundColor: Colors.green),
//         );
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (_) => LoanApplicationPage2(
//               loanApplicationId: data['data']['id'],
//             ),
//           ),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//                 data['message'] ?? "Failed to submit loan application"),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//             content: Text("Error: $e"), backgroundColor: Colors.red),
//       );
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }
// }

// // ── Shared step indicator ──
// class _StepIndicator extends StatelessWidget {
//   final int currentStep;

//   const _StepIndicator({required this.currentStep});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         _Step(number: 1, label: "Personal", isActive: currentStep >= 1, isDone: currentStep > 1),
//         _StepLine(isActive: currentStep > 1),
//         _Step(number: 2, label: "Details", isActive: currentStep >= 2, isDone: currentStep > 2),
//         _StepLine(isActive: currentStep > 2),
//         _Step(number: 3, label: "Submit", isActive: currentStep >= 3, isDone: false),
//       ],
//     );
//   }
// }

// class _Step extends StatelessWidget {
//   final int number;
//   final String label;
//   final bool isActive;
//   final bool isDone;

//   static const Color _blue = Color(0xFF007BFF);

//   const _Step({
//     required this.number,
//     required this.label,
//     required this.isActive,
//     required this.isDone,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           width: 32,
//           height: 32,
//           decoration: BoxDecoration(
//             color: isActive ? _blue : Colors.grey.shade200,
//             shape: BoxShape.circle,
//           ),
//           child: Center(
//             child: isDone
//                 ? const Icon(Icons.check_rounded, color: Colors.white, size: 16)
//                 : Text(
//                     "$number",
//                     style: TextStyle(
//                       color: isActive ? Colors.white : Colors.grey,
//                       fontWeight: FontWeight.w700,
//                       fontSize: 13,
//                     ),
//                   ),
//           ),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 10,
//             color: isActive ? _blue : Colors.grey,
//             fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _StepLine extends StatelessWidget {
//   final bool isActive;
//   const _StepLine({required this.isActive});

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Container(
//         height: 2,
//         margin: const EdgeInsets.only(bottom: 16, left: 4, right: 4),
//         decoration: BoxDecoration(
//           color: isActive ? const Color(0xFF007BFF) : Colors.grey.shade200,
//           borderRadius: BorderRadius.circular(2),
//         ),
//       ),
//     );
//   }
// }

// // ── Shared form card ──
// class _FormCard extends StatelessWidget {
//   final bool isDark;
//   final String title;
//   final IconData icon;
//   final String subtitle;
//   final List<Widget> children;

//   static const Color _blue = Color(0xFF007BFF);
//   static const Color _green = Colors.green;

//   const _FormCard({
//     required this.isDark,
//     required this.title,
//     required this.icon,
//     required this.subtitle,
//     required this.children,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: isDark ? Colors.grey[900] : Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: _blue.withOpacity(0.1)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
//             blurRadius: 16,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 width: 4,
//                 height: 20,
//                 decoration: BoxDecoration(
//                   gradient: const LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [_blue, _green],
//                   ),
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//               ),
//               const SizedBox(width: 10),
//               Icon(icon, color: _blue, size: 18),
//               const SizedBox(width: 6),
//               Text(
//                 title,
//                 style: const TextStyle(
//                   color: _blue,
//                   fontSize: 15,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 6),
//           Padding(
//             padding: const EdgeInsets.only(left: 14),
//             child: Text(
//               subtitle,
//               style: TextStyle(
//                 fontSize: 12,
//                 color: isDark ? Colors.white38 : Colors.black38,
//               ),
//             ),
//           ),
//           const SizedBox(height: 18),
//           ...children,
//         ],
//       ),
//     );
//   }
// }