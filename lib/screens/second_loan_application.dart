
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;
// import 'success_message.dart';

// class LoanApplicationPage2 extends StatefulWidget {
//   final int loanApplicationId;

//   const LoanApplicationPage2({super.key, required this.loanApplicationId});

//   @override
//   State<LoanApplicationPage2> createState() => _LoanApplicationPage2State();
// }

// class _LoanApplicationPage2State extends State<LoanApplicationPage2> {
//   final _formKey = GlobalKey<FormState>();

//   final TextEditingController kinNameController = TextEditingController();
//   final TextEditingController kinContactController = TextEditingController();
//   final TextEditingController incomeController = TextEditingController();
//   final TextEditingController addressController = TextEditingController();

//   String? selectedOccupation;
//   String? selectedLoanType;
//   String? selectedEducation;

//   XFile? nationalIdImage;
//   List<XFile> collateralImages = [];

//   final ImagePicker picker = ImagePicker();

//   Future<void> pickNationalIdImage() async {
//     final picked = await picker.pickImage(source: ImageSource.gallery);
//     if (picked != null) {
//       setState(() => nationalIdImage = picked);
//     }
//   }

//   Future<void> pickCollateralImages() async {
//     final pickedFiles = await picker.pickMultiImage();
//     if (pickedFiles.isNotEmpty) {
//       setState(() {
//         collateralImages = pickedFiles;
//       });
//     }
//   }

//   Future<void> submitApplication() async {
//     if (!_formKey.currentState!.validate()) return;

//     if (nationalIdImage == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please upload National ID")),
//       );
//       return;
//     }

//     try {
//       var uri = Uri.parse("http://10.0.2.2:8000/api/loan-application-details");
//       var request = http.MultipartRequest("POST", uri);

//       request.fields['loan_application_id'] =
//           widget.loanApplicationId.toString();
//       request.fields['kin_name'] = kinNameController.text;
//       request.fields['kin_contact'] = kinContactController.text;
//       request.fields['occupation'] = selectedOccupation!;
//       request.fields['monthly_income'] = incomeController.text;
//       request.fields['loan_type'] = selectedLoanType!;
//       request.fields['education'] = selectedEducation!;
//       request.fields['address'] = addressController.text;

//       // ===== NATIONAL ID IMAGE =====
//       if (kIsWeb) {
//         final bytes = await nationalIdImage!.readAsBytes();
//         request.files.add(
//           http.MultipartFile.fromBytes(
//             'national_id_image',
//             bytes,
//             filename: nationalIdImage!.name,
//           ),
//         );
//       } else {
//         request.files.add(
//           await http.MultipartFile.fromPath(
//             'national_id_image',
//             nationalIdImage!.path,
//           ),
//         );
//       }

//       // ===== COLLATERAL IMAGES =====
//       for (var image in collateralImages) {
//         if (kIsWeb) {
//           final bytes = await image.readAsBytes();
//           request.files.add(
//             http.MultipartFile.fromBytes(
//               'collateral_images[]',
//               bytes,
//               filename: image.name,
//             ),
//           );
//         } else {
//           request.files.add(
//             await http.MultipartFile.fromPath(
//               'collateral_images[]',
//               image.path,
//             ),
//           );
//         }
//       }

//       var response = await request.send();
//       var responseBody = await response.stream.bytesToString();

//       if (response.statusCode == 201) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => const ApplicationSuccessPage(),
//           ),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Error: $responseBody")),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Something went wrong: $e")),
//       );
//     }
//   }

//   Widget buildImagePreview(XFile image) {
//     if (kIsWeb) {
//       return Image.network(
//         image.path,
//         fit: BoxFit.cover,
//       );
//     } else {
//       return Image.asset(
//         image.path,
//         fit: BoxFit.cover,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;

//     Color background = isDark ? Colors.black : Colors.white;
//     Color textColor = isDark ? Colors.white : Colors.black;
//     Color subtitleColor = isDark ? Colors.white70 : Colors.black87;
//     Color fillColor = isDark ? Colors.grey[900]! : Colors.white;
//     Color containerColor = isDark ? Colors.grey[900]! : Colors.grey.shade100;

