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
    return Scaffold(
      // ✅ App Bar with centered title
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "About Us",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      // ✅ Plain white background
      backgroundColor: Colors.white,

      // ✅ Scrollable content
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Title
            const Center(
              child: Text(
                "About Magna Credit Limited",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),

            // 🔹 Company Overview
            const Text(
              "Magna Credit Limited is a microfinance and digital lending institution committed to providing accessible and affordable financial services to individuals and businesses across the region. We use technology to bridge the gap between people and financial opportunities.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                height: 1.5,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),

            // 🔹 Our Vision
            _buildCard(
              "Our Vision",
              "To become the most trusted and innovative financial service provider in the region, ensuring inclusive access to financial resources for all.",
            ),
            const SizedBox(height: 20),

            // 🔹 Our Mission
            _buildCard(
              "Our Mission",
              "To empower individuals and businesses by offering reliable, transparent, and efficient credit solutions that meet their unique financial needs.",
            ),
            const SizedBox(height: 20),

            // 🔹 Core Values
            _buildListCard(
              "Our Core Values",
              [
                "Integrity — We are honest and fair in all our dealings.",
                "Customer-Centered — Your satisfaction drives our success.",
                "Innovation — We embrace technology to simplify your experience.",
                "Transparency — We ensure clarity in all our processes.",
              ],
            ),
            const SizedBox(height: 20),

            // 🔹 Contact Info
            _buildCard(
              "Contact Us",
              " Address: Kampala, Uganda\n📞 Phone: +256 700 123456\n✉️ Email: info@magnacredit.com\n🌐 Website: www.magnacredit.com",
            ),
          ],
        ),
      ),

      // ✅ Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
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
  Widget _buildCard(String title, String text) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 15,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Reusable list-style card
  Widget _buildListCard(String title, List<String> items) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 8),
          for (var item in items)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                "• $item",
                style: const TextStyle(color: Colors.black87, fontSize: 15),
              ),
            ),
        ],
      ),
    );
  }
}
