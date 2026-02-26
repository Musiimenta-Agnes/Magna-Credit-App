import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:magna_credit_app/api_service.dart';
import 'home_screen.dart';
import 'about_screen.dart';
import 'first_loan_application.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 2;
  bool isEditing = false;
  bool isLoading = true;

  File? profileImage;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController bioInfoController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController otherContactController = TextEditingController();
  final TextEditingController kinNameController = TextEditingController();
  final TextEditingController kinContactController = TextEditingController();
  final TextEditingController incomeController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  String selectedGender = 'Other';
  String selectedOccupation = 'Other';
  String selectedLoanType = '';
  String selectedEducation = '';
  String? profileImageUrl;

  static const Color _blue = Color(0xFF007BFF);
  static const Color _green = Colors.green;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final data = await ApiService.getProfile();
      setState(() {
        nameController.text = data['name'] ?? '';
        emailController.text = data['email'] ?? '';
        contactController.text = data['phone'] ?? '';
        bioInfoController.text = data['profile']?['bio'] ?? '';
        locationController.text = data['profile']?['address'] ?? '';
        otherContactController.text = data['profile']?['other_contact'] ?? '';
        kinNameController.text = data['profile']?['kin_name'] ?? '';
        kinContactController.text = data['profile']?['kin_contact'] ?? '';
        incomeController.text = data['profile']?['income'] ?? '';
        addressController.text = data['profile']?['current_address'] ?? '';
        selectedGender = data['profile']?['gender'] ?? 'Other';
        selectedOccupation = data['profile']?['occupation'] ?? 'Other';
        selectedLoanType = data['profile']?['loan_type'] ?? '';
        selectedEducation = data['profile']?['education'] ?? '';
        profileImageUrl = data['profile']?['profile_image'];
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load profile: $e')),
      );
    }
  }

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => profileImage = File(picked.path));
  }

  Future<void> _saveProfile() async {
    final profileData = {
      'name': nameController.text,
      'phone': contactController.text,
      'bio': bioInfoController.text,
      'address': locationController.text,
      'other_contact': otherContactController.text,
      'kin_name': kinNameController.text,
      'kin_contact': kinContactController.text,
      'income': incomeController.text,
      'current_address': addressController.text,
      'gender': selectedGender,
      'occupation': selectedOccupation,
      'loan_type': selectedLoanType,
      'education': selectedEducation,
    };
    try {
      await ApiService.updateProfile(profileData, profileImage);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ Profile updated successfully'),
          backgroundColor: Colors.green,
        ),
      );
      setState(() => isEditing = false);
      _loadProfile();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update: $e')),
      );
    }
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    if (index == 0) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const HomePage()));
    } else if (index == 1) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const AboutPage()));
    }
  }

  String safeDropdownValue(String current, List<String> items,
      {String defaultValue = 'Other'}) {
    if (current.isNotEmpty && items.contains(current)) return current;
    if (current.isNotEmpty && !items.contains(current)) items.add(current);
    return defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (isLoading) {
      return Scaffold(
        backgroundColor: isDark ? Colors.black : Colors.white,
        body: const Center(
          child: CircularProgressIndicator(color: _blue),
        ),
      );
    }

    return Scaffold(
      backgroundColor: isDark ? Colors.black : const Color(0xFFF5F8FA),

      appBar: AppBar(
        backgroundColor: _blue,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "My Profile",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            letterSpacing: 0.4,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                if (isEditing) {
                  _saveProfile();
                } else {
                  setState(() => isEditing = true);
                }
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(
                      isEditing ? Icons.check_rounded : Icons.edit_rounded,
                      color: Colors.white,
                      size: 15,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      isEditing ? "Save" : "Edit",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
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
        child: Column(
          children: [

            // ── Profile header card ──
            _buildProfileHeader(isDark),

            const SizedBox(height: 22),

            // ── Personal Information ──
            _buildSectionCard(
              title: "Personal Information",
              icon: Icons.person_rounded,
              isDark: isDark,
              children: [
                _buildField("Full Name", nameController, isDark,
                    icon: Icons.badge_rounded),
                _buildField("Email Address", emailController, isDark,
                    icon: Icons.email_rounded, readOnly: true),
                _buildField("Phone Number", contactController, isDark,
                    icon: Icons.phone_rounded,
                    keyboardType: TextInputType.phone),
                _buildField("Other Contact", otherContactController, isDark,
                    icon: Icons.phone_in_talk_rounded,
                    keyboardType: TextInputType.phone),
                _buildField("Address", locationController, isDark,
                    icon: Icons.location_on_rounded),
                _buildField("Bio", bioInfoController, isDark,
                    icon: Icons.info_outline_rounded, maxLines: 3),
                _buildDropdown(
                  "Gender",
                  safeDropdownValue(
                      selectedGender, ["Male", "Female", "Other"]),
                  ["Male", "Female", "Other"],
                  isDark,
                  Icons.wc_rounded,
                  (v) => setState(() => selectedGender = v!),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // ── Employment & Loan ──
            _buildSectionCard(
              title: "Employment & Loan Details",
              icon: Icons.work_rounded,
              isDark: isDark,
              children: [
                _buildField("Next of Kin Name", kinNameController, isDark,
                    icon: Icons.people_rounded),
                _buildField("Next of Kin Contact", kinContactController, isDark,
                    icon: Icons.contact_phone_rounded,
                    keyboardType: TextInputType.phone),
                _buildDropdown(
                  "Occupation",
                  safeDropdownValue(selectedOccupation, [
                    "Farmer", "Business Owner", "Teacher", "Engineer",
                    "Driver", "Student", "Civil Servant", "Medical Worker",
                    "Technician", "Other"
                  ]),
                  [
                    "Farmer", "Business Owner", "Teacher", "Engineer",
                    "Driver", "Student", "Civil Servant", "Medical Worker",
                    "Technician", "Other"
                  ],
                  isDark,
                  Icons.work_outline_rounded,
                  (v) => setState(() => selectedOccupation = v!),
                ),
                _buildField(
                  "Monthly Income (UGX)",
                  incomeController,
                  isDark,
                  icon: Icons.account_balance_wallet_rounded,
                  keyboardType: TextInputType.number,
                ),
                _buildDropdown(
                  "Loan Type",
                  safeDropdownValue(selectedLoanType, [
                    "Logbook Loan", "Business Loan", "Personal Loan",
                    "Investment Loan", "Car Loan"
                  ]),
                  [
                    "Logbook Loan", "Business Loan", "Personal Loan",
                    "Investment Loan", "Car Loan"
                  ],
                  isDark,
                  Icons.monetization_on_rounded,
                  (v) => setState(() => selectedLoanType = v!),
                ),
                _buildDropdown(
                  "Highest Education",
                  safeDropdownValue(selectedEducation, [
                    "Primary", "Secondary", "Diploma", "Bachelor's Degree",
                    "Master's Degree", "Doctorate", "Other"
                  ]),
                  [
                    "Primary", "Secondary", "Diploma", "Bachelor's Degree",
                    "Master's Degree", "Doctorate", "Other"
                  ],
                  isDark,
                  Icons.school_rounded,
                  (v) => setState(() => selectedEducation = v!),
                ),
                _buildField("Current Address", addressController, isDark,
                    icon: Icons.home_rounded),
              ],
            ),

            const SizedBox(height: 24),

            // ── Apply for Loan button ──
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const LoanApplicationPage()),
              ),
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
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.account_balance_rounded,
                        color: Colors.white, size: 20),
                    SizedBox(width: 10),
                    Text(
                      "Apply for a Loan",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
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

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: _blue,
        unselectedItemColor: Colors.grey,
        backgroundColor: isDark ? Colors.black : Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.info_outline), label: "About"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: "Profile"),
        ],
      ),
    );
  }

  // ── Profile header ──
  Widget _buildProfileHeader(bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: BoxDecoration(
        color: _blue,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: _blue.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Avatar
          GestureDetector(
            onTap: isEditing ? _pickImage : null,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 12,
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 46,
                    backgroundColor: Colors.white.withOpacity(0.2),
                    backgroundImage: profileImage != null
                        ? FileImage(profileImage!)
                        : (profileImageUrl != null
                            ? NetworkImage(profileImageUrl!)
                                as ImageProvider
                            : null),
                    child: profileImage == null && profileImageUrl == null
                        ? const Icon(Icons.person_rounded,
                            size: 50, color: Colors.white)
                        : null,
                  ),
                ),
                if (isEditing)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: _green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(Icons.camera_alt_rounded,
                          color: Colors.white, size: 14),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          Text(
            nameController.text.isNotEmpty
                ? nameController.text
                : "Your Name",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: 0.3,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            emailController.text,
            style: TextStyle(
              fontSize: 13,
              color: Colors.white.withOpacity(0.8),
            ),
          ),

          const SizedBox(height: 14),

          // Info chips row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _InfoChip(
                  icon: Icons.phone_rounded,
                  label: contactController.text.isNotEmpty
                      ? contactController.text
                      : "No phone"),
              const SizedBox(width: 10),
              _InfoChip(
                  icon: Icons.work_rounded,
                  label: selectedOccupation.isNotEmpty
                      ? selectedOccupation
                      : "Occupation"),
            ],
          ),
        ],
      ),
    );
  }

  // ── Section card ──
  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required bool isDark,
    required List<Widget> children,
  }) {
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
          // Section header
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
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          ...children,
        ],
      ),
    );
  }

  // ── Input field ──
  Widget _buildField(
    String label,
    TextEditingController controller,
    bool isDark, {
    IconData? icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    bool readOnly = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
        readOnly: readOnly || !isEditing,
        maxLines: maxLines,
        keyboardType: keyboardType,
        style: TextStyle(
          color: isDark ? Colors.white : Colors.black87,
          fontSize: 14,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: isDark ? Colors.white54 : Colors.black45,
            fontSize: 13,
          ),
          prefixIcon: icon != null
              ? Icon(icon, color: _blue, size: 18)
              : null,
          filled: true,
          fillColor: isDark
              ? Colors.grey[850]
              : (isEditing ? const Color(0xFFF5F8FF) : Colors.grey.shade50),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 13, horizontal: 14),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: isDark
                  ? Colors.white12
                  : (isEditing
                      ? const Color(0xFFD0E4FF)
                      : Colors.black.withOpacity(0.07)),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: _blue, width: 1.5),
          ),
        ),
      ),
    );
  }

  // ── Dropdown ──
  Widget _buildDropdown(
    String label,
    String value,
    List<String> items,
    bool isDark,
    IconData icon,
    Function(String?) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: DropdownButtonFormField<String>(
        value: value,
        style: TextStyle(
          color: isDark ? Colors.white : Colors.black87,
          fontSize: 14,
        ),
        dropdownColor: isDark ? Colors.grey[900] : Colors.white,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: isDark ? Colors.white54 : Colors.black45,
            fontSize: 13,
          ),
          prefixIcon: Icon(icon, color: _blue, size: 18),
          filled: true,
          fillColor: isDark
              ? Colors.grey[850]
              : (isEditing ? const Color(0xFFF5F8FF) : Colors.grey.shade50),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 13, horizontal: 14),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: isDark
                  ? Colors.white12
                  : (isEditing
                      ? const Color(0xFFD0E4FF)
                      : Colors.black.withOpacity(0.07)),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: _blue, width: 1.5),
          ),
        ),
        items: items
            .map((item) => DropdownMenuItem(value: item, child: Text(item)))
            .toList(),
        onChanged: isEditing ? onChanged : null,
      ),
    );
  }
}