//     return Scaffold(
//       backgroundColor: background,
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF007BFF),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           "Basic Information",
//           style: TextStyle(color: Colors.white, fontSize: 20),
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [

//               Text(
//                 "Continue your loan application by submitting required details below.",
//                 style: const TextStyle(
//                   color: Colors.green,
//                   fontSize: 17,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               const SizedBox(height: 25),

//               _buildField("Next of Kin Name", kinNameController,
//                   fillColor: fillColor, textColor: textColor),
//               const SizedBox(height: 15),

//               _buildField(
//                 "Next of Kin Contact",
//                 kinContactController,
//                 keyboardType: TextInputType.phone,
//                 fillColor: fillColor,
//                 textColor: textColor,
//               ),
//               const SizedBox(height: 15),

//               _buildDropdown(
//                 label: "Occupation",
//                 value: selectedOccupation,
//                 items: [
//                   "Farmer",
//                   "Business Owner",
//                   "Teacher",
//                   "Engineer",
//                   "Driver",
//                   "Student",
//                   "Civil Servant",
//                   "Medical Worker",
//                   "Technician",
//                   "Other",
//                 ],
//                 onChanged: (v) => setState(() => selectedOccupation = v),
//                 fillColor: fillColor,
//                 textColor: textColor,
//                 isDark: isDark,
//               ),
//               const SizedBox(height: 15),

//               _buildField(
//                 "Monthly Income (UGX)",
//                 incomeController,
//                 keyboardType: TextInputType.number,
//                 fillColor: fillColor,
//                 textColor: textColor,
//               ),
//               const SizedBox(height: 15),

//               _buildDropdown(
//                 label: "Loan Type",
//                 value: selectedLoanType,
//                 items: [
//                   "Logbook Loan",
//                   "Business Loan",
//                   "Personal Loan",
//                   "Investment Loan",
//                   "Car Loan",
//                 ],
//                 onChanged: (v) => setState(() => selectedLoanType = v),
//                 fillColor: fillColor,
//                 textColor: textColor,
//                 isDark: isDark,
//               ),
//               const SizedBox(height: 15),

//               _buildDropdown(
//                 label: "Highest Education",
//                 value: selectedEducation,
//                 items: [
//                   "Primary",
//                   "Secondary",
//                   "Diploma",
//                   "Bachelor’s Degree",
//                   "Master’s Degree",
//                   "Doctorate",
//                   "Other",
//                 ],
//                 onChanged: (v) => setState(() => selectedEducation = v),
//                 fillColor: fillColor,
//                 textColor: textColor,
//                 isDark: isDark,
//               ),
//               const SizedBox(height: 15),

//               _buildField(
//                 "Current Address",
//                 addressController,
//                 fillColor: fillColor,
//                 textColor: textColor,
//               ),
//               const SizedBox(height: 20),

//               Text(
//                 "National ID",
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: textColor,
//                 ),
//               ),
//               const SizedBox(height: 8),

//               GestureDetector(
//                 onTap: pickNationalIdImage,
//                 child: Container(
//                   height: 150,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: containerColor,
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(color: Colors.blueAccent, width: 0.8),
//                   ),
//                   child: nationalIdImage == null
//                       ? Center(
//                           child: Text(
//                             "Tap to upload National ID",
//                             style: TextStyle(color: subtitleColor),
//                           ),
//                         )
//                       : buildImagePreview(nationalIdImage!),
//                 ),
//               ),
//               const SizedBox(height: 20),

//               Text(
//                 "Collateral (Upload one or more images)",
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: textColor,
//                 ),
//               ),
//               const SizedBox(height: 8),

//               GestureDetector(
//                 onTap: pickCollateralImages,
//                 child: Container(
//                   height: 150,
//                   decoration: BoxDecoration(
//                     color: containerColor,
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(color: Colors.blueAccent, width: 0.8),
//                   ),
//                   child: collateralImages.isEmpty
//                       ? Center(
//                           child: Text(
//                             "Tap to upload collateral images",
//                             style: TextStyle(color: subtitleColor),
//                           ),
//                         )
//                       : ListView(
//                           scrollDirection: Axis.horizontal,
//                           children: collateralImages
//                               .map(
//                                 (img) => Padding(
//                                   padding: const EdgeInsets.all(5),
//                                   child: SizedBox(
//                                     width: 120,
//                                     height: 120,
//                                     child: buildImagePreview(img),
//                                   ),
//                                 ),
//                               )
//                               .toList(),
//                         ),
//                 ),
//               ),
//               const SizedBox(height: 30),

//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: submitApplication,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green,
//                     padding: const EdgeInsets.symmetric(vertical: 14),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: const Text(
//                     "Submit Application",
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildField(
//     String label,
//     TextEditingController controller, {
//     TextInputType keyboardType = TextInputType.text,
//     required Color fillColor,
//     required Color textColor,
//   }) {
//     return TextFormField(
//       controller: controller,
//       keyboardType: keyboardType,
//       style: TextStyle(color: textColor),
//       validator: (val) =>
//           val == null || val.isEmpty ? "Please enter $label" : null,
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle: TextStyle(color: textColor),
//         filled: true,
//         fillColor: fillColor,
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(6),
//           borderSide: BorderSide(
//               color: textColor == Colors.white
//                   ? Colors.white12
//                   : Colors.black12,
//               width: 0.6),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(6),
//           borderSide:
//               const BorderSide(color: Colors.blueAccent, width: 0.8),
//         ),
//       ),
//     );
//   }

//   Widget _buildDropdown({
//     required String label,
//     required String? value,
//     required List<String> items,
//     required Function(String?) onChanged,
//     required Color fillColor,
//     required Color textColor,
//     required bool isDark,
//   }) {
//     return DropdownButtonFormField<String>(
//       value: value,
//       style: TextStyle(color: textColor),
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle: TextStyle(color: textColor),
//         filled: true,
//         fillColor: fillColor,
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(6),
//           borderSide: BorderSide(
//               color: isDark ? Colors.white12 : Colors.black12,
//               width: 0.6),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(6),
//           borderSide:
//               const BorderSide(color: Colors.blueAccent, width: 0.8),
//         ),
//       ),
//       items: items
//           .map(
//             (item) => DropdownMenuItem(
//               value: item,
//               child: Text(
//                 item,
//                 style: TextStyle(color: textColor),
//               ),
//             ),
//           )
//           .toList(),
//       onChanged: onChanged,
//       validator: (val) => val == null ? "Please select your $label" : null,
//     );
//   }
// }
























// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;
// // import 'dart:convert';
// import 'success_message.dart';

// class LoanApplicationPage2 extends StatefulWidget {
//   final int loanApplicationId; // pass this from page 1

//   const LoanApplicationPage2({super.key, required this.loanApplicationId});

//   @override
//   State<LoanApplicationPage2> createState() => _LoanApplicationPage2State();
// }

// class _LoanApplicationPage2State extends State<LoanApplicationPage2> {
//   final _formKey = GlobalKey<FormState>();

//   final TextEditingController kinNameController = TextEditingController();
//   final TextEditingController kinContactController = TextEditingController();
//   final TextEditingController incomeController = TextEditingController();
//   final TextEditingController addressController = TextEditingController();

//   String? selectedOccupation;
//   String? selectedLoanType;
//   String? selectedEducation;

//   File? nationalIdImage;
//   List<File> collateralImages = [];

//   final ImagePicker picker = ImagePicker();

//   Future<void> pickNationalIdImage() async {
//     final picked = await picker.pickImage(source: ImageSource.gallery);
//     if (picked != null) {
//       setState(() => nationalIdImage = File(picked.path));
//     }
//   }

//   Future<void> pickCollateralImages() async {
//     final pickedFiles = await picker.pickMultiImage();
//     if (pickedFiles.isNotEmpty) {
//       setState(() {
//         collateralImages = pickedFiles.map((e) => File(e.path)).toList();
//       });
//     }
//   }

//   // 🔵 SUBMIT TO BACKEND
//   Future<void> submitApplication() async {
//     if (!_formKey.currentState!.validate()) return;

//     if (nationalIdImage == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please upload National ID")),
//       );
//       return;
//     }

//     try {
//       var uri = Uri.parse("http://10.0.2.2:8000/api/loan-application-details");

//       var request = http.MultipartRequest("POST", uri);

//       request.fields['loan_application_id'] =
//           widget.loanApplicationId.toString();
//       request.fields['kin_name'] = kinNameController.text;
//       request.fields['kin_contact'] = kinContactController.text;
//       request.fields['occupation'] = selectedOccupation!;
//       request.fields['monthly_income'] = incomeController.text;
//       request.fields['loan_type'] = selectedLoanType!;
//       request.fields['education'] = selectedEducation!;
//       request.fields['address'] = addressController.text;

//       request.files.add(
//         await http.MultipartFile.fromPath(
//           'national_id_image',
//           nationalIdImage!.path,
//         ),
//       );

//       for (var image in collateralImages) {
//         request.files.add(
//           await http.MultipartFile.fromPath(
//             'collateral_images[]',
//             image.path,
//           ),
//         );
//       }

//       var response = await request.send();
//       var responseBody = await response.stream.bytesToString();

//       if (response.statusCode == 201) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => const ApplicationSuccessPage(),
//           ),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Error: $responseBody")),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Something went wrong: $e")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;

//     Color background = isDark ? Colors.black : Colors.white;
//     Color textColor = isDark ? Colors.white : Colors.black;
//     Color subtitleColor = isDark ? Colors.white70 : Colors.black87;
//     Color fillColor = isDark ? Colors.grey[900]! : Colors.white;
//     Color containerColor = isDark ? Colors.grey[900]! : Colors.grey.shade100;

//     return Scaffold(
//       backgroundColor: background,
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF007BFF),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           "Basic Information",
//           style: TextStyle(color: Colors.white, fontSize: 20),
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [

//               Text(
//                 "Continue your loan application by submitting required details below.",
//                 style: const TextStyle(
//                   color: Colors.green,
//                   fontSize: 17,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               const SizedBox(height: 25),

//               _buildField("Next of Kin Name", kinNameController,
//                   fillColor: fillColor, textColor: textColor),
//               const SizedBox(height: 15),

//               _buildField(
//                 "Next of Kin Contact",
//                 kinContactController,
//                 keyboardType: TextInputType.phone,
//                 fillColor: fillColor,
//                 textColor: textColor,
//               ),
//               const SizedBox(height: 15),

//               _buildDropdown(
//                 label: "Occupation",
//                 value: selectedOccupation,
//                 items: [
//                   "Farmer",
//                   "Business Owner",
//                   "Teacher",
//                   "Engineer",
//                   "Driver",
//                   "Student",
//                   "Civil Servant",
//                   "Medical Worker",
//                   "Technician",
//                   "Other",
//                 ],
//                 onChanged: (v) => setState(() => selectedOccupation = v),
//                 fillColor: fillColor,
//                 textColor: textColor,
//                 isDark: isDark,
//               ),
//               const SizedBox(height: 15),

//               _buildField(
//                 "Monthly Income (UGX)",
//                 incomeController,
//                 keyboardType: TextInputType.number,
//                 fillColor: fillColor,
//                 textColor: textColor,
//               ),
//               const SizedBox(height: 15),

//               _buildDropdown(
//                 label: "Loan Type",
//                 value: selectedLoanType,
//                 items: [
//                   "Logbook Loan",
//                   "Business Loan",
//                   "Personal Loan",
//                   "Investment Loan",
//                   "Car Loan",
//                 ],
//                 onChanged: (v) => setState(() => selectedLoanType = v),
//                 fillColor: fillColor,
//                 textColor: textColor,
//                 isDark: isDark,
//               ),
//               const SizedBox(height: 15),

//               _buildDropdown(
//                 label: "Highest Education",
//                 value: selectedEducation,
//                 items: [
//                   "Primary",
//                   "Secondary",
//                   "Diploma",
//                   "Bachelor’s Degree",
//                   "Master’s Degree",
//                   "Doctorate",
//                   "Other",
//                 ],
//                 onChanged: (v) => setState(() => selectedEducation = v),
//                 fillColor: fillColor,
//                 textColor: textColor,
//                 isDark: isDark,
//               ),
//               const SizedBox(height: 15),

//               _buildField(
//                 "Current Address",
//                 addressController,
//                 fillColor: fillColor,
//                 textColor: textColor,
//               ),
//               const SizedBox(height: 20),

//               Text(
//                 "National ID",
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: textColor,
//                 ),
//               ),
//               const SizedBox(height: 8),

//               GestureDetector(
//                 onTap: pickNationalIdImage,
//                 child: Container(
//                   height: 150,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: containerColor,
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(color: Colors.blueAccent, width: 0.8),
//                   ),
//                   child: nationalIdImage == null
//                       ? Center(
//                           child: Text(
//                             "Tap to upload National ID",
//                             style: TextStyle(color: subtitleColor),
//                           ),
//                         )
//                       : Image.file(nationalIdImage!, fit: BoxFit.cover),
//                 ),
//               ),
//               const SizedBox(height: 20),

//               Text(
//                 "Collateral (Upload one or more images)",
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: textColor,
//                 ),
//               ),
//               const SizedBox(height: 8),

//               GestureDetector(
//                 onTap: pickCollateralImages,
//                 child: Container(
//                   height: 150,
//                   decoration: BoxDecoration(
//                     color: containerColor,
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(color: Colors.blueAccent, width: 0.8),
//                   ),
//                   child: collateralImages.isEmpty
//                       ? Center(
//                           child: Text(
//                             "Tap to upload collateral images",
//                             style: TextStyle(color: subtitleColor),
//                           ),
//                         )
//                       : ListView(
//                           scrollDirection: Axis.horizontal,
//                           children: collateralImages
//                               .map(
//                                 (img) => Padding(
//                                   padding: const EdgeInsets.all(5),
//                                   child: Image.file(
//                                     img,
//                                     width: 120,
//                                     height: 120,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               )
//                               .toList(),
//                         ),
//                 ),
//               ),
//               const SizedBox(height: 30),

//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: submitApplication,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green,
//                     padding: const EdgeInsets.symmetric(vertical: 14),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: const Text(
//                     "Submit Application",
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildField(
//     String label,
//     TextEditingController controller, {
//     TextInputType keyboardType = TextInputType.text,
//     required Color fillColor,
//     required Color textColor,
//   }) {
//     return TextFormField(
//       controller: controller,
//       keyboardType: keyboardType,
//       style: TextStyle(color: textColor),
//       validator: (val) =>
//           val == null || val.isEmpty ? "Please enter $label" : null,
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle: TextStyle(color: textColor),
//         filled: true,
//         fillColor: fillColor,
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(6),
//           borderSide: BorderSide(
//               color: textColor == Colors.white
//                   ? Colors.white12
//                   : Colors.black12,
//               width: 0.6),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(6),
//           borderSide:
//               const BorderSide(color: Colors.blueAccent, width: 0.8),
//         ),
//       ),
//     );
//   }

//   Widget _buildDropdown({
//     required String label,
//     required String? value,
//     required List<String> items,
//     required Function(String?) onChanged,
//     required Color fillColor,
//     required Color textColor,
//     required bool isDark,
//   }) {
//     return DropdownButtonFormField<String>(
//       initialValue: value,
//       style: TextStyle(color: textColor),
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle: TextStyle(color: textColor),
//         filled: true,
//         fillColor: fillColor,
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(6),
//           borderSide: BorderSide(
//               color: isDark ? Colors.white12 : Colors.black12,
//               width: 0.6),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(6),
//           borderSide:
//               const BorderSide(color: Colors.blueAccent, width: 0.8),
//         ),
//       ),
//       items: items
//           .map(
//             (item) => DropdownMenuItem(
//               value: item,
//               child: Text(
//                 item,
//                 style: TextStyle(color: textColor),
//               ),
//             ),
//           )
//           .toList(),
//       onChanged: onChanged,
//       validator: (val) => val == null ? "Please select your $label" : null,
//     );
//   }
// }



import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'success_message.dart';

class LoanApplicationPage2 extends StatefulWidget {
  final int loanApplicationId;

  const LoanApplicationPage2({super.key, required this.loanApplicationId});

  @override
  State<LoanApplicationPage2> createState() => _LoanApplicationPage2State();
}

class _LoanApplicationPage2State extends State<LoanApplicationPage2> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController kinNameController = TextEditingController();
  final TextEditingController kinContactController = TextEditingController();
  final TextEditingController incomeController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  String? selectedOccupation;
  String? selectedLoanType;
  String? selectedEducation;

  XFile? nationalIdImage;
  List<XFile> collateralImages = [];

  final ImagePicker picker = ImagePicker();

  // ===== Updated Base URL =====
  String getBaseUrl() {
    if (kIsWeb) {
      return 'http://localhost:8000';
    } else {
      // Android emulator: 10.0.2.2
      // Physical device: replace with your PC local IP, e.g., 192.168.1.100
      return 'http://10.0.2.2:8000';
    }
  }

  Future<void> pickNationalIdImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => nationalIdImage = picked);
    }
  }

  Future<void> pickCollateralImages() async {
    final pickedFiles = await picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      setState(() {
        collateralImages = pickedFiles;
      });
    }
  }

  Future<void> submitApplication() async {
    if (!_formKey.currentState!.validate()) return;

    if (nationalIdImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please upload National ID")),
      );
      return;
    }

    try {
      var uri = Uri.parse("${getBaseUrl()}/api/loan-application-details");
      var request = http.MultipartRequest("POST", uri);

      request.fields['loan_application_id'] =
          widget.loanApplicationId.toString();
      request.fields['kin_name'] = kinNameController.text;
      request.fields['kin_contact'] = kinContactController.text;
      request.fields['occupation'] = selectedOccupation!;
      request.fields['monthly_income'] = incomeController.text;
      request.fields['loan_type'] = selectedLoanType!;
      request.fields['education'] = selectedEducation!;
      request.fields['address'] = addressController.text;

      // ===== NATIONAL ID IMAGE =====
      if (kIsWeb) {
        final bytes = await nationalIdImage!.readAsBytes();
        request.files.add(
          http.MultipartFile.fromBytes(
            'national_id_image',
            bytes,
            filename: nationalIdImage!.name,
          ),
        );
      } else {
        request.files.add(
          await http.MultipartFile.fromPath(
            'national_id_image',
            nationalIdImage!.path,
          ),
        );
      }

      // ===== COLLATERAL IMAGES =====
      for (var image in collateralImages) {
        if (kIsWeb) {
          final bytes = await image.readAsBytes();
          request.files.add(
            http.MultipartFile.fromBytes(
              'collateral_images[]',
              bytes,
              filename: image.name,
            ),
          );
        } else {
          request.files.add(
            await http.MultipartFile.fromPath(
              'collateral_images[]',
              image.path,
            ),
          );
        }
      }

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 201) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const ApplicationSuccessPage(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $responseBody")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Something went wrong: $e")),
      );
    }
  }

  Widget buildImagePreview(XFile image) {
    if (kIsWeb) {
      return Image.network(
        image.path,
        fit: BoxFit.cover,
      );
    } else {
      return Image.file(
        File(image.path),
        fit: BoxFit.cover,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Color background = isDark ? Colors.black : Colors.white;
    Color textColor = isDark ? Colors.white : Colors.black;
    Color subtitleColor = isDark ? Colors.white70 : Colors.black87;
    Color fillColor = isDark ? Colors.grey[900]! : Colors.white;
    Color containerColor = isDark ? Colors.grey[900]! : Colors.grey.shade100;

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: const Color(0xFF007BFF),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Basic Information",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                "Continue your loan application by submitting required details below.",
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 25),

              _buildField("Next of Kin Name", kinNameController,
                  fillColor: fillColor, textColor: textColor),
              const SizedBox(height: 15),

              _buildField(
                "Next of Kin Contact",
                kinContactController,
                keyboardType: TextInputType.phone,
                fillColor: fillColor,
                textColor: textColor,
              ),
              const SizedBox(height: 15),

              _buildDropdown(
                label: "Your Occupation",
                value: selectedOccupation,
                items: [
                  "Farmer",
                  "Business Owner",
                  "Teacher",
                  "Engineer",
                  "Driver",
                  "Student",
                  "Civil Servant",
                  "Medical Worker",
                  "Technician",
                  "Other",
                ],
                onChanged: (v) => setState(() => selectedOccupation = v),
                fillColor: fillColor,
                textColor: textColor,
                isDark: isDark,
              ),
              const SizedBox(height: 15),

              _buildField(
                "Your Monthly Income (UGX)",
                incomeController,
                keyboardType: TextInputType.number,
                fillColor: fillColor,
                textColor: textColor,
              ),
              const SizedBox(height: 15),

              _buildDropdown(
                label: "Loan Type",
                value: selectedLoanType,
                items: [
                  "Logbook Loan",
                  "Business Loan",
                  "Personal Loan",
                  "Investment Loan",
                  "Car Loan",
                ],
                onChanged: (v) => setState(() => selectedLoanType = v),
                fillColor: fillColor,
                textColor: textColor,
                isDark: isDark,
              ),
              const SizedBox(height: 15),

              _buildDropdown(
                label: "Your Highest Education",
                value: selectedEducation,
                items: [
                  "Primary",
                  "Secondary",
                  "Diploma",
                  "Bachelor’s Degree",
                  "Master’s Degree",
                  "Doctorate",
                  "Other",
                ],
                onChanged: (v) => setState(() => selectedEducation = v),
                fillColor: fillColor,
                textColor: textColor,
                isDark: isDark,
              ),
              const SizedBox(height: 15),

              _buildField(
                "Your Current Address",
                addressController,
                fillColor: fillColor,
                textColor: textColor,
              ),
              const SizedBox(height: 20),

              Text(
                "National ID",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 8),

              GestureDetector(
                onTap: pickNationalIdImage,
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: containerColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blueAccent, width: 0.8),
                  ),
                  child: nationalIdImage == null
                      ? Center(
                          child: Text(
                            "Tap to upload National ID",
                            style: TextStyle(color: subtitleColor),
                          ),
                        )
                      : buildImagePreview(nationalIdImage!),
                ),
              ),
              const SizedBox(height: 20),

              Text(
                "Collateral (Upload one or more images)",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 8),

              GestureDetector(
                onTap: pickCollateralImages,
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: containerColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blueAccent, width: 0.8),
                  ),
                  child: collateralImages.isEmpty
                      ? Center(
                          child: Text(
                            "Tap to upload collateral images",
                            style: TextStyle(color: subtitleColor),
                          ),
                        )
                      : ListView(
                          scrollDirection: Axis.horizontal,
                          children: collateralImages
                              .map(
                                (img) => Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: SizedBox(
                                    width: 120,
                                    height: 120,
                                    child: buildImagePreview(img),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                ),
              ),
              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: submitApplication,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Submit Application",
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
    );
  }

  Widget _buildField(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
    required Color fillColor,
    required Color textColor,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(color: textColor),
      validator: (val) =>
          val == null || val.isEmpty ? "Please enter $label" : null,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: textColor),
        filled: true,
        fillColor: fillColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
              color: textColor == Colors.white
                  ? Colors.white12
                  : Colors.black12,
              width: 0.6),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide:
              const BorderSide(color: Colors.blueAccent, width: 0.8),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
    required Color fillColor,
    required Color textColor,
    required bool isDark,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      style: TextStyle(color: textColor),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: textColor),
        filled: true,
        fillColor: fillColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
              color: isDark ? Colors.white12 : Colors.black12,
              width: 0.6),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide:
              const BorderSide(color: Colors.blueAccent, width: 0.8),
        ),
      ),
      items: items
          .map(
            (item) => DropdownMenuItem(
              value: item,
              child: Text(
                item,
                style: TextStyle(color: textColor),
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
      validator: (val) => val == null ? "Please select your $label" : null,
    );
  }
}






















// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
// import 'success_message.dart';

// class LoanApplicationPage2 extends StatefulWidget {
//   const LoanApplicationPage2({super.key});

//   @override
//   State<LoanApplicationPage2> createState() => _LoanApplicationPage2State();
// }

// class _LoanApplicationPage2State extends State<LoanApplicationPage2> {
//   final _formKey = GlobalKey<FormState>();

//   // Controllers
//   final TextEditingController kinNameController = TextEditingController();
//   final TextEditingController kinContactController = TextEditingController();
//   final TextEditingController incomeController = TextEditingController();
//   final TextEditingController addressController = TextEditingController();

//   String? selectedOccupation;
//   String? selectedLoanType;
//   String? selectedEducation;

//   File? nationalIdImage;
//   List<File> collateralImages = [];

//   final ImagePicker picker = ImagePicker();

//   Future<void> pickNationalIdImage() async {
//     final picked = await picker.pickImage(source: ImageSource.gallery);
//     if (picked != null) {
//       setState(() => nationalIdImage = File(picked.path));
//     }
//   }

//   Future<void> pickCollateralImages() async {
//     final pickedFiles = await picker.pickMultiImage();
//     if (pickedFiles.isNotEmpty) {
//       setState(() {
//         collateralImages = pickedFiles.map((e) => File(e.path)).toList();
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;

