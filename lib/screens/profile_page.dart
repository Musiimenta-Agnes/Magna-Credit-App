
import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'about_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 2;

  // Editable user data
  TextEditingController nameController =
      TextEditingController(text: "John Doe");
  TextEditingController emailController =
      TextEditingController(text: "johndoe@example.com");
  TextEditingController phoneController =
      TextEditingController(text: "+256 700 123456");
  TextEditingController addressController =
      TextEditingController(text: "Kampala, Uganda");
  TextEditingController occupationController =
      TextEditingController(text: "Software Engineer");
  TextEditingController incomeController =
      TextEditingController(text: "UGX 2,000,000");

  bool isEditing = false;
  String? _profileImagePath;

  // 🔹 Navigation bar logic
  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AboutPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "My Profile",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              isEditing ? Icons.check : Icons.edit,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                isEditing = !isEditing;
              });
            },
          ),
        ],
      ),

      // 🔹 Body content
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // 🔹 Profile Picture
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: _profileImagePath != null
                        ? AssetImage(_profileImagePath!)
                        : const AssetImage('assets/pic1.jpg'),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 4,
                    child: GestureDetector(
                      onTap: () {
                        // Placeholder for image picker (to be added later)
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Profile picture editing coming soon."),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green,
                        ),
                        child: const Icon(Icons.camera_alt,
                            color: Colors.white, size: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 🔹 Editable Info Fields
            _buildEditableField("Full Name", nameController),
            _buildEditableField("Email", emailController),
            _buildEditableField("Phone Number", phoneController),
            _buildEditableField("Address", addressController),
            _buildEditableField("Occupation", occupationController),
            _buildEditableField("Monthly Income", incomeController),

            const SizedBox(height: 30),

            // 🔹 Apply for Loan Button
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              icon: const Icon(Icons.attach_money, color: Colors.white),
              label: const Text(
                "Apply for Loan",
                style: TextStyle(
                    color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/loanApplication');
              },
            ),
          ],
        ),
      ),

      // 🔹 Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.info_outline), label: "About"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: "Profile"),
        ],
      ),
    );
  }

  // 🔹 Reusable editable field widget
  Widget _buildEditableField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        readOnly: !isEditing,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.grey[100],
        ),
      ),
    );
  }
}



















// import 'package:flutter/material.dart';
// import 'home_screen.dart';
// import 'about_screen.dart';
// import 'first_loan_application.dart';

// class ProfilePage extends StatelessWidget {
//   const ProfilePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // 🌈 Gradient background
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color.fromARGB(255, 27, 229, 33), // bright green
//               Color.fromARGB(255, 50, 40, 229), // deep blue
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),

//         // 🌟 Scrollable content
//         child: SafeArea(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               children: [
//                 // 🔹 AppBar-like header
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       "My Profile",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     CircleAvatar(
//                       radius: 25,
//                       backgroundColor: Colors.white,
//                       backgroundImage: AssetImage('assets/profile_pic.png'),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 25),

//                 // 🔹 Profile Information Card
//                 Card(
//                   elevation: 5,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(20),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: const [
//                         Text(
//                           "User Information",
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.green,
//                           ),
//                         ),
//                         Divider(),
//                         SizedBox(height: 10),
//                         Text("👤 Name: John Doe",
//                             style: TextStyle(fontSize: 16)),
//                         SizedBox(height: 6),
//                         Text("📧 Email: johndoe@example.com",
//                             style: TextStyle(fontSize: 16)),
//                         SizedBox(height: 6),
//                         Text("📱 Phone: +256 700 123 456",
//                             style: TextStyle(fontSize: 16)),
//                         SizedBox(height: 6),
//                         Text("🏠 Address: Kampala, Uganda",
//                             style: TextStyle(fontSize: 16)),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 25),

//                 // 🔹 Loan Info Card
//                 Card(
//                   color: Colors.white,
//                   elevation: 5,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(20),
//                     child: Column(
//                       children: const [
//                         Text(
//                           "Loan Status",
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.blue,
//                           ),
//                         ),
//                         Divider(),
//                         SizedBox(height: 10),
//                         Text(
//                           "No active loan application found.",
//                           style: TextStyle(fontSize: 16),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 25),

//                 // 🔹 Apply for Loan Button
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const LoanApplicationPage()),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green,
//                       padding: const EdgeInsets.symmetric(vertical: 14),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: const Text(
//                       "Apply for Loan",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 50),
//               ],
//             ),
//           ),
//         ),
//       ),

//       // 🔻 Bottom Navigation Bar (consistent across pages)
//       bottomNavigationBar: BottomAppBar(
//         color: Colors.white,
//         shape: const CircularNotchedRectangle(),
//         notchMargin: 6,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             IconButton(
//               icon: const Icon(Icons.home, color: Colors.green),
//               onPressed: () {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (context) => const HomePage()),
//                 );
//               },
//             ),
//             IconButton(
//               icon: const Icon(Icons.info, color: Colors.blue),
//               onPressed: () {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (context) => const AboutPage()),
//                 );
//               },
//             ),
//             IconButton(
//               icon: const Icon(Icons.person, color: Colors.black87),
//               onPressed: () {},
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