// ── Info chip on profile header ──
class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 13),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

























// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:magna_credit_app/api_service.dart';
// import 'home_screen.dart';
// import 'about_screen.dart';
// import 'first_loan_application.dart';

// class ProfilePage extends StatefulWidget {
//   final int userId;
//   const ProfilePage({super.key, required this.userId});

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   int _selectedIndex = 2;
//   bool isEditing = false;
//   bool isLoading = true;

//   File? profileImage;

//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController contactController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController bioInfoController = TextEditingController();
//   final TextEditingController locationController = TextEditingController();
//   final TextEditingController otherContactController = TextEditingController();
//   final TextEditingController kinNameController = TextEditingController();
//   final TextEditingController kinContactController = TextEditingController();
//   final TextEditingController incomeController = TextEditingController();
//   final TextEditingController addressController = TextEditingController();

//   String selectedGender = 'Other';
//   String selectedOccupation = 'Other';
//   String selectedLoanType = '';
//   String selectedEducation = '';
//   String? profileImageUrl;

//   static const Color _blue = Color(0xFF007BFF);
//   static const Color _green = Colors.green;

//   @override
//   void initState() {
//     super.initState();
//     _loadProfile();
//   }

//   Future<void> _loadProfile() async {
//     try {
//       final data = await ApiService.getProfile();
//       setState(() {
//         nameController.text = data['name'] ?? '';
//         emailController.text = data['email'] ?? '';
//         contactController.text = data['phone'] ?? '';
//         bioInfoController.text = data['profile']?['bio'] ?? '';
//         locationController.text = data['profile']?['address'] ?? '';
//         otherContactController.text = data['profile']?['other_contact'] ?? '';
//         kinNameController.text = data['profile']?['kin_name'] ?? '';
//         kinContactController.text = data['profile']?['kin_contact'] ?? '';
//         incomeController.text = data['profile']?['income'] ?? '';
//         addressController.text = data['profile']?['current_address'] ?? '';
//         selectedGender = data['profile']?['gender'] ?? 'Other';
//         selectedOccupation = data['profile']?['occupation'] ?? 'Other';
//         selectedLoanType = data['profile']?['loan_type'] ?? '';
//         selectedEducation = data['profile']?['education'] ?? '';
//         profileImageUrl = data['profile']?['profile_image'];
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() => isLoading = false);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to load profile: $e')),
//       );
//     }
//   }