//     // Dark mode colors
//     Color background = isDark ? Colors.black : Colors.white;
//     Color textColor = isDark ? Colors.white : Colors.black;
//     Color subtitleColor = isDark ? Colors.white70 : Colors.black87;
//     Color fillColor = isDark ? Colors.grey[900]! : Colors.white;
//     Color containerColor = isDark ? Colors.grey[900]! : Colors.grey.shade100;

//     return Scaffold(
//       backgroundColor: background,

//       appBar: AppBar(
//         backgroundColor: const Color(0xFF007BFF),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           "Basic Information",
//           style: TextStyle(color: Colors.white, fontSize: 20),
//         ),
//         centerTitle: true,
//       ),

//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [

//               Text(
//                 "Continue your loan application by submitting required details below.",
//                 style: TextStyle(
//                   color: Colors.green,
//                   fontSize: 17,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               const SizedBox(height: 25),

//               _buildField("Next of Kin Name", kinNameController,
//                   fillColor: fillColor, textColor: textColor),
//               const SizedBox(height: 15),

//               _buildField(
//                 "Next of Kin Contact",
//                 kinContactController,
//                 keyboardType: TextInputType.phone,
//                 fillColor: fillColor,
//                 textColor: textColor,
//               ),
//               const SizedBox(height: 15),

