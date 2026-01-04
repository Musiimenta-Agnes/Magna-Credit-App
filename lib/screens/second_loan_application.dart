
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

// import 'package:image_picker/image_picker.dart';

class LoanApplicationPage2 extends StatefulWidget {
  const LoanApplicationPage2({super.key});

  @override
  State<LoanApplicationPage2> createState() => _LoanApplicationPage2State();
}

class _LoanApplicationPage2State extends State<LoanApplicationPage2> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController kinNameController = TextEditingController();
  final TextEditingController kinContactController = TextEditingController();
  final TextEditingController incomeController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  String? selectedOccupation;
  String? selectedLoanType;
  String? selectedEducation;

  File? nationalIdImage;
  List<File> collateralImages = [];

  final ImagePicker picker = ImagePicker();

  // Pick National ID
  Future<void> pickNationalIdImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => nationalIdImage = File(picked.path));
    }
  }

  // Pick Collateral Images
  Future<void> pickCollateralImages() async {
    final pickedFiles = await picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      setState(() {
        collateralImages = pickedFiles.map((e) => File(e.path)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Color(0xFF007BFF),
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
              
              const Text(
                "Continue your loan application by submitting required details below.",
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 25),

              // Next of kin
              _buildField("Next of Kin Name", kinNameController),
              const SizedBox(height: 15),

              _buildField(
                "Next of Kin Contact",
                kinContactController,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 15),

              // Occupation
              _buildDropdown(
                label: "Occupation",
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
              ),
              const SizedBox(height: 15),

              // Income
              _buildField(
                "Monthly Income (UGX)",
                incomeController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 15),

              // Loan type
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
              ),
              const SizedBox(height: 15),

              // Education Level
              _buildDropdown(
                label: "Highest Education",
                value: selectedEducation,
                items: [
                  "Primary",
                  "Secondary",
                  "Diploma",
                  "Bachelor’s Degree",
                  "Master’s Degree",
                  "Doctorate",
                  "Other"
                ],
                onChanged: (v) => setState(() => selectedEducation = v),
              ),
              const SizedBox(height: 15),

              // Address
              _buildField("Current Address", addressController),
              const SizedBox(height: 20),

              // National ID Upload
              const Text(
                "National ID",
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              GestureDetector(
                onTap: pickNationalIdImage,
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blueAccent),
                  ),
                  child: nationalIdImage == null
                      ? const Center(
                          child: Text(
                            "Tap to upload National ID",
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      : Image.file(nationalIdImage!, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 20),

              // Collateral Images
              const Text(
                "Collateral (Upload one or more images)",
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              GestureDetector(
                onTap: pickCollateralImages,
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blueAccent),
                  ),
                  child: collateralImages.isEmpty
                      ? const Center(
                          child: Text(
                            "Tap to upload collateral images",
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      : ListView(
                          scrollDirection: Axis.horizontal,
                          children: collateralImages
                              .map(
                                (img) => Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Image.file(
                                    img,
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                ),
              ),
              const SizedBox(height: 30),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Loan Application Submitted Successfully!"),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
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
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // TextField
  Widget _buildField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: (val) =>
          val == null || val.isEmpty ? "Please enter $label" : null,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Colors.black12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Colors.blueAccent),
        ),
      ),
    );
  }

  // Dropdown
  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      items: items
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      onChanged: onChanged,
      validator: (val) =>
          val == null ? "Please select your $label" : null,
    );
  }
}
















// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';

// class LoanApplicationPage2 extends StatefulWidget {
//   const LoanApplicationPage2({super.key});

//   @override
//   State<LoanApplicationPage2> createState() => _LoanApplicationPage2State();
// }

// class _LoanApplicationPage2State extends State<LoanApplicationPage2> {
//   final _formKey = GlobalKey<FormState>();

//   // 🔹 Text Controllers
//   final TextEditingController kinNameController = TextEditingController();
//   final TextEditingController kinContactController = TextEditingController();
//   final TextEditingController incomeController = TextEditingController();
//   final TextEditingController addressController = TextEditingController();

//   String? selectedOccupation;
//   String? selectedLoanType;
//   String? selectedEducation;

//   // 🔹 Uploaded images
//   File? nationalIdImage;
//   List<File> collateralImages = [];

//   final ImagePicker picker = ImagePicker();

//   // 🔸 Pick Single Image (for National ID)
//   Future<void> pickNationalIdImage() async {
//     final picked = await picker.pickImage(source: ImageSource.gallery);
//     if (picked != null) {
//       setState(() => nationalIdImage = File(picked.path));
//     }
//   }

//   // 🔸 Pick Multiple Images (for Collateral)
//   Future<void> pickCollateralImages() async {
//     final pickedFiles = await picker.pickMultiImage();
//     if (pickedFiles.isNotEmpty) {
//       setState(() {
//         collateralImages =
//             pickedFiles.map((file) => File(file.path)).toList();
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // 🌈 Gradient background
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color.fromARGB(255, 27, 229, 33),
//               Color.fromARGB(255, 50, 40, 229),
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // 🔹 Top Bar
//                 Row(
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.arrow_back, color: Colors.white),
//                       onPressed: () => Navigator.pop(context),
//                     ),
//                     const Text(
//                       "Basic Information",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),

//                 // 🔹 White Card Container
//                 Card(
//                   elevation: 6,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(20),
//                     child: Form(
//                       key: _formKey,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             "Basic Information",
//                             style: TextStyle(
//                               fontSize: 22,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.green,
//                             ),
//                           ),
//                           const SizedBox(height: 10),

//                           // 🔸 Next of Kin Fields
//                           buildTextField("Next of Kin Name", kinNameController),
//                           const SizedBox(height: 15),
//                           buildTextField("Next of Kin Contact",
//                               kinContactController,
//                               keyboardType: TextInputType.phone),
//                           const SizedBox(height: 15),

