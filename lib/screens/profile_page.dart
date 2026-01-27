import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'about_screen.dart';
import 'first_loan_application.dart'; // <-- For navigation

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 2;
  bool isEditing = false;

  // 🔹 User Data Controllers (All fields from LoanApplicationPage & Page2, excluding National ID and Collateral)
  final TextEditingController nameController =
      TextEditingController(text: "John Doe");
  final TextEditingController contactController =
      TextEditingController(text: "+256 700 123456");
  final TextEditingController emailController =
      TextEditingController(text: "johndoe@example.com");
  final TextEditingController bioInfoController =
      TextEditingController(text: "Business Owner with 5 years experience");
  final TextEditingController locationController =
      TextEditingController(text: "Kampala, Uganda");
  final TextEditingController otherContactController =
      TextEditingController(text: "+256 701 654321");
  final TextEditingController kinNameController =
      TextEditingController(text: "Jane Doe");
  final TextEditingController kinContactController =
      TextEditingController(text: "+256 702 987654");
  final TextEditingController incomeController =
      TextEditingController(text: "UGX 2,000,000");
  final TextEditingController addressController =
      TextEditingController(text: "Kampala, Uganda");

  String? selectedGender;
  String? selectedOccupation;
  String? selectedLoanType;
  String? selectedEducation;

  // 🔹 Bottom navigation
  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AboutPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,

      // 🔹 App Bar
      appBar: AppBar(
        backgroundColor: const Color(0xFF007BFF),
        elevation: 0,
        title: const Text(
          "My Profile",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              isEditing ? Icons.check_circle : Icons.edit,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() => isEditing = !isEditing);
            },
          ),
        ],
      ),

      // 🔹 Body
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // 🔹 Profile Header
            _buildProfileHeader(theme, isDark),
            const SizedBox(height: 25),

            // 🔹 Personal Information
            _buildSection(
              theme: theme,
              title: "Personal Information",
              children: [
                _buildField("Full Name", nameController, theme, isDark),
                _buildField("Email Address", emailController, theme, isDark),
                _buildField("Phone Number", contactController, theme, isDark),
                _buildField("Other Contact", otherContactController, theme, isDark),
                _buildField("Address", locationController, theme, isDark),
                _buildField("Bio Information", bioInfoController, theme, isDark, maxLines: 3),
                _buildDropdown(
                  label: "Select Gender",
                  value: selectedGender,
                  items: ["Male", "Female", "Other"],
                  theme: theme,
                  isDark: isDark,
                  onChanged: (v) => setState(() => selectedGender = v),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // 🔹 Employment & Loan Information
            _buildSection(
              theme: theme,
              title: "Employment & Loan Details",
              children: [
                _buildField("Next of Kin Name", kinNameController, theme, isDark),
                _buildField("Next of Kin Contact", kinContactController, theme, isDark,
                    keyboardType: TextInputType.phone),
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
                  theme: theme,
                  isDark: isDark,
                  onChanged: (v) => setState(() => selectedOccupation = v),
                ),
                _buildField(
                  "Monthly Income (UGX)",
                  incomeController,
                  theme,
                  isDark,
                  keyboardType: TextInputType.number,
                ),
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
                  theme: theme,
                  isDark: isDark,
                  onChanged: (v) => setState(() => selectedLoanType = v),
                ),
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
                    "Other",
                  ],
                  theme: theme,
                  isDark: isDark,
                  onChanged: (v) => setState(() => selectedEducation = v),
                ),
                _buildField("Current Address", addressController, theme, isDark),
              ],
            ),

            const SizedBox(height: 30),

            // 🔹 Action Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                label: const Text(
                  "Apply for Loan",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoanApplicationPage(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // 🔹 Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        backgroundColor: isDark ? Colors.black : Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.info_outline), label: "About"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profile"),
        ],
      ),
    );
  }

  // 🔹 Profile Header Card
  Widget _buildProfileHeader(ThemeData theme, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 45,
            backgroundColor: const Color(0xFF007BFF),
            child: const Icon(Icons.person, size: 50, color: Colors.white),
          ),
          const SizedBox(height: 12),
          Text(
            nameController.text,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            emailController.text,
            style: TextStyle(
              color: isDark ? Colors.white70 : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Section Container
  Widget _buildSection({
    required ThemeData theme,
    required String title,
    required List<Widget> children,
  }) {
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.grey[100],
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          const SizedBox(height: 15),
          ...children,
        ],
      ),
    );
  }

  // 🔹 Input Field (Editable / Readonly)
  Widget _buildField(String label, TextEditingController controller,
      ThemeData theme, bool isDark,
      {TextInputType keyboardType = TextInputType.text, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
        readOnly: !isEditing,
        maxLines: maxLines,
        keyboardType: keyboardType,
        style: TextStyle(color: isDark ? Colors.white : Colors.black),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
          filled: true,
          fillColor: isDark ? Colors.grey[900] : Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: isDark ? Colors.white12 : Colors.black12,
              width: 0.6,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.blueAccent, width: 0.8),
          ),
        ),
      ),
    );
  }

  // 🔹 Dropdown Field
  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required ThemeData theme,
    required bool isDark,
    required Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: DropdownButtonFormField<String>(
        initialValue: value,
        style: TextStyle(color: isDark ? Colors.white : Colors.black),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
          filled: true,
          fillColor: isDark ? Colors.grey[900] : Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: isDark ? Colors.white12 : Colors.black12,
              width: 0.6,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.blueAccent, width: 0.8),
          ),
        ),
        items: items
            .map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(item),
                ))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}






