//   Future<void> _pickImage() async {
//     final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (picked != null) setState(() => profileImage = File(picked.path));
//   }

//   Future<void> _saveProfile() async {
//     final profileData = {
//       'name': nameController.text,
//       'phone': contactController.text,
//       'bio': bioInfoController.text,
//       'address': locationController.text,
//       'other_contact': otherContactController.text,
//       'kin_name': kinNameController.text,
//       'kin_contact': kinContactController.text,
//       'income': incomeController.text,
//       'current_address': addressController.text,
//       'gender': selectedGender,
//       'occupation': selectedOccupation,
//       'loan_type': selectedLoanType,
//       'education': selectedEducation,
//     };
//     try {
//       await ApiService.updateProfile(profileData, profileImage);
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('✅ Profile updated successfully'),
//           backgroundColor: Colors.green,
//         ),
//       );
//       setState(() => isEditing = false);
//       _loadProfile();
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to update: $e')),
//       );
//     }
//   }

//   void _onItemTapped(int index) {
//     setState(() => _selectedIndex = index);
//     if (index == 0) {
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (_) => const HomePage()));
//     } else if (index == 1) {
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (_) => const AboutPage()));
//     }
//   }

//   String safeDropdownValue(String current, List<String> items,
//       {String defaultValue = 'Other'}) {
//     if (current.isNotEmpty && items.contains(current)) return current;
//     if (current.isNotEmpty && !items.contains(current)) items.add(current);
//     return defaultValue;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     if (isLoading) {
//       return Scaffold(
//         backgroundColor: isDark ? Colors.black : Colors.white,
//         body: const Center(
//           child: CircularProgressIndicator(color: _blue),
//         ),
//       );
//     }

