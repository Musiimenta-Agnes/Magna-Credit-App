

// // import 'dart:io';

// // import 'package:flutter/foundation.dart';
// // import 'package:flutter/material.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'package:http/http.dart' as http;
// // import 'success_message.dart';

// // class LoanApplicationPage2 extends StatefulWidget {
// //   final int loanApplicationId;

// //   const LoanApplicationPage2({super.key, required this.loanApplicationId});

// //   @override
// //   State<LoanApplicationPage2> createState() => _LoanApplicationPage2State();
// // }

// // class _LoanApplicationPage2State extends State<LoanApplicationPage2> {
// //   final _formKey = GlobalKey<FormState>();

// //   final TextEditingController kinNameController = TextEditingController();
// //   final TextEditingController kinContactController = TextEditingController();
// //   final TextEditingController incomeController = TextEditingController();
// //   final TextEditingController addressController = TextEditingController();

// //   String? selectedOccupation;
// //   String? selectedLoanType;
// //   String? selectedEducation;

// //   XFile? nationalIdImage;
// //   List<XFile> collateralImages = [];

// //   final ImagePicker picker = ImagePicker();

// //   // ===== Updated Base URL =====
// //   String getBaseUrl() {
// //     if (kIsWeb) {
// //       return 'http://localhost:8000';
// //     } else {
// //       // Android emulator: 10.0.2.2
// //       // Physical device: replace with your PC local IP, e.g., 192.168.1.100
// //       return 'http://10.0.2.2:8000';
// //     }
// //   }

// //   Future<void> pickNationalIdImage() async {
// //     final picked = await picker.pickImage(source: ImageSource.gallery);
// //     if (picked != null) {
// //       setState(() => nationalIdImage = picked);
// //     }
// //   }

// //   Future<void> pickCollateralImages() async {
// //     final pickedFiles = await picker.pickMultiImage();
// //     if (pickedFiles.isNotEmpty) {
// //       setState(() {
// //         collateralImages = pickedFiles;
// //       });
// //     }
// //   }

// //   Future<void> submitApplication() async {
// //     if (!_formKey.currentState!.validate()) return;

// //     if (nationalIdImage == null) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text("Please upload National ID")),
// //       );
// //       return;
// //     }

// //     try {
// //       var uri = Uri.parse("${getBaseUrl()}/api/loan-application-details");
// //       var request = http.MultipartRequest("POST", uri);

// //       request.fields['loan_application_id'] =
// //           widget.loanApplicationId.toString();
// //       request.fields['kin_name'] = kinNameController.text;
// //       request.fields['kin_contact'] = kinContactController.text;
// //       request.fields['occupation'] = selectedOccupation!;
// //       request.fields['monthly_income'] = incomeController.text;
// //       request.fields['loan_type'] = selectedLoanType!;
// //       request.fields['education'] = selectedEducation!;
// //       request.fields['address'] = addressController.text;

// //       // ===== NATIONAL ID IMAGE =====
// //       if (kIsWeb) {
// //         final bytes = await nationalIdImage!.readAsBytes();
// //         request.files.add(
// //           http.MultipartFile.fromBytes(
// //             'national_id_image',
// //             bytes,
// //             filename: nationalIdImage!.name,
// //           ),
// //         );
// //       } else {
// //         request.files.add(
// //           await http.MultipartFile.fromPath(
// //             'national_id_image',
// //             nationalIdImage!.path,
// //           ),
// //         );
// //       }

// //       // ===== COLLATERAL IMAGES =====
// //       for (var image in collateralImages) {
// //         if (kIsWeb) {
// //           final bytes = await image.readAsBytes();
// //           request.files.add(
// //             http.MultipartFile.fromBytes(
// //               'collateral_images[]',
// //               bytes,
// //               filename: image.name,
// //             ),
// //           );
// //         } else {
// //           request.files.add(
// //             await http.MultipartFile.fromPath(
// //               'collateral_images[]',
// //               image.path,
// //             ),
// //           );
// //         }
// //       }

// //       var response = await request.send();
// //       var responseBody = await response.stream.bytesToString();

// //       if (response.statusCode == 201) {
// //         Navigator.pushReplacement(
// //           context,
// //           MaterialPageRoute(
// //             builder: (context) => const ApplicationSuccessPage(),
// //           ),
// //         );
// //       } else {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(content: Text("Error: $responseBody")),
// //         );
// //       }
// //     } catch (e) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text("Something went wrong: $e")),
// //       );
// //     }
// //   }

// //   Widget buildImagePreview(XFile image) {
// //     if (kIsWeb) {
// //       return Image.network(
// //         image.path,
// //         fit: BoxFit.cover,
// //       );
// //     } else {
// //       return Image.file(
// //         File(image.path),
// //         fit: BoxFit.cover,
// //       );
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final theme = Theme.of(context);
// //     final isDark = theme.brightness == Brightness.dark;

