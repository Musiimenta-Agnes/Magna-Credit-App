import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    final bool isDark =
        Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      // 🔥 SAME as login page
      backgroundColor: isDark ? Colors.black : Colors.white,

      appBar: AppBar(
        backgroundColor: const Color(0xFF007BFF), // BLUE stays blue
        elevation: 0,
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
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Personal Information",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 8),

                Text(
                  "Please fill in your details for loan verification.",
                  style: TextStyle(
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                ),

                const SizedBox(height: 25),

                _buildTextField(nameController, "Full Name", isDark),
                const SizedBox(height: 15),

                _buildTextField(
                  contactController,
                  "Contact",
                  isDark,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 15),

                _buildTextField(
                  emailController,
                  "Email",
                  isDark,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 15),

                _buildTextField(
                  bioInfoController,
                  "Bio Information",
                  isDark,
                  maxLines: 3,
                ),
                const SizedBox(height: 15),

                _buildTextField(locationController, "Location", isDark),
                const SizedBox(height: 15),

                _buildTextField(
                  otherContactController,
                  "Other Contact",
                  isDark,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 15),

                DropdownButtonFormField<String>(
                  value: selectedGender,
                  decoration: _inputDecoration("Select Gender", isDark),
                  dropdownColor: isDark ? Colors.grey[900] : Colors.white,
                  items: ["Male", "Female", "Other"]
                      .map(
                        (g) => DropdownMenuItem(
                          value: g,
                          child: Text(
                            g,
                            style: TextStyle(
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (v) => setState(() => selectedGender = v),
                  validator: (v) =>
                      v == null ? "Please select gender" : null,
                ),

                const SizedBox(height: 30),

                // 🟢 GREEN button restored (login-style)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const LoanApplicationPage2(),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      "Next",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
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

  InputDecoration _inputDecoration(String hint, bool isDark) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: isDark ? Colors.grey[900] : Colors.white,
      hintStyle:
          TextStyle(color: isDark ? Colors.white54 : Colors.black54),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide:
            BorderSide(color: isDark ? Colors.white12 : Colors.black12),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Color(0xFF007BFF)),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint,
    bool isDark, {
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: TextStyle(color: isDark ? Colors.white : Colors.black),
      decoration: _inputDecoration(hint, isDark),
      validator: (v) =>
          v == null || v.isEmpty ? "Please fill in this field" : null,
    );
  }
}









// import 'package:flutter/material.dart';
// import 'login_screen.dart';   // <-- Back arrow goes here
// import 'second_loan_application.dart';

// class LoanApplicationPage extends StatefulWidget {
//   const LoanApplicationPage({super.key});

//   @override
//   State<LoanApplicationPage> createState() => _LoanApplicationPageState();
// }

// class _LoanApplicationPageState extends State<LoanApplicationPage> {
//   final _formKey = GlobalKey<FormState>();

//   // Text Controllers
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController contactController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController bioInfoController = TextEditingController();
//   final TextEditingController locationController = TextEditingController();
//   final TextEditingController otherContactController = TextEditingController();

//   String? selectedGender;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,

//       // TOP BAR
//       appBar: AppBar(
//         backgroundColor: Color(0xFF007BFF),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => const LoginPage()),
//             );
//           },
//         ),
//         title: const Text(
//           "Loan Application",
//           style: TextStyle(color: Colors.white, fontSize: 20),
//         ),
//         centerTitle: true,
//       ),

//       // PAGE BODY
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   "Personal Information",
//                   style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.green,
//                   ),
//                 ),
//                 const SizedBox(height: 8),

//                 const Text(
//                   "Please fill in your details for loan verification. All data is safe and secure.",
//                   style: TextStyle(fontSize: 14, color: Colors.black54),
//                 ),

//                 const SizedBox(height: 25),

//                 // INPUT FIELDS (Same design as Registration page)
//                 _buildTextField(nameController, "Full Name", icon: Icons.person),
//                 const SizedBox(height: 15),

//                 _buildTextField(contactController, "Contact",
//                     icon: Icons.phone, keyboardType: TextInputType.phone),
//                 const SizedBox(height: 15),

//                 _buildTextField(emailController, "Email",
//                     icon: Icons.email, keyboardType: TextInputType.emailAddress),
//                 const SizedBox(height: 15),

//                 _buildTextField(bioInfoController, "Bio Information",
//                     maxLines: 3, icon: Icons.info_outline),
//                 const SizedBox(height: 15),

//                 _buildTextField(locationController, "Location",
//                     icon: Icons.location_on),
//                 const SizedBox(height: 15),

//                 _buildTextField(otherContactController, "Other Contact",
//                     keyboardType: TextInputType.phone, icon: Icons.phone),
//                 const SizedBox(height: 15),

//                 // Gender
//                 DropdownButtonFormField<String>(
//                   initialValue: selectedGender,
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(Icons.person_pin, color: Colors.blueAccent),
//                     labelText: "Select Gender",
//                     filled: true,
//                     fillColor: Colors.white,
//                     contentPadding:
//                         const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(6),
//                       borderSide: const BorderSide(color: Colors.black12),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(6),
//                       borderSide: const BorderSide(color: Colors.blueAccent),
//                     ),
//                   ),
//                   items: ["Male", "Female", "Other"]
//                       .map((gender) => DropdownMenuItem(
//                             value: gender,
//                             child: Text(gender),
//                           ))
//                       .toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       selectedGender = value;
//                     });
//                   },
//                   validator: (value) =>
//                       value == null ? "Please select gender" : null,
//                 ),

//                 const SizedBox(height: 30),

//                 // NEXT BUTTON
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       if (_formKey.currentState!.validate()) {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const LoanApplicationPage2(),
//                           ),
//                         );
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green,
//                       padding: const EdgeInsets.symmetric(vertical: 14),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: const Text(
//                       "Next",
//                       style: TextStyle(
//                           fontSize: 18,
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 40),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // 🔹 Same styled text field as RegistrationPage
//   Widget _buildTextField(
//     TextEditingController controller,
//     String label, {
//     TextInputType keyboardType = TextInputType.text,
//     IconData? icon,
//     int maxLines = 1,
//   }) {
//     return TextFormField(
//       controller: controller,
//       keyboardType: keyboardType,
//       maxLines: maxLines,
//       decoration: InputDecoration(
//         prefixIcon: Icon(icon, color: Colors.blueAccent),
//         hintText: label,
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
//           borderSide: const BorderSide(color: Colors.blueAccent),
//         ),
//       ),
//       validator: (value) =>
//           value == null || value.isEmpty ? "Please enter $label" : null,
//     );
//   }
// }