//     return Scaffold(
//       backgroundColor: isDark ? Colors.black : const Color(0xFFF5F8FA),

//       appBar: AppBar(
//         backgroundColor: _blue,
//         elevation: 0,
//         centerTitle: true,
//         title: const Text(
//           "My Profile",
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 18,
//             letterSpacing: 0.4,
//           ),
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 10),
//             child: GestureDetector(
//               onTap: () {
//                 if (isEditing) {
//                   _saveProfile();
//                 } else {
//                   setState(() => isEditing = true);
//                 }
//               },
//               child: Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.18),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(
//                       isEditing ? Icons.check_rounded : Icons.edit_rounded,
//                       color: Colors.white,
//                       size: 15,
//                     ),
//                     const SizedBox(width: 5),
//                     Text(
//                       isEditing ? "Save" : "Edit",
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 13,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
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
//         padding: const EdgeInsets.fromLTRB(18, 24, 18, 30),
//         child: Column(
//           children: [

//             // ── Profile header card ──
//             _buildProfileHeader(isDark),

//             const SizedBox(height: 22),

//             // ── Personal Information ──
//             _buildSectionCard(
//               title: "Personal Information",
//               icon: Icons.person_rounded,
//               isDark: isDark,
//               children: [
//                 _buildField("Full Name", nameController, isDark,
//                     icon: Icons.badge_rounded),
//                 _buildField("Email Address", emailController, isDark,
//                     icon: Icons.email_rounded, readOnly: true),
//                 _buildField("Phone Number", contactController, isDark,
//                     icon: Icons.phone_rounded,
//                     keyboardType: TextInputType.phone),
//                 _buildField("Other Contact", otherContactController, isDark,
//                     icon: Icons.phone_in_talk_rounded,
//                     keyboardType: TextInputType.phone),
//                 _buildField("Address", locationController, isDark,
//                     icon: Icons.location_on_rounded),
//                 _buildField("Bio", bioInfoController, isDark,
//                     icon: Icons.info_outline_rounded, maxLines: 3),
//                 _buildDropdown(
//                   "Gender",
//                   safeDropdownValue(
//                       selectedGender, ["Male", "Female", "Other"]),
//                   ["Male", "Female", "Other"],
//                   isDark,
//                   Icons.wc_rounded,
//                   (v) => setState(() => selectedGender = v!),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 16),