//               _buildDropdown(
//                 label: "Occupation",
//                 value: selectedOccupation,
//                 items: [
//                   "Farmer",
//                   "Business Owner",
//                   "Teacher",
//                   "Engineer",
//                   "Driver",
//                   "Student",
//                   "Civil Servant",
//                   "Medical Worker",
//                   "Technician",
//                   "Other",
//                 ],
//                 onChanged: (v) => setState(() => selectedOccupation = v),
//                 fillColor: fillColor,
//                 textColor: textColor,
//                 isDark: isDark,
//               ),
//               const SizedBox(height: 15),

//               _buildField(
//                 "Monthly Income (UGX)",
//                 incomeController,
//                 keyboardType: TextInputType.number,
//                 fillColor: fillColor,
//                 textColor: textColor,
//               ),
//               const SizedBox(height: 15),

//               _buildDropdown(
//                 label: "Loan Type",
//                 value: selectedLoanType,
//                 items: [
//                   "Logbook Loan",
//                   "Business Loan",
//                   "Personal Loan",
//                   "Investment Loan",
//                   "Car Loan",
//                 ],
//                 onChanged: (v) => setState(() => selectedLoanType = v),
//                 fillColor: fillColor,
//                 textColor: textColor,
//                 isDark: isDark,
//               ),
//               const SizedBox(height: 15),