// //     Color background = isDark ? Colors.black : Colors.white;
// //     Color textColor = isDark ? Colors.white : Colors.black;
// //     Color subtitleColor = isDark ? Colors.white70 : Colors.black87;
// //     Color fillColor = isDark ? Colors.grey[900]! : Colors.white;
// //     Color containerColor = isDark ? Colors.grey[900]! : Colors.grey.shade100;

// //     return Scaffold(
// //       backgroundColor: background,
// //       appBar: AppBar(
// //         backgroundColor: const Color(0xFF007BFF),
// //         elevation: 0,
// //         leading: IconButton(
// //           icon: const Icon(Icons.arrow_back, color: Colors.white),
// //           onPressed: () => Navigator.pop(context),
// //         ),
// //         title: const Text(
// //           "Basic Information",
// //           style: TextStyle(color: Colors.white, fontSize: 20),
// //         ),
// //         centerTitle: true,
// //       ),
// //       body: SingleChildScrollView(
// //         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
// //         child: Form(
// //           key: _formKey,
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [

// //               Text(
// //                 "Continue your loan application by submitting required details below.",
// //                 style: const TextStyle(
// //                   color: Colors.green,
// //                   fontSize: 17,
// //                   fontWeight: FontWeight.w600,
// //                 ),
// //               ),
// //               const SizedBox(height: 25),

// //               _buildField("Next of Kin Name", kinNameController,
// //                   fillColor: fillColor, textColor: textColor),
// //               const SizedBox(height: 15),

// //               _buildField(
// //                 "Next of Kin Contact",
// //                 kinContactController,
// //                 keyboardType: TextInputType.phone,
// //                 fillColor: fillColor,
// //                 textColor: textColor,
// //               ),
// //               const SizedBox(height: 15),

// //               _buildDropdown(
// //                 label: "Your Occupation",
// //                 value: selectedOccupation,
// //                 items: [
// //                   "Farmer",
// //                   "Business Owner",
// //                   "Teacher",
// //                   "Engineer",
// //                   "Driver",
// //                   "Student",
// //                   "Civil Servant",
// //                   "Medical Worker",
// //                   "Technician",
// //                   "Other",
// //                 ],
// //                 onChanged: (v) => setState(() => selectedOccupation = v),
// //                 fillColor: fillColor,
// //                 textColor: textColor,
// //                 isDark: isDark,
// //               ),
// //               const SizedBox(height: 15),

// //               _buildField(
// //                 "Your Monthly Income (UGX)",
// //                 incomeController,
// //                 keyboardType: TextInputType.number,
// //                 fillColor: fillColor,
// //                 textColor: textColor,
// //               ),
// //               const SizedBox(height: 15),

// //               _buildDropdown(
// //                 label: "Loan Type",
// //                 value: selectedLoanType,
// //                 items: [
// //                   "Logbook Loan",
// //                   "Business Loan",
// //                   "Personal Loan",
// //                   "Investment Loan",
// //                   "Car Loan",
// //                 ],
// //                 onChanged: (v) => setState(() => selectedLoanType = v),
// //                 fillColor: fillColor,
// //                 textColor: textColor,
// //                 isDark: isDark,
// //               ),
// //               const SizedBox(height: 15),

// //               _buildDropdown(
// //                 label: "Your Highest Education",
// //                 value: selectedEducation,
// //                 items: [
// //                   "Primary",
// //                   "Secondary",
// //                   "Diploma",
// //                   "Bachelor’s Degree",
// //                   "Master’s Degree",
// //                   "Doctorate",
// //                   "Other",
// //                 ],
// //                 onChanged: (v) => setState(() => selectedEducation = v),
// //                 fillColor: fillColor,
// //                 textColor: textColor,
// //                 isDark: isDark,
// //               ),
// //               const SizedBox(height: 15),

// //               _buildField(
// //                 "Your Current Address",
// //                 addressController,
// //                 fillColor: fillColor,
// //                 textColor: textColor,
// //               ),
// //               const SizedBox(height: 20),

// //               Text(
// //                 "National ID",
// //                 style: TextStyle(
// //                   fontSize: 16,
// //                   fontWeight: FontWeight.bold,
// //                   color: textColor,
// //                 ),
// //               ),
// //               const SizedBox(height: 8),

// //               GestureDetector(
// //                 onTap: pickNationalIdImage,
// //                 child: Container(
// //                   height: 150,
// //                   width: double.infinity,
// //                   decoration: BoxDecoration(
// //                     color: containerColor,
// //                     borderRadius: BorderRadius.circular(10),
// //                     border: Border.all(color: Colors.blueAccent, width: 0.8),
// //                   ),
// //                   child: nationalIdImage == null
// //                       ? Center(
// //                           child: Text(
// //                             "Tap to upload National ID",
// //                             style: TextStyle(color: subtitleColor),
// //                           ),
// //                         )
// //                       : buildImagePreview(nationalIdImage!),
// //                 ),
// //               ),
// //               const SizedBox(height: 20),

// //               Text(
// //                 "Collateral (Upload one or more images)",
// //                 style: TextStyle(
// //                   fontSize: 16,
// //                   fontWeight: FontWeight.bold,
// //                   color: textColor,
// //                 ),
// //               ),
// //               const SizedBox(height: 8),

// //               GestureDetector(
// //                 onTap: pickCollateralImages,
// //                 child: Container(
// //                   height: 150,
// //                   decoration: BoxDecoration(
// //                     color: containerColor,
// //                     borderRadius: BorderRadius.circular(10),
// //                     border: Border.all(color: Colors.blueAccent, width: 0.8),
// //                   ),
// //                   child: collateralImages.isEmpty
// //                       ? Center(
// //                           child: Text(
// //                             "Tap to upload collateral images",
// //                             style: TextStyle(color: subtitleColor),
// //                           ),
// //                         )
// //                       : ListView(
// //                           scrollDirection: Axis.horizontal,
// //                           children: collateralImages
// //                               .map(
// //                                 (img) => Padding(
// //                                   padding: const EdgeInsets.all(5),
// //                                   child: SizedBox(
// //                                     width: 120,
// //                                     height: 120,
// //                                     child: buildImagePreview(img),
// //                                   ),
// //                                 ),
// //                               )
// //                               .toList(),
// //                         ),
// //                 ),
// //               ),
// //               const SizedBox(height: 30),

// //               SizedBox(
// //                 width: double.infinity,
// //                 child: ElevatedButton(
// //                   onPressed: submitApplication,
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: Colors.green,
// //                     padding: const EdgeInsets.symmetric(vertical: 14),
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(8),
// //                     ),
// //                   ),
// //                   child: const Text(
// //                     "Submit Application",
// //                     style: TextStyle(
// //                       fontSize: 18,
// //                       color: Colors.white,
// //                       fontWeight: FontWeight.bold,
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildField(
// //     String label,
// //     TextEditingController controller, {
// //     TextInputType keyboardType = TextInputType.text,
// //     required Color fillColor,
// //     required Color textColor,
// //   }) {
// //     return TextFormField(
// //       controller: controller,
// //       keyboardType: keyboardType,
// //       style: TextStyle(color: textColor),
// //       validator: (val) =>
// //           val == null || val.isEmpty ? "Please enter $label" : null,
// //       decoration: InputDecoration(
// //         labelText: label,
// //         labelStyle: TextStyle(color: textColor),
// //         filled: true,
// //         fillColor: fillColor,
// //         enabledBorder: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(6),
// //           borderSide: BorderSide(
// //               color: textColor == Colors.white
// //                   ? Colors.white12
// //                   : Colors.black12,
// //               width: 0.6),
// //         ),
// //         focusedBorder: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(6),
// //           borderSide:
// //               const BorderSide(color: Colors.blueAccent, width: 0.8),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildDropdown({
// //     required String label,
// //     required String? value,
// //     required List<String> items,
// //     required Function(String?) onChanged,
// //     required Color fillColor,
// //     required Color textColor,
// //     required bool isDark,
// //   }) {
// //     return DropdownButtonFormField<String>(
// //       initialValue: value,
// //       style: TextStyle(color: textColor),
// //       decoration: InputDecoration(
// //         labelText: label,
// //         labelStyle: TextStyle(color: textColor),
// //         filled: true,
// //         fillColor: fillColor,
// //         enabledBorder: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(6),
// //           borderSide: BorderSide(
// //               color: isDark ? Colors.white12 : Colors.black12,
// //               width: 0.6),
// //         ),
// //         focusedBorder: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(6),
// //           borderSide:
// //               const BorderSide(color: Colors.blueAccent, width: 0.8),
// //         ),
// //       ),
// //       items: items
// //           .map(
// //             (item) => DropdownMenuItem(
// //               value: item,
// //               child: Text(
// //                 item,
// //                 style: TextStyle(color: textColor),
// //               ),
// //             ),
// //           )
// //           .toList(),
// //       onChanged: onChanged,
// //       validator: (val) => val == null ? "Please select your $label" : null,
// //     );
// //   }
// // }









































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

//   // Replace this with your actual backend API URL
//   final String apiUrl = "http://127.0.0.1:8000/api/loan-applications";



//   // Example: If you have login and saved user_id:
//   int userId = 1; // Replace with actual logged-in user ID

//   @override
//   Widget build(BuildContext context) {
//     final bool isDark = Theme.of(context).brightness == Brightness.dark;

//     return Scaffold(
//       backgroundColor: isDark ? Colors.black : Colors.white,
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF007BFF),
//         elevation: 0,
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
//           style: TextStyle(color: Colors.white, fontSize: 20),
//         ),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Personal Information",
//                   style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                     color: isDark ? Colors.white : Colors.black,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   "Please fill in your details for loan verification.",
//                   style: TextStyle(
//                     color: isDark ? Colors.white70 : Colors.black54,
//                   ),
//                 ),
//                 const SizedBox(height: 25),
//                 _buildTextField(nameController, "Full Name", isDark),
//                 const SizedBox(height: 15),
//                 _buildTextField(
//                   contactController,
//                   "Contact",
//                   isDark,
//                   keyboardType: TextInputType.phone,
//                 ),
//                 const SizedBox(height: 15),
//                 _buildTextField(
//                   emailController,
//                   "Email",
//                   isDark,
//                   keyboardType: TextInputType.emailAddress,
//                 ),
//                 const SizedBox(height: 15),
//                 _buildTextField(
//                   bioInfoController,
//                   "Bio Information",
//                   isDark,
//                   maxLines: 3,
//                 ),
//                 const SizedBox(height: 15),
//                 _buildTextField(locationController, "Location", isDark),
//                 const SizedBox(height: 15),
//                 _buildTextField(
//                   otherContactController,
//                   "Other Contact",
//                   isDark,
//                   keyboardType: TextInputType.phone,
//                 ),
//                 const SizedBox(height: 15),
//                 DropdownButtonFormField<String>(
//                   initialValue: selectedGender,
//                   decoration: _inputDecoration("Select Gender", isDark),
//                   dropdownColor: isDark ? Colors.grey[900] : Colors.white,
//                   items: ["Male", "Female", "Other"]
//                       .map(
//                         (g) => DropdownMenuItem(
//                           value: g,
//                           child: Text(
//                             g,
//                             style: TextStyle(
//                               color: isDark ? Colors.white : Colors.black,
//                             ),
//                           ),
//                         ),
//                       )
//                       .toList(),
//                   onChanged: (v) => setState(() => selectedGender = v),
//                   validator: (v) => v == null ? "Please select gender" : null,
//                 ),
//                 const SizedBox(height: 30),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green,
//                       padding: const EdgeInsets.symmetric(vertical: 14),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     onPressed: _isLoading ? null : _submitLoanApplication,
//                     child: _isLoading
//                         ? const CircularProgressIndicator(
//                             valueColor: AlwaysStoppedAnimation(Colors.white),
//                           )
//                         : const Text(
//                             "Next",
//                             style: TextStyle(
//                               fontSize: 18,
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
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

//   InputDecoration _inputDecoration(String hint, bool isDark) {
//     return InputDecoration(
//       hintText: hint,
//       filled: true,
//       fillColor: isDark ? Colors.grey[900] : Colors.white,
//       hintStyle: TextStyle(color: isDark ? Colors.white54 : Colors.black54),
//       contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(6),
//         borderSide: BorderSide(color: isDark ? Colors.white12 : Colors.black12),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(6),
//         borderSide: const BorderSide(color: Color(0xFF007BFF)),
//       ),
//     );
//   }

//   Widget _buildTextField(
//     TextEditingController controller,
//     String hint,
//     bool isDark, {
//     TextInputType keyboardType = TextInputType.text,
//     int maxLines = 1,
//   }) {
//     return TextFormField(
//       controller: controller,
//       keyboardType: keyboardType,
//       maxLines: maxLines,
//       style: TextStyle(color: isDark ? Colors.white : Colors.black),
//       decoration: _inputDecoration(hint, isDark),
//       validator: (v) => v == null || v.isEmpty ? "Please fill in this field" : null,
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
//             content: Text(data['message']),
//             backgroundColor: Colors.green,
//           ),
//         );

//         Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (_) => LoanApplicationPage2(
//                   loanApplicationId: data['data']['id'], // ← pass backend ID
//                 ),
//               ),
//             );


//         // Navigate to next loan page
//         // Navigator.push(
//         //   context,
//         //   MaterialPageRoute(builder: (_) => const LoanApplicationPage2()),
//         // );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               data['message'] ?? "Failed to submit loan application",
//             ),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("Error: $e"),
//           backgroundColor: Colors.red,
//         ),
//       );
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }
// }



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

  final String apiUrl = "http://127.0.0.1:8000/api/loan-applications";
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

  Future<void> _submitLoanApplication() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
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

      final data = jsonDecode(response.body);

      if (response.statusCode == 201 && data['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(data['message']),
              backgroundColor: Colors.green),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => LoanApplicationPage2(
              loanApplicationId: data['data']['id'],
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                data['message'] ?? "Failed to submit loan application"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Error: $e"), backgroundColor: Colors.red),
      );
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