//             // ── Employment & Loan ──
//             _buildSectionCard(
//               title: "Employment & Loan Details",
//               icon: Icons.work_rounded,
//               isDark: isDark,
//               children: [
//                 _buildField("Next of Kin Name", kinNameController, isDark,
//                     icon: Icons.people_rounded),
//                 _buildField("Next of Kin Contact", kinContactController, isDark,
//                     icon: Icons.contact_phone_rounded,
//                     keyboardType: TextInputType.phone),
//                 _buildDropdown(
//                   "Occupation",
//                   safeDropdownValue(selectedOccupation, [
//                     "Farmer", "Business Owner", "Teacher", "Engineer",
//                     "Driver", "Student", "Civil Servant", "Medical Worker",
//                     "Technician", "Other"
//                   ]),
//                   [
//                     "Farmer", "Business Owner", "Teacher", "Engineer",
//                     "Driver", "Student", "Civil Servant", "Medical Worker",
//                     "Technician", "Other"
//                   ],
//                   isDark,
//                   Icons.work_outline_rounded,
//                   (v) => setState(() => selectedOccupation = v!),
//                 ),
//                 _buildField(
//                   "Monthly Income (UGX)",
//                   incomeController,
//                   isDark,
//                   icon: Icons.account_balance_wallet_rounded,
//                   keyboardType: TextInputType.number,
//                 ),
//                 _buildDropdown(
//                   "Loan Type",
//                   safeDropdownValue(selectedLoanType, [
//                     "Logbook Loan", "Business Loan", "Personal Loan",
//                     "Investment Loan", "Car Loan"
//                   ]),
//                   [
//                     "Logbook Loan", "Business Loan", "Personal Loan",
//                     "Investment Loan", "Car Loan"
//                   ],
//                   isDark,
//                   Icons.monetization_on_rounded,
//                   (v) => setState(() => selectedLoanType = v!),
//                 ),
//                 _buildDropdown(
//                   "Highest Education",
//                   safeDropdownValue(selectedEducation, [
//                     "Primary", "Secondary", "Diploma", "Bachelor's Degree",
//                     "Master's Degree", "Doctorate", "Other"
//                   ]),
//                   [
//                     "Primary", "Secondary", "Diploma", "Bachelor's Degree",
//                     "Master's Degree", "Doctorate", "Other"
//                   ],
//                   isDark,
//                   Icons.school_rounded,
//                   (v) => setState(() => selectedEducation = v!),
//                 ),
//                 _buildField("Current Address", addressController, isDark,
//                     icon: Icons.home_rounded),
//               ],
//             ),