//               _buildDropdown(
//                 label: "Highest Education",
//                 value: selectedEducation,
//                 items: [
//                   "Primary",
//                   "Secondary",
//                   "Diploma",
//                   "Bachelor’s Degree",
//                   "Master’s Degree",
//                   "Doctorate",
//                   "Other",
//                 ],
//                 onChanged: (v) => setState(() => selectedEducation = v),
//                 fillColor: fillColor,
//                 textColor: textColor,
//                 isDark: isDark,
//               ),
//               const SizedBox(height: 15),

//               _buildField(
//                 "Current Address",
//                 addressController,
//                 fillColor: fillColor,
//                 textColor: textColor,
//               ),
//               const SizedBox(height: 20),

//               Text(
//                 "National ID",
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: textColor,
//                 ),
//               ),
//               const SizedBox(height: 8),

//               GestureDetector(
//                 onTap: pickNationalIdImage,
//                 child: Container(
//                   height: 150,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: containerColor,
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(color: Colors.blueAccent, width: 0.8),
//                   ),
//                   child: nationalIdImage == null
//                       ? Center(
//                           child: Text(
//                             "Tap to upload National ID",
//                             style: TextStyle(color: subtitleColor),
//                           ),
//                         )
//                       : Image.file(nationalIdImage!, fit: BoxFit.cover),
//                 ),
//               ),
//               const SizedBox(height: 20),

//               Text(
//                 "Collateral (Upload one or more images)",
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: textColor,
//                 ),
//               ),
//               const SizedBox(height: 8),

//               GestureDetector(
//                 onTap: pickCollateralImages,
//                 child: Container(
//                   height: 150,
//                   decoration: BoxDecoration(
//                     color: containerColor,
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(color: Colors.blueAccent, width: 0.8),
//                   ),
//                   child: collateralImages.isEmpty
//                       ? Center(
//                           child: Text(
//                             "Tap to upload collateral images",
//                             style: TextStyle(color: subtitleColor),
//                           ),
//                         )
//                       : ListView(
//                           scrollDirection: Axis.horizontal,
//                           children: collateralImages
//                               .map(
//                                 (img) => Padding(
//                                   padding: const EdgeInsets.all(5),
//                                   child: Image.file(
//                                     img,
//                                     width: 120,
//                                     height: 120,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               )
//                               .toList(),
//                         ),
//                 ),
//               ),
//               const SizedBox(height: 30),

//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               const ApplicationSuccessPage(),
//                         ),
//                       );
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green,
//                     padding: const EdgeInsets.symmetric(vertical: 14),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: const Text(
//                     "Submit Application",
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // TextField with thin border
//   Widget _buildField(
//     String label,
//     TextEditingController controller, {
//     TextInputType keyboardType = TextInputType.text,
//     required Color fillColor,
//     required Color textColor,
//   }) {
//     return TextFormField(
//       controller: controller,
//       keyboardType: keyboardType,
//       style: TextStyle(color: textColor),
//       validator: (val) =>
//           val == null || val.isEmpty ? "Please enter $label" : null,
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle: TextStyle(color: textColor),
//         filled: true,
//         fillColor: fillColor,
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(6),
//           borderSide: BorderSide(
//               color: textColor == Colors.white ? Colors.white12 : Colors.black12,
//               width: 0.6),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(6),
//           borderSide: const BorderSide(color: Colors.blueAccent, width: 0.8),
//         ),
//       ),
//     );
//   }

//   // Dropdown with thin border
//   Widget _buildDropdown({
//     required String label,
//     required String? value,
//     required List<String> items,
//     required Function(String?) onChanged,
//     required Color fillColor,
//     required Color textColor,
//     required bool isDark,
//   }) {
//     return DropdownButtonFormField<String>(
//       initialValue: value,
//       style: TextStyle(color: textColor),
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle: TextStyle(color: textColor),
//         filled: true,
//         fillColor: fillColor,
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(6),
//           borderSide: BorderSide(
//               color: isDark ? Colors.white12 : Colors.black12,
//               width: 0.6),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(6),
//           borderSide: const BorderSide(color: Colors.blueAccent, width: 0.8),
//         ),
//       ),
//       items: items
//           .map(
//             (item) => DropdownMenuItem(
//               value: item,
//               child: Text(
//                 item,
//                 style: TextStyle(color: textColor),
//               ),
//             ),
//           )
//           .toList(),
//       onChanged: onChanged,
//       validator: (val) => val == null ? "Please select your $label" : null,
//     );
//   }
// }















// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
// import 'success_message.dart';
// class LoanApplicationPage2 extends StatefulWidget {
//   const LoanApplicationPage2({super.key});

//   @override
//   State<LoanApplicationPage2> createState() => _LoanApplicationPage2State();
// }

// class _LoanApplicationPage2State extends State<LoanApplicationPage2> {
//   final _formKey = GlobalKey<FormState>();

//   // Controllers
//   final TextEditingController kinNameController = TextEditingController();
//   final TextEditingController kinContactController = TextEditingController();
//   final TextEditingController incomeController = TextEditingController();
//   final TextEditingController addressController = TextEditingController();

//   String? selectedOccupation;
//   String? selectedLoanType;
//   String? selectedEducation;

//   File? nationalIdImage;
//   List<File> collateralImages = [];

//   final ImagePicker picker = ImagePicker();

//   Future<void> pickNationalIdImage() async {
//     final picked = await picker.pickImage(source: ImageSource.gallery);
//     if (picked != null) {
//       setState(() => nationalIdImage = File(picked.path));
//     }
//   }

//   Future<void> pickCollateralImages() async {
//     final pickedFiles = await picker.pickMultiImage();
//     if (pickedFiles.isNotEmpty) {
//       setState(() {
//         collateralImages = pickedFiles.map((e) => File(e.path)).toList();
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,

//       appBar: AppBar(
//         backgroundColor: const Color(0xFF007BFF),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           "Basic Information",
//           style: TextStyle(color: Colors.white, fontSize: 20),
//         ),
//         centerTitle: true,
//       ),

//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [

//               const Text(
//                 "Continue your loan application by submitting required details below.",
//                 style: TextStyle(
//                   color: Colors.green,
//                   fontSize: 17,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               const SizedBox(height: 25),

//               _buildField("Next of Kin Name", kinNameController),
//               const SizedBox(height: 15),

//               _buildField(
//                 "Next of Kin Contact",
//                 kinContactController,
//                 keyboardType: TextInputType.phone,
//               ),
//               const SizedBox(height: 15),

//               _buildDropdown(
//                 label: "Occupation",
//                 value: selectedOccupation,
//                 items: [
//                   "Farmer",
//                   "Business Owner",
//                   "Teacher",
//                   "Engineer",
//                   "Driver",
//                   "Student",
//                   "Civil Servant",
//                   "Medical Worker",
//                   "Technician",
//                   "Other",
//                 ],
//                 onChanged: (v) => setState(() => selectedOccupation = v),
//               ),
//               const SizedBox(height: 15),

//               _buildField(
//                 "Monthly Income (UGX)",
//                 incomeController,
//                 keyboardType: TextInputType.number,
//               ),
//               const SizedBox(height: 15),

//               _buildDropdown(
//                 label: "Loan Type",
//                 value: selectedLoanType,
//                 items: [
//                   "Logbook Loan",
//                   "Business Loan",
//                   "Personal Loan",
//                   "Investment Loan",
//                   "Car Loan",
//                 ],
//                 onChanged: (v) => setState(() => selectedLoanType = v),
//               ),
//               const SizedBox(height: 15),

//               _buildDropdown(
//                 label: "Highest Education",
//                 value: selectedEducation,
//                 items: [
//                   "Primary",
//                   "Secondary",
//                   "Diploma",
//                   "Bachelor’s Degree",
//                   "Master’s Degree",
//                   "Doctorate",
//                   "Other",
//                 ],
//                 onChanged: (v) => setState(() => selectedEducation = v),
//               ),
//               const SizedBox(height: 15),

//               _buildField("Current Address", addressController),
//               const SizedBox(height: 20),

//               const Text(
//                 "National ID",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 8),

//               GestureDetector(
//                 onTap: pickNationalIdImage,
//                 child: Container(
//                   height: 150,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade100,
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(color: Colors.blueAccent, width: 0.8),
//                   ),
//                   child: nationalIdImage == null
//                       ? const Center(
//                           child: Text(
//                             "Tap to upload National ID",
//                             style: TextStyle(color: Colors.grey),
//                           ),
//                         )
//                       : Image.file(nationalIdImage!, fit: BoxFit.cover),
//                 ),
//               ),
//               const SizedBox(height: 20),

//               const Text(
//                 "Collateral (Upload one or more images)",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 8),

//               GestureDetector(
//                 onTap: pickCollateralImages,
//                 child: Container(
//                   height: 150,
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade100,
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(color: Colors.blueAccent, width: 0.8),
//                   ),
//                   child: collateralImages.isEmpty
//                       ? const Center(
//                           child: Text(
//                             "Tap to upload collateral images",
//                             style: TextStyle(color: Colors.grey),
//                           ),
//                         )
//                       : ListView(
//                           scrollDirection: Axis.horizontal,
//                           children: collateralImages
//                               .map(
//                                 (img) => Padding(
//                                   padding: const EdgeInsets.all(5),
//                                   child: Image.file(
//                                     img,
//                                     width: 120,
//                                     height: 120,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               )
//                               .toList(),
//                         ),
//                 ),
//               ),
//               const SizedBox(height: 30),

//               // ✅ UPDATED SUBMIT BUTTON
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               const ApplicationSuccessPage(),
//                         ),
//                       );
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green,
//                     padding: const EdgeInsets.symmetric(vertical: 14),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: const Text(
//                     "Submit Application",
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // TextField with thin border
//   Widget _buildField(
//     String label,
//     TextEditingController controller, {
//     TextInputType keyboardType = TextInputType.text,
//   }) {
//     return TextFormField(
//       controller: controller,
//       keyboardType: keyboardType,
//       validator: (val) =>
//           val == null || val.isEmpty ? "Please enter $label" : null,
//       decoration: InputDecoration(
//         labelText: label,
//         filled: true,
//         fillColor: Colors.white,
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(6),
//           borderSide: const BorderSide(color: Colors.black12, width: 0.6),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(6),
//           borderSide: const BorderSide(color: Colors.blueAccent, width: 0.8),
//         ),
//       ),
//     );
//   }

//   // Dropdown with thin border
//   Widget _buildDropdown({
//     required String label,
//     required String? value,
//     required List<String> items,
//     required Function(String?) onChanged,
//   }) {
//     return DropdownButtonFormField<String>(
//       value: value,
//       decoration: InputDecoration(
//         labelText: label,
//         filled: true,
//         fillColor: Colors.white,
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(6),
//           borderSide: const BorderSide(color: Colors.black12, width: 0.6),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(6),
//           borderSide: const BorderSide(color: Colors.blueAccent, width: 0.8),
//         ),
//       ),
//       items: items
//           .map(
//             (item) => DropdownMenuItem(value: item, child: Text(item)),
//           )
//           .toList(),
//       onChanged: onChanged,
//       validator: (val) =>
//           val == null ? "Please select your $label" : null,
//     );
//   }
// }