// import 'package:flutter/material.dart';
// import 'home_screen.dart';
// import 'about_screen.dart';
// import 'first_loan_application.dart'; // <-- For navigation

// class ProfilePage extends StatefulWidget {
//   const ProfilePage({super.key});

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   int _selectedIndex = 2;
//   bool isEditing = false;

//   // 🔹 User Data Controllers (All fields from LoanApplicationPage & Page2, excluding National ID and Collateral)
//   final TextEditingController nameController =
//       TextEditingController(text: "John Doe");
//   final TextEditingController contactController =
//       TextEditingController(text: "+256 700 123456");
//   final TextEditingController emailController =
//       TextEditingController(text: "johndoe@example.com");
//   final TextEditingController bioInfoController =
//       TextEditingController(text: "Business Owner with 5 years experience");
//   final TextEditingController locationController =
//       TextEditingController(text: "Kampala, Uganda");
//   final TextEditingController otherContactController =
//       TextEditingController(text: "+256 701 654321");
//   final TextEditingController kinNameController =
//       TextEditingController(text: "Jane Doe");
//   final TextEditingController kinContactController =
//       TextEditingController(text: "+256 702 987654");
//   final TextEditingController incomeController =
//       TextEditingController(text: "UGX 2,000,000");
//   final TextEditingController addressController =
//       TextEditingController(text: "Kampala, Uganda");

//   String? selectedGender;
//   String? selectedOccupation;
//   String? selectedLoanType;
//   String? selectedEducation;

//   // 🔹 Bottom navigation
//   void _onItemTapped(int index) {
//     setState(() => _selectedIndex = index);

//     if (index == 0) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => const HomePage()),
//       );
//     } else if (index == 1) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => const AboutPage()),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,

//       // 🔹 App Bar
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF007BFF),
//         elevation: 0,
//         title: const Text(
//           "My Profile",
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: Icon(
//               isEditing ? Icons.check_circle : Icons.edit,
//               color: Colors.white,
//             ),
//             onPressed: () {
//               setState(() => isEditing = !isEditing);
//             },
//           ),
//         ],
//       ),

//       // 🔹 Body
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             // 🔹 Profile Header
//             _buildProfileHeader(),
//             const SizedBox(height: 25),

//             // 🔹 Personal Information
//             _buildSection(
//               title: "Personal Information",
//               children: [
//                 _buildField("Full Name", nameController),
//                 _buildField("Email Address", emailController),
//                 _buildField("Phone Number", contactController),
//                 _buildField("Other Contact", otherContactController),
//                 _buildField("Address", locationController),
//                 _buildField("Bio Information", bioInfoController, maxLines: 3),
//                 _buildDropdown(
//                   label: "Select Gender",
//                   value: selectedGender,
//                   items: ["Male", "Female", "Other"],
//                   onChanged: (v) => setState(() => selectedGender = v),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 20),

//             // 🔹 Employment & Loan Information
//             _buildSection(
//               title: "Employment & Loan Details",
//               children: [
//                 _buildField("Next of Kin Name", kinNameController),
//                 _buildField("Next of Kin Contact", kinContactController,
//                     keyboardType: TextInputType.phone),
//                 _buildDropdown(
//                   label: "Occupation",
//                   value: selectedOccupation,
//                   items: [
//                     "Farmer",
//                     "Business Owner",
//                     "Teacher",
//                     "Engineer",
//                     "Driver",
//                     "Student",
//                     "Civil Servant",
//                     "Medical Worker",
//                     "Technician",
//                     "Other",
//                   ],
//                   onChanged: (v) => setState(() => selectedOccupation = v),
//                 ),
//                 _buildField(
//                   "Monthly Income (UGX)",
//                   incomeController,
//                   keyboardType: TextInputType.number,
//                 ),
//                 _buildDropdown(
//                   label: "Loan Type",
//                   value: selectedLoanType,
//                   items: [
//                     "Logbook Loan",
//                     "Business Loan",
//                     "Personal Loan",
//                     "Investment Loan",
//                     "Car Loan",
//                   ],
//                   onChanged: (v) => setState(() => selectedLoanType = v),
//                 ),
//                 _buildDropdown(
//                   label: "Highest Education",
//                   value: selectedEducation,
//                   items: [
//                     "Primary",
//                     "Secondary",
//                     "Diploma",
//                     "Bachelor’s Degree",
//                     "Master’s Degree",
//                     "Doctorate",
//                     "Other",
//                   ],
//                   onChanged: (v) => setState(() => selectedEducation = v),
//                 ),
//                 _buildField("Current Address", addressController),
//               ],
//             ),

//             const SizedBox(height: 30),

//             // 🔹 Action Button
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton.icon(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.green,
//                   padding: const EdgeInsets.symmetric(vertical: 14),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),

//                 label: const Text(
//                   "Apply for Loan",
//                   style: TextStyle(
//                     fontSize: 17,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const LoanApplicationPage(),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),

//       // 🔹 Bottom Navigation
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         selectedItemColor: Colors.green,
//         unselectedItemColor: Colors.grey,
//         backgroundColor: Colors.white,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//           BottomNavigationBarItem(icon: Icon(Icons.info_outline), label: "About"),
//           BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profile"),
//         ],
//       ),
//     );
//   }

//   // 🔹 Profile Header Card
//   Widget _buildProfileHeader() {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.grey[100],
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Column(
//         children: [
//           CircleAvatar(
//             radius: 45,
//             backgroundColor: Colors.blueAccent,
//             child: const Icon(Icons.person, size: 50, color: Colors.white),
//           ),
//           const SizedBox(height: 12),
//           Text(
//             nameController.text,
//             style: const TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             emailController.text,
//             style: const TextStyle(color: Colors.black54),
//           ),
//         ],
//       ),
//     );
//   }

//   // 🔹 Section Container
//   Widget _buildSection({
//     required String title,
//     required List<Widget> children,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.grey[100],
//         borderRadius: BorderRadius.circular(14),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(
//               fontSize: 17,
//               fontWeight: FontWeight.bold,
//               color: Colors.blueAccent,
//             ),
//           ),
//           const SizedBox(height: 15),
//           ...children,
//         ],
//       ),
//     );
//   }

//   // 🔹 Input Field (Editable / Readonly)
//   Widget _buildField(String label, TextEditingController controller,
//       {TextInputType keyboardType = TextInputType.text, int maxLines = 1}) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 14),
//       child: TextField(
//         controller: controller,
//         readOnly: !isEditing,
//         maxLines: maxLines,
//         keyboardType: keyboardType,
//         decoration: InputDecoration(
//           labelText: label,
//           filled: true,
//           fillColor: Colors.white,
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8),
//             borderSide: const BorderSide(color: Colors.black12, width: 0.6),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8),
//             borderSide: const BorderSide(color: Colors.blueAccent, width: 0.8),
//           ),
//         ),
//       ),
//     );
//   }

//   // 🔹 Dropdown Field
//   Widget _buildDropdown({
//     required String label,
//     required String? value,
//     required List<String> items,
//     required Function(String?) onChanged,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 14),
//       child: DropdownButtonFormField<String>(
//         value: value,
//         decoration: InputDecoration(
//           labelText: label,
//           filled: true,
//           fillColor: Colors.white,
//           contentPadding:
//               const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8),
//             borderSide: const BorderSide(color: Colors.black12, width: 0.6),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8),
//             borderSide: const BorderSide(color: Colors.blueAccent, width: 0.8),
//           ),
//         ),
//         items: items
//             .map((item) => DropdownMenuItem(value: item, child: Text(item)))
//             .toList(),
//         onChanged: onChanged,
//       ),
//     );
//   }
// }