//             const SizedBox(height: 24),

//             // ── Apply for Loan button ──
//             GestureDetector(
//               onTap: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   // ✅ Pass the real userId from login
//                   builder: (_) => LoanApplicationPage(userId: widget.userId),
//                 ),
//               ),
//               child: Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.symmetric(vertical: 15),
//                 decoration: BoxDecoration(
//                   color: _green,
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.green.withOpacity(0.28),
//                       blurRadius: 16,
//                       offset: const Offset(0, 6),
//                     ),
//                   ],
//                 ),
//                 child: const Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.account_balance_rounded,
//                         color: Colors.white, size: 20),
//                     SizedBox(width: 10),
//                     Text(
//                       "Apply for a Loan",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.white,
//                         letterSpacing: 0.4,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),

//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         selectedItemColor: _blue,
//         unselectedItemColor: Colors.grey,
//         backgroundColor: isDark ? Colors.black : Colors.white,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.info_outline), label: "About"),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.person_outline), label: "Profile"),
//         ],
//       ),
//     );
//   }

//   // ── Profile header ──
//   Widget _buildProfileHeader(bool isDark) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
//       decoration: BoxDecoration(
//         color: _blue,
//         borderRadius: BorderRadius.circular(24),
//         boxShadow: [
//           BoxShadow(
//             color: _blue.withOpacity(0.3),
//             blurRadius: 20,
//             offset: const Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           // Avatar
//           GestureDetector(
//             onTap: isEditing ? _pickImage : null,
//             child: Stack(
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     border: Border.all(color: Colors.white, width: 3),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.2),
//                         blurRadius: 12,
//                       ),
//                     ],
//                   ),
//                   child: CircleAvatar(
//                     radius: 46,
//                     backgroundColor: Colors.white.withOpacity(0.2),
//                     backgroundImage: profileImage != null
//                         ? FileImage(profileImage!)
//                         : (profileImageUrl != null
//                             ? NetworkImage(profileImageUrl!) as ImageProvider
//                             : null),
//                     child: profileImage == null && profileImageUrl == null
//                         ? const Icon(Icons.person_rounded,
//                             size: 50, color: Colors.white)
//                         : null,
//                   ),
//                 ),
//                 if (isEditing)
//                   Positioned(
//                     bottom: 0,
//                     right: 0,
//                     child: Container(
//                       padding: const EdgeInsets.all(6),
//                       decoration: BoxDecoration(
//                         color: _green,
//                         shape: BoxShape.circle,
//                         border: Border.all(color: Colors.white, width: 2),
//                       ),
//                       child: const Icon(Icons.camera_alt_rounded,
//                           color: Colors.white, size: 14),
//                     ),
//                   ),
//               ],
//             ),
//           ),

//           const SizedBox(height: 14),

//           Text(
//             nameController.text.isNotEmpty ? nameController.text : "Your Name",
//             style: const TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.w700,
//               color: Colors.white,
//               letterSpacing: 0.3,
//             ),
//           ),

//           const SizedBox(height: 4),

//           Text(
//             emailController.text,
//             style: TextStyle(
//               fontSize: 13,
//               color: Colors.white.withOpacity(0.8),
//             ),
//           ),

//           const SizedBox(height: 14),

