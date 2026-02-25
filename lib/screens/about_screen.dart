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
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF007BFF),
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back,
//               color: theme.appBarTheme.foregroundColor),
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
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                   color: const Color(0xFF007BFF), // keeps your original color
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             const SizedBox(height: 16),

//             Text(
//               "Magna Credit Limited is a microfinance and digital lending institution committed to providing accessible and affordable financial services to individuals and businesses across the region. We use technology to bridge the gap between people and financial opportunities.",
//               style: TextStyle(
//                 fontSize: 16,
//                 color: isDark ? Colors.white : Colors.black87,
//                 height: 1.5,
//               ),
//               textAlign: TextAlign.justify,
//             ),
//             const SizedBox(height: 20),

//             _buildCard(
//               title: "Our Vision",
//               text:
//                   "To become the most trusted and innovative financial service provider in the region, ensuring inclusive access to financial resources for all.",
//               isDark: isDark,
//             ),
//             const SizedBox(height: 20),

//             _buildCard(
//               title: "Our Mission",
//               text:
//                   "To empower individuals and businesses by offering reliable, transparent, and efficient credit solutions that meet their unique financial needs.",
//               isDark: isDark,
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
//               isDark: isDark,
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
//               isDark: isDark,
//             ),
//             const SizedBox(height: 20),

//             _buildCard(
//               title: "Contact Us",
//               text:
//                   "~ Address: Kampala, Uganda\n"
//                   "~ Phone: +256 700 123456\n"
//                   "~ Email: info@magnacredit.com\n"
//                   "~ Website: www.magnacredit.com",
//               isDark: isDark,
//             ),
//           ],
//         ),
//       ),

//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: theme.scaffoldBackgroundColor,
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         selectedItemColor: const Color(0xFF007BFF),
//         unselectedItemColor: isDark ? Colors.white54 : Colors.grey,
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
//     required bool isDark,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: isDark ? Colors.grey[900] : Colors.grey[100],
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: const Color(0xFF007BFF),
//               fontSize: 17,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             text,
//             style: TextStyle(
//               color: isDark ? Colors.white : Colors.black87,
//               fontSize: 15,
//               height: 1.5,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ✅ Reusable list-style card
//   Widget _buildListCard({
//     required String title,
//     required List<String> items,
//     required bool isDark,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: isDark ? Colors.grey[900] : Colors.grey[100],
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 17,
//               color: isDark ? Colors.white : Colors.black87,
//             ),
//           ),
//           const SizedBox(height: 8),
//           for (var item in items)
//             Padding(
//               padding: const EdgeInsets.only(bottom: 6),
//               child: Text(
//                 "• $item",
//                 style: TextStyle(
//                   color: isDark ? Colors.white : Colors.black87,
//                   fontSize: 15,
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }






import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'profile_page.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  int _selectedIndex = 1;

  static const Color _blue = Color(0xFF007BFF);
  static const Color _green = Colors.green;

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
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
      backgroundColor: isDark ? Colors.black : Colors.white,

      appBar: AppBar(
        backgroundColor: _blue,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "About Us",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

          const SizedBox(height: 20),
            // ── Blue hero header ──
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 246, 247, 247),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                ),
              ),
              child: Column(
                children: [
                  // Logo circle
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 24, 24, 236).withOpacity(0.15),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white.withOpacity(0.3)),
                    ),
                    child: const Icon(
                      Icons.account_balance_rounded,
                      color: Color.fromARGB(255, 30, 48, 238),
                      size: 36,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    "Magna Credit Limited",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                      letterSpacing: 0.3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "A microfinance & digital lending institution committed to providing accessible and affordable financial services to individuals and businesses across the region.",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black.withOpacity(0.8),
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // ── Vision & Mission side by side ──
                  Row(
                    children: [
                      Expanded(
                        child: _MiniCard(
                          icon: Icons.visibility_rounded,
                          title: "Our Vision",
                          text:
                              "To become the most trusted and innovative financial service provider in the region.",
                          color: _blue,
                          isDark: isDark,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _MiniCard(
                          icon: Icons.flag_rounded,
                          title: "Our Mission",
                          text:
                              "To empower individuals and businesses with transparent and efficient credit solutions.",
                          color: _green,
                          isDark: isDark,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // ── Loan types ──
                  _SectionCard(
                    icon: Icons.account_balance_wallet_rounded,
                    title: "Types of Loans We Offer",
                    color: _blue,
                    isDark: isDark,
                    items: const [
                      _LoanItem(icon: Icons.person_rounded,       label: "Personal Loans",   desc: "Flexible loans for urgent personal needs."),
                      _LoanItem(icon: Icons.storefront_rounded,   label: "Business Loans",   desc: "Capital support for SMEs."),
                      _LoanItem(icon: Icons.directions_car_rounded, label: "Logbook Loans",  desc: "Quick financing secured by vehicle logbooks."),
                      _LoanItem(icon: Icons.trending_up_rounded,  label: "Investment Loans", desc: "Funding for income-generating projects."),
                      _LoanItem(icon: Icons.car_rental_rounded,   label: "Car Loans",        desc: "Financial support for vehicle purchase."),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // ── Core Values ──
                  _ValuesCard(isDark: isDark),

                  const SizedBox(height: 20),

                  // ── Contact card ──
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: _green,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.22),
                          blurRadius: 18,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.contact_phone_rounded,
                                color: Colors.white, size: 20),
                            SizedBox(width: 8),
                            Text(
                              "Contact Us",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _ContactRow(icon: Icons.location_on_rounded,  text: "Kampala, Uganda"),
                        _ContactRow(icon: Icons.phone_rounded,         text: "+256 700 123456"),
                        _ContactRow(icon: Icons.email_rounded,         text: "info@magnacredit.com"),
                        _ContactRow(icon: Icons.language_rounded,      text: "www.magnacredit.com"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: _blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.info_outline), label: "About"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profile"),
        ],
      ),
    );
  }
}

// ── Mini Vision/Mission Card ──
class _MiniCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;
  final Color color;
  final bool isDark;

  const _MiniCard({
    required this.icon,
    required this.title,
    required this.text,
    required this.color,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.07),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            text,
            style: TextStyle(
              color: isDark ? Colors.white70 : Colors.black54,
              fontSize: 12,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Loan item data holder ──
class _LoanItem {
  final IconData icon;
  final String label;
  final String desc;
  const _LoanItem({required this.icon, required this.label, required this.desc});
}

// ── Section card for loans ──
class _SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final bool isDark;
  final List<_LoanItem> items;

  const _SectionCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.isDark,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.12)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.07),
            blurRadius: 16,
            offset: const Offset(0, 5),
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
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [color, Colors.green],
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 10),
              Icon(icon, color: color, size: 18),
              const SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          for (final item in items)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.08),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(item.icon, color: color, size: 16),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.label,
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black87,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          item.desc,
                          style: TextStyle(
                            color: isDark ? Colors.white54 : Colors.black45,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// ── Core Values card ──
class _ValuesCard extends StatelessWidget {
  final bool isDark;
  static const Color _blue = Color(0xFF007BFF);
  static const Color _green = Colors.green;

  const _ValuesCard({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final values = [
      _ValueTile(icon: Icons.handshake_rounded,   label: "Integrity",        color: _blue),
      _ValueTile(icon: Icons.favorite_rounded,     label: "Customer-Centered",color: _green),
      _ValueTile(icon: Icons.lightbulb_rounded,    label: "Innovation",       color: _blue),
      _ValueTile(icon: Icons.remove_red_eye_rounded,label: "Transparency",    color: _green),
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _blue.withOpacity(0.12)),
        boxShadow: [
          BoxShadow(
            color: _blue.withOpacity(0.07),
            blurRadius: 16,
            offset: const Offset(0, 5),
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
              const Icon(Icons.stars_rounded, color: _blue, size: 18),
              const SizedBox(width: 6),
              const Text(
                "Our Core Values",
                style: TextStyle(
                  color: _blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 2.8,
            children: values
                .map(
                  (v) => Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: v.color.withOpacity(0.07),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: v.color.withOpacity(0.2)),
                    ),
                    child: Row(
                      children: [
                        Icon(v.icon, color: v.color, size: 16),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            v.label,
                            style: TextStyle(
                              color: isDark ? Colors.white : Colors.black87,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _ValueTile {
  final IconData icon;
  final String label;
  final Color color;
  const _ValueTile({required this.icon, required this.label, required this.color});
}

// ── Contact Row ──
class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _ContactRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 15),
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}