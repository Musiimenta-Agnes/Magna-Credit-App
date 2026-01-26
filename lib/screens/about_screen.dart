import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'profile_page.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  int _selectedIndex = 1; // index for About Page

  // 🔹 Bottom navigation logic
  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else if (index == 1) {
      // Stay on About Page
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ProfilePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF007BFF),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: theme.appBarTheme.foregroundColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "About Us",
          style: TextStyle(
            color: theme.appBarTheme.foregroundColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      backgroundColor: theme.scaffoldBackgroundColor,

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "About Magna Credit Limited",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.green, // keeps your original color
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),

            Text(
              "Magna Credit Limited is a microfinance and digital lending institution committed to providing accessible and affordable financial services to individuals and businesses across the region. We use technology to bridge the gap between people and financial opportunities.",
              style: TextStyle(
                fontSize: 16,
                color: isDark ? Colors.white : Colors.black87,
                height: 1.5,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),

            _buildCard(
              title: "Our Vision",
              text:
                  "To become the most trusted and innovative financial service provider in the region, ensuring inclusive access to financial resources for all.",
              isDark: isDark,
            ),
            const SizedBox(height: 20),

            _buildCard(
              title: "Our Mission",
              text:
                  "To empower individuals and businesses by offering reliable, transparent, and efficient credit solutions that meet their unique financial needs.",
              isDark: isDark,
            ),
            const SizedBox(height: 20),

            _buildListCard(
              title: "Types of Loans We Offer",
              items: [
                "Personal Loans — Flexible loans to meet urgent personal needs.",
                "Business Loans — Capital support for small and medium enterprises.",
                "Logbook Loans — Quick financing secured using vehicle logbooks.",
                "Investment Loans — Funding to grow income-generating projects.",
                "Car Loans — Financial support for vehicle purchase.",
              ],
              isDark: isDark,
            ),
            const SizedBox(height: 20),

            _buildListCard(
              title: "Our Core Values",
              items: [
                "Integrity — We are honest and fair in all our dealings.",
                "Customer-Centered — Your satisfaction drives our success.",
                "Innovation — We embrace technology to simplify your experience.",
                "Transparency — We ensure clarity in all our processes.",
              ],
              isDark: isDark,
            ),
            const SizedBox(height: 20),

            _buildCard(
              title: "Contact Us",
              text:
                  "📍 Address: Kampala, Uganda\n"
                  "📞 Phone: +256 700 123456\n"
                  "✉️ Email: info@magnacredit.com\n"
                  "🌐 Website: www.magnacredit.com",
              isDark: isDark,
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color(0xFF007BFF),
        unselectedItemColor: isDark ? Colors.white54 : Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: "About",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  // ✅ Reusable simple text card
  Widget _buildCard({
    required String title,
    required String text,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF007BFF),
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black87,
              fontSize: 15,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Reusable list-style card
  Widget _buildListCard({
    required String title,
    required List<String> items,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          for (var item in items)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                "• $item",
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black87,
                  fontSize: 15,
                ),
              ),
            ),
        ],
      ),
    );
  }
}












// import 'package:flutter/material.dart';
// import 'home_screen.dart';
// import 'profile_page.dart';

// class AboutPage extends StatefulWidget {
//   const AboutPage({super.key});

//   @override
//   State<AboutPage> createState() => _AboutPageState();
// }

// class _AboutPageState extends State<AboutPage> {
//   int _selectedIndex = 1; // index for About Page

//   // 🔹 Bottom navigation logic
//   void _onItemTapped(int index) {
//     setState(() => _selectedIndex = index);

//     if (index == 0) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const HomePage()),
//       );
//     } else if (index == 1) {
//       // Stay on About Page
//     } else if (index == 2) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const ProfilePage()),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // 📌 Use theme data here
//     final theme = Theme.of(context);

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: theme.primaryColor,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: theme.appBarTheme.foregroundColor),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: Text(
//           "About Us",
//           style: TextStyle(
//             color: theme.appBarTheme.foregroundColor,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//       ),

//       backgroundColor: theme.scaffoldBackgroundColor,

//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(18.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//               child: Text(
//                 "About Magna Credit Limited",
//                 style: theme.textTheme.titleLarge?.copyWith(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.green,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             const SizedBox(height: 16),

//             Text(
//               "Magna Credit Limited is a microfinance and digital lending institution committed to providing accessible and affordable financial services to individuals and businesses across the region. We use technology to bridge the gap between people and financial opportunities.",
//               style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
//               textAlign: TextAlign.justify,
//             ),
//             const SizedBox(height: 20),

//             _buildCard(
//               title: "Our Vision",
//               text: "To become the most trusted and innovative financial service provider in the region, ensuring inclusive access to financial resources for all.",
//               theme: theme,
//             ),
//             const SizedBox(height: 20),

//             _buildCard(
//               title: "Our Mission",
//               text: "To empower individuals and businesses by offering reliable, transparent, and efficient credit solutions that meet their unique financial needs.",
//               theme: theme,
//             ),
//             const SizedBox(height: 20),

//             _buildListCard(
//               title: "Types of Loans We Offer",
//               items: [
//                 "Personal Loans — Flexible loans to meet urgent personal needs.",
//                 "Business Loans — Capital support for small and medium enterprises.",
//                 "Logbook Loans — Quick financing secured using vehicle logbooks.",
//                 "Investment Loans — Funding to grow income-generating projects.",
//                 "Car Loans — Financial support for vehicle purchase.",
//               ],
//               theme: theme,
//             ),
//             const SizedBox(height: 20),

//             _buildListCard(
//               title: "Our Core Values",
//               items: [
//                 "Integrity — We are honest and fair in all our dealings.",
//                 "Customer-Centered — Your satisfaction drives our success.",
//                 "Innovation — We embrace technology to simplify your experience.",
//                 "Transparency — We ensure clarity in all our processes.",
//               ],
//               theme: theme,
//             ),
//             const SizedBox(height: 20),

//             _buildCard(
//               title: "Contact Us",
//               text: "📍 Address: Kampala, Uganda\n"
//                   "📞 Phone: +256 700 123456\n"
//                   "✉️ Email: info@magnacredit.com\n"
//                   "🌐 Website: www.magnacredit.com",
//               theme: theme,
//             ),
//           ],
//         ),
//       ),

//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: theme.bottomAppBarColor,
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         selectedItemColor: theme.primaryColor,
//         unselectedItemColor: theme.disabledColor,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: "Home",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.info_outline),
//             label: "About",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person_outline),
//             label: "Profile",
//           ),
//         ],
//       ),
//     );
//   }

//   // ✅ Reusable simple text card
//   Widget _buildCard({
//     required String title,
//     required String text,
//     required ThemeData theme,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: theme.cardColor,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: theme.textTheme.titleMedium?.copyWith(
//               fontWeight: FontWeight.bold,
//               color: theme.primaryColor,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             text,
//             style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
//           ),
//         ],
//       ),
//     );
//   }

//   // ✅ Reusable list-style card
//   Widget _buildListCard({
//     required String title,
//     required List<String> items,
//     required ThemeData theme,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: theme.cardColor,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: theme.textTheme.titleMedium?.copyWith(
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 8),
//           for (var item in items)
//             Padding(
//               padding: const EdgeInsets.only(bottom: 6),
//               child: Text(
//                 "• $item",
//                 style: theme.textTheme.bodyMedium,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// extension on ThemeData {
//   Color? get bottomAppBarColor => null;
// }














// import 'package:flutter/material.dart';
// import 'home_screen.dart';
// import 'profile_page.dart';

// class AboutPage extends StatefulWidget {
//   const AboutPage({super.key});

//   @override
//   State<AboutPage> createState() => _AboutPageState();
// }

// class _AboutPageState extends State<AboutPage> {
//   int _selectedIndex = 1; // index for About Page

//   // 🔹 Bottom navigation logic
//   void _onItemTapped(int index) {
//     setState(() => _selectedIndex = index);

//     if (index == 0) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const HomePage()),
//       );
//     } else if (index == 1) {
//       // Stay on About Page
//     } else if (index == 2) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const ProfilePage()),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF007BFF),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: const Text(
//           "About Us",
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//       ),

//       backgroundColor: Colors.white,

//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(18.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Center(
//               child: Text(
//                 "About Magna Credit Limited",
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.green,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             const SizedBox(height: 16),

//             const Text(
//               "Magna Credit Limited is a microfinance and digital lending institution committed to providing accessible and affordable financial services to individuals and businesses across the region. We use technology to bridge the gap between people and financial opportunities.",
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.black87,
//                 height: 1.5,
//               ),
//               textAlign: TextAlign.justify,
//             ),
//             const SizedBox(height: 20),

//             _buildCard(
//               "Our Vision",
//               "To become the most trusted and innovative financial service provider in the region, ensuring inclusive access to financial resources for all.",
//             ),
//             const SizedBox(height: 20),

//             _buildCard(
//               "Our Mission",
//               "To empower individuals and businesses by offering reliable, transparent, and efficient credit solutions that meet their unique financial needs.",
//             ),
//             const SizedBox(height: 20),

//             // ✅ NEW SECTION — TYPES OF LOANS
//             _buildListCard(
//               "Types of Loans We Offer",
//               [
//                 "Personal Loans — Flexible loans to meet urgent personal needs.",
//                 "Business Loans — Capital support for small and medium enterprises.",
//                 "Logbook Loans — Quick financing secured using vehicle logbooks.",
//                 "Investment Loans — Funding to grow income-generating projects.",
//                 "Car Loans — Financial support for vehicle purchase.",
//               ],
//             ),
//             const SizedBox(height: 20),

//             _buildListCard(
//               "Our Core Values",
//               [
//                 "Integrity — We are honest and fair in all our dealings.",
//                 "Customer-Centered — Your satisfaction drives our success.",
//                 "Innovation — We embrace technology to simplify your experience.",
//                 "Transparency — We ensure clarity in all our processes.",
//               ],
//             ),
//             const SizedBox(height: 20),

//             _buildCard(
//               "Contact Us",
//               "📍 Address: Kampala, Uganda\n"
//               "📞 Phone: +256 700 123456\n"
//               "✉️ Email: info@magnacredit.com\n"
//               "🌐 Website: www.magnacredit.com",
//             ),
//           ],
//         ),
//       ),

//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: Colors.white,
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         selectedItemColor: Colors.green,
//         unselectedItemColor: Colors.grey,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: "Home",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.info_outline),
//             label: "About",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person_outline),
//             label: "Profile",
//           ),
//         ],
//       ),
//     );
//   }

//   // ✅ Reusable simple text card
//   Widget _buildCard(String title, String text) {
//     return Container(
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: Colors.grey[100],
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Colors.blueAccent,
//               fontSize: 17,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             text,
//             style: const TextStyle(
//               color: Colors.black87,
//               fontSize: 15,
//               height: 1.5,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ✅ Reusable list-style card
//   Widget _buildListCard(String title, List<String> items) {
//     return Container(
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: Colors.grey[100],
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Colors.black87,
//               fontSize: 17,
//             ),
//           ),
//           const SizedBox(height: 8),
//           for (var item in items)
//             Padding(
//               padding: const EdgeInsets.only(bottom: 6),
//               child: Text(
//                 "• $item",
//                 style: const TextStyle(color: Colors.black87, fontSize: 15),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