//                           // 🔹 Occupation Dropdown
//                           buildDropdown(
//                             label: "Occupation",
//                             value: selectedOccupation,
//                             items: [
//                               "Farmer",
//                               "Business Owner",
//                               "Teacher",
//                               "Engineer",
//                               "Driver",
//                               "Student",
//                               "Civil Servant",
//                               "Medical Worker",
//                               "Technician",
//                               "Other"
//                             ],
//                             onChanged: (value) =>
//                                 setState(() => selectedOccupation = value),
//                           ),
//                           const SizedBox(height: 15),

//                           // 🔹 Monthly Income
//                           buildTextField("Monthly Income (UGX)", incomeController,
//                               keyboardType: TextInputType.number),
//                           const SizedBox(height: 15),

//                           // 🔹 Type of Loan
//                           buildDropdown(
//                             label: "Type of Loan",
//                             value: selectedLoanType,
//                             items: [
//                               "Logbook Loan",
//                               "Business Loan",
//                               "Personal Loan",
//                               "Investment Loan",
//                               "Car Loan"
//                             ],
//                             onChanged: (value) =>
//                                 setState(() => selectedLoanType = value),
//                           ),
//                           const SizedBox(height: 15),

//                           // 🔹 Education Level
//                           buildDropdown(
//                             label: "Highest Education",
//                             value: selectedEducation,
//                             items: [
//                               "Primary",
//                               "Secondary",
//                               "Diploma",
//                               "Bachelor’s Degree",
//                               "Master’s Degree",
//                               "Doctorate",
//                               "Other"
//                             ],
//                             onChanged: (value) =>
//                                 setState(() => selectedEducation = value),
//                           ),
//                           const SizedBox(height: 15),

//                           // 🔹 Current Address
//                           buildTextField(
//                               "Current Address", addressController),
//                           const SizedBox(height: 20),

//                           // 🔹 National ID Upload
//                           const Text(
//                             "National ID",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 16),
//                           ),
//                           const SizedBox(height: 8),
//                           GestureDetector(
//                             onTap: pickNationalIdImage,
//                             child: Container(
//                               height: 150,
//                               width: double.infinity,
//                               decoration: BoxDecoration(
//                                 color: Colors.grey[100],
//                                 borderRadius: BorderRadius.circular(10),
//                                 border: Border.all(color: Colors.green),
//                               ),
//                               child: nationalIdImage == null
//                                   ? const Center(
//                                       child: Text(
//                                         "Tap to upload National ID",
//                                         style: TextStyle(color: Colors.grey),
//                                       ),
//                                     )
//                                   : Image.file(nationalIdImage!,
//                                       fit: BoxFit.cover),
//                             ),
//                           ),
//                           const SizedBox(height: 20),

//                           // 🔹 Collateral Upload
//                           const Text(
//                             "Collateral (Upload one or more images)",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 16),
//                           ),
//                           const SizedBox(height: 8),
//                           GestureDetector(
//                             onTap: pickCollateralImages,
//                             child: Container(
//                               height: 150,
//                               width: double.infinity,
//                               decoration: BoxDecoration(
//                                 color: Colors.grey[100],
//                                 borderRadius: BorderRadius.circular(10),
//                                 border: Border.all(color: Colors.green),
//                               ),
//                               child: collateralImages.isEmpty
//                                   ? const Center(
//                                       child: Text(
//                                         "Tap to upload collateral images",
//                                         style: TextStyle(color: Colors.grey),
//                                       ),
//                                     )
//                                   : ListView(
//                                       scrollDirection: Axis.horizontal,
//                                       children: collateralImages
//                                           .map((file) => Padding(
//                                                 padding:
//                                                     const EdgeInsets.all(5),
//                                                 child: Image.file(file,
//                                                     width: 120,
//                                                     height: 120,
//                                                     fit: BoxFit.cover),
//                                               ))
//                                           .toList(),
//                                     ),
//                             ),
//                           ),
//                           const SizedBox(height: 30),

//                           // 🔹 Submit Button
//                           SizedBox(
//                             width: double.infinity,
//                             child: ElevatedButton(
//                               onPressed: () {
//                                 if (_formKey.currentState!.validate()) {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                       content: Text(
//                                           "Loan Application Submitted Successfully ✅"),
//                                       backgroundColor: Colors.green,
//                                     ),
//                                   );
//                                   Navigator.pop(context);
//                                 }
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.green,
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 14),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                               ),
//                               child: const Text(
//                                 "Submit Application",
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // 🔹 Custom TextField Builder
//   Widget buildTextField(String label, TextEditingController controller,
//       {TextInputType keyboardType = TextInputType.text, int maxLines = 1}) {
//     return TextFormField(
//       controller: controller,
//       keyboardType: keyboardType,
//       maxLines: maxLines,
//       validator: (value) =>
//           value == null || value.isEmpty ? "Please enter $label" : null,
//       decoration: InputDecoration(
//         labelText: label,
//         filled: true,
//         fillColor: Colors.grey[100],
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         focusedBorder: const OutlineInputBorder(
//           borderSide: BorderSide(color: Colors.green, width: 2),
//         ),
//       ),
//     );
//   }

//   // 🔹 Custom Dropdown Builder
//   Widget buildDropdown({
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
//         fillColor: Colors.grey[100],
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//       ),
//       items: items
//           .map((item) => DropdownMenuItem(
//                 value: item,
//                 child: Text(item),
//               ))
//           .toList(),
//       onChanged: onChanged,
//       validator: (value) =>
//           value == null ? "Please select your $label" : null,
//     );
//   }
// }