//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               _InfoChip(
//                   icon: Icons.phone_rounded,
//                   label: contactController.text.isNotEmpty
//                       ? contactController.text
//                       : "No phone"),
//               const SizedBox(width: 10),
//               _InfoChip(
//                   icon: Icons.work_rounded,
//                   label: selectedOccupation.isNotEmpty
//                       ? selectedOccupation
//                       : "Occupation"),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   // ── Section card ──
//   Widget _buildSectionCard({
//     required String title,
//     required IconData icon,
//     required bool isDark,
//     required List<Widget> children,
//   }) {
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
//                   letterSpacing: 0.2,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 18),
//           ...children,
//         ],
//       ),
//     );
//   }

//   // ── Input field ──
//   Widget _buildField(
//     String label,
//     TextEditingController controller,
//     bool isDark, {
//     IconData? icon,
//     TextInputType keyboardType = TextInputType.text,
//     int maxLines = 1,
//     bool readOnly = false,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 14),
//       child: TextField(
//         controller: controller,
//         readOnly: readOnly || !isEditing,
//         maxLines: maxLines,
//         keyboardType: keyboardType,
//         style: TextStyle(
//           color: isDark ? Colors.white : Colors.black87,
//           fontSize: 14,
//         ),
//         decoration: InputDecoration(
//           labelText: label,
//           labelStyle: TextStyle(
//             color: isDark ? Colors.white54 : Colors.black45,
//             fontSize: 13,
//           ),
//           prefixIcon:
//               icon != null ? Icon(icon, color: _blue, size: 18) : null,
//           filled: true,
//           fillColor: isDark
//               ? Colors.grey[850]
//               : (isEditing ? const Color(0xFFF5F8FF) : Colors.grey.shade50),
//           contentPadding:
//               const EdgeInsets.symmetric(vertical: 13, horizontal: 14),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide(
//               color: isDark
//                   ? Colors.white12
//                   : (isEditing
//                       ? const Color(0xFFD0E4FF)
//                       : Colors.black.withOpacity(0.07)),
//             ),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: const BorderSide(color: _blue, width: 1.5),
//           ),
//         ),
//       ),
//     );
//   }

//   // ── Dropdown ──
//   Widget _buildDropdown(
//     String label,
//     String value,
//     List<String> items,
//     bool isDark,
//     IconData icon,
//     Function(String?) onChanged,
//   ) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 14),
//       child: DropdownButtonFormField<String>(
//         value: value,
//         style: TextStyle(
//           color: isDark ? Colors.white : Colors.black87,
//           fontSize: 14,
//         ),
//         dropdownColor: isDark ? Colors.grey[900] : Colors.white,
//         decoration: InputDecoration(
//           labelText: label,
//           labelStyle: TextStyle(
//             color: isDark ? Colors.white54 : Colors.black45,
//             fontSize: 13,
//           ),
//           prefixIcon: Icon(icon, color: _blue, size: 18),
//           filled: true,
//           fillColor: isDark
//               ? Colors.grey[850]
//               : (isEditing ? const Color(0xFFF5F8FF) : Colors.grey.shade50),
//           contentPadding:
//               const EdgeInsets.symmetric(vertical: 13, horizontal: 14),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide(
//               color: isDark
//                   ? Colors.white12
//                   : (isEditing
//                       ? const Color(0xFFD0E4FF)
//                       : Colors.black.withOpacity(0.07)),
//             ),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: const BorderSide(color: _blue, width: 1.5),
//           ),
//         ),
//         items: items
//             .map((item) => DropdownMenuItem(value: item, child: Text(item)))
//             .toList(),
//         onChanged: isEditing ? onChanged : null,
//       ),
//     );
//   }
// }

// // ── Info chip on profile header ──
// class _InfoChip extends StatelessWidget {
//   final IconData icon;
//   final String label;

//   const _InfoChip({required this.icon, required this.label});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.15),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: Colors.white.withOpacity(0.25)),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, color: Colors.white, size: 13),
//           const SizedBox(width: 5),
//           Text(
//             label,
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 11,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }