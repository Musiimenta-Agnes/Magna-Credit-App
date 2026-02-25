

// import 'dart:io';

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

//   // ===== Updated Base URL =====
//   String getBaseUrl() {
//     if (kIsWeb) {
//       return 'http://localhost:8000';
//     } else {
//       // Android emulator: 10.0.2.2
//       // Physical device: replace with your PC local IP, e.g., 192.168.1.100
//       return 'http://10.0.2.2:8000';
//     }
//   }

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
//       var uri = Uri.parse("${getBaseUrl()}/api/loan-application-details");
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
//       return Image.file(
//         File(image.path),
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
//                 label: "Your Occupation",
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
//                 "Your Monthly Income (UGX)",
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
//                 label: "Your Highest Education",
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
//                 "Your Current Address",
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
  bool _isSubmitting = false;

  final ImagePicker picker = ImagePicker();

  static const Color _blue = Color(0xFF007BFF);
  static const Color _green = Colors.green;

  String getBaseUrl() {
    if (kIsWeb) return 'http://localhost:8000';
    return 'http://10.0.2.2:8000';
  }

  Future<void> pickNationalIdImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => nationalIdImage = picked);
  }

  Future<void> pickCollateralImages() async {
    final pickedFiles = await picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      setState(() => collateralImages = pickedFiles);
    }
  }

  Widget buildImagePreview(XFile image) {
    if (kIsWeb) {
      return Image.network(image.path, fit: BoxFit.cover);
    } else {
      return Image.file(File(image.path), fit: BoxFit.cover);
    }
  }

  Future<void> submitApplication() async {
    if (!_formKey.currentState!.validate()) return;

    if (nationalIdImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please upload your National ID"),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      var uri =
          Uri.parse("${getBaseUrl()}/api/loan-application-details");
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

      if (kIsWeb) {
        final bytes = await nationalIdImage!.readAsBytes();
        request.files.add(http.MultipartFile.fromBytes(
          'national_id_image', bytes,
          filename: nationalIdImage!.name,
        ));
      } else {
        request.files.add(await http.MultipartFile.fromPath(
          'national_id_image', nationalIdImage!.path,
        ));
      }

      for (var image in collateralImages) {
        if (kIsWeb) {
          final bytes = await image.readAsBytes();
          request.files.add(http.MultipartFile.fromBytes(
            'collateral_images[]', bytes,
            filename: image.name,
          ));
        } else {
          request.files.add(await http.MultipartFile.fromPath(
            'collateral_images[]', image.path,
          ));
        }
      }

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 201) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => const ApplicationSuccessPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: $responseBody"),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Something went wrong: $e"),
          backgroundColor: Colors.redAccent,
        ),
      );
    } finally {
      setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : const Color(0xFFF5F8FA),

      appBar: AppBar(
        backgroundColor: _blue,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
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

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(18, 24, 18, 30),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ── Step indicator ──
              _StepIndicator(currentStep: 2),

              const SizedBox(height: 22),

              // ── Employment & Loan Details ──
              _FormCard(
                isDark: isDark,
                title: "Employment & Loan Details",
                icon: Icons.work_rounded,
                subtitle:
                    "Help us understand your financial background.",
                children: [
                  _buildField(
                    kinNameController, "Next of Kin Name",
                    icon: Icons.people_rounded, isDark: isDark,
                  ),
                  _buildField(
                    kinContactController, "Next of Kin Contact",
                    icon: Icons.contact_phone_rounded, isDark: isDark,
                    keyboardType: TextInputType.phone,
                  ),
                  _buildDropdown(
                    label: "Occupation",
                    value: selectedOccupation,
                    items: [
                      "Farmer", "Business Owner", "Teacher", "Engineer",
                      "Driver", "Student", "Civil Servant",
                      "Medical Worker", "Technician", "Other",
                    ],
                    icon: Icons.work_outline_rounded,
                    isDark: isDark,
                    onChanged: (v) => setState(() => selectedOccupation = v),
                  ),
                  _buildField(
                    incomeController, "Monthly Income (UGX)",
                    icon: Icons.account_balance_wallet_rounded,
                    isDark: isDark,
                    keyboardType: TextInputType.number,
                  ),
                  _buildDropdown(
                    label: "Loan Type",
                    value: selectedLoanType,
                    items: [
                      "Logbook Loan", "Business Loan", "Personal Loan",
                      "Investment Loan", "Car Loan",
                    ],
                    icon: Icons.monetization_on_rounded,
                    isDark: isDark,
                    onChanged: (v) => setState(() => selectedLoanType = v),
                  ),
                  _buildDropdown(
                    label: "Highest Education",
                    value: selectedEducation,
                    items: [
                      "Primary", "Secondary", "Diploma",
                      "Bachelor's Degree", "Master's Degree",
                      "Doctorate", "Other",
                    ],
                    icon: Icons.school_rounded,
                    isDark: isDark,
                    onChanged: (v) => setState(() => selectedEducation = v),
                  ),
                  _buildField(
                    addressController, "Current Address",
                    icon: Icons.home_rounded, isDark: isDark,
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // ── Documents card ──
              _FormCard(
                isDark: isDark,
                title: "Documents",
                icon: Icons.upload_file_rounded,
                subtitle:
                    "Upload required documents for verification.",
                children: [

                  // National ID
                  _DocumentLabel(
                    label: "National ID",
                    icon: Icons.badge_rounded,
                    isDark: isDark,
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: pickNationalIdImage,
                    child: _UploadBox(
                      isDark: isDark,
                      isEmpty: nationalIdImage == null,
                      emptyLabel: "Tap to upload National ID",
                      emptyIcon: Icons.badge_rounded,
                      child: nationalIdImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: buildImagePreview(nationalIdImage!),
                            )
                          : null,
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Collateral
                  _DocumentLabel(
                    label: "Collateral Images",
                    icon: Icons.collections_rounded,
                    isDark: isDark,
                    badge: collateralImages.isNotEmpty
                        ? "${collateralImages.length} uploaded"
                        : null,
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: pickCollateralImages,
                    child: _UploadBox(
                      isDark: isDark,
                      isEmpty: collateralImages.isEmpty,
                      emptyLabel: "Tap to upload collateral images",
                      emptyIcon: Icons.add_photo_alternate_rounded,
                      child: collateralImages.isNotEmpty
                          ? ListView(
                              scrollDirection: Axis.horizontal,
                              children: collateralImages
                                  .map((img) => Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: SizedBox(
                                            width: 110,
                                            height: 110,
                                            child: buildImagePreview(img),
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            )
                          : null,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // ── Submit button ──
              GestureDetector(
                onTap: _isSubmitting ? null : submitApplication,
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
                  child: _isSubmitting
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
                            Icon(Icons.check_circle_rounded,
                                color: Colors.white, size: 20),
                            SizedBox(width: 10),
                            Text(
                              "Submit Application",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.4,
                              ),
                            ),
                          ],
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
      prefixIcon: Icon(icon, color: _blue, size: 18),
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
    );
  }
}

// ── Document section label ──
class _DocumentLabel extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isDark;
  final String? badge;

  const _DocumentLabel({
    required this.label,
    required this.icon,
    required this.isDark,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF007BFF), size: 16),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white70 : Colors.black87,
          ),
        ),
        if (badge != null) ...[
          const SizedBox(width: 8),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              badge!,
              style: const TextStyle(
                color: Colors.green,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

// ── Upload box ──
class _UploadBox extends StatelessWidget {
  final bool isDark;
  final bool isEmpty;
  final String emptyLabel;
  final IconData emptyIcon;
  final Widget? child;

  const _UploadBox({
    required this.isDark,
    required this.isEmpty,
    required this.emptyLabel,
    required this.emptyIcon,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[850] : const Color(0xFFF5F8FF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isEmpty
              ? const Color(0xFFD0E4FF)
              : Colors.green.withOpacity(0.4),
          width: 1.5,
        ),
      ),
      child: isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF007BFF).withOpacity(0.08),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(emptyIcon,
                      color: const Color(0xFF007BFF), size: 24),
                ),
                const SizedBox(height: 8),
                Text(
                  emptyLabel,
                  style: TextStyle(
                    color: isDark ? Colors.white38 : Colors.black38,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Tap to browse",
                  style: TextStyle(
                    color: const Color(0xFF007BFF).withOpacity(0.7),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            )
          : child!,
    );
  }
}

// ── Step indicator (shared with page 1) ──
class _StepIndicator extends StatelessWidget {
  final int currentStep;

  const _StepIndicator({required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _Step(
            number: 1,
            label: "Personal",
            isActive: currentStep >= 1,
            isDone: currentStep > 1),
        _StepLine(isActive: currentStep > 1),
        _Step(
            number: 2,
            label: "Details",
            isActive: currentStep >= 2,
            isDone: currentStep > 2),
        _StepLine(isActive: currentStep > 2),
        _Step(
            number: 3,
            label: "Submit",
            isActive: currentStep >= 3,
            isDone: false),
      ],
    );
  }
}

class _Step extends StatelessWidget {
  final int number;
  final String label;
  final bool isActive;
  final bool isDone;

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
            color: isActive ? const Color(0xFF007BFF) : Colors.grey.shade200,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: isDone
                ? const Icon(Icons.check_rounded,
                    color: Colors.white, size: 16)
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
            color: isActive ? const Color(0xFF007BFF) : Colors.grey,
            fontWeight:
                isActive ? FontWeight.w600 : FontWeight.normal,
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
        margin:
            const EdgeInsets.only(bottom: 16, left: 4, right: 4),
        decoration: BoxDecoration(
          color: isActive
              ? const Color(0xFF007BFF)
              : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}

// ── Form card ──
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
          const SizedBox(height: 5),
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