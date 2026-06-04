import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/splash_screen.dart';
import 'screens/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeController = ThemeController();
  await themeController.loadTheme(); // ← loads saved theme before UI builds

  runApp(
    ChangeNotifierProvider.value(
      value: themeController,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<ThemeController>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Magna Credit',

      // ☀️ LIGHT THEME
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF5F8FA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF007BFF),
          foregroundColor: Colors.white,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme),
      ),

      // 🌙 DARK THEME
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
      ),

      themeMode: themeController.themeMode,
      home: const SplashScreen(),
    );
  }
}






// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'screens/splash_screen.dart';
// import 'screens/theme_controller.dart';

// void main() {
//   runApp(
//     ChangeNotifierProvider(
//       create: (_) => ThemeController(),
//       child: const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final themeController = context.watch<ThemeController>();
    

//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Magna Credit',

//       // ☀️ LIGHT THEME
//       theme: ThemeData(
//         brightness: Brightness.light,
//         scaffoldBackgroundColor: const Color(0xFFF5F8FA),
//         appBarTheme: const AppBarTheme(
//           backgroundColor: Color(0xFF007BFF),
//           foregroundColor: Colors.white,
//         ),
//       ),

//       // 🌙 DARK THEME
//       darkTheme: ThemeData(
//         brightness: Brightness.dark,
//         scaffoldBackgroundColor: Colors.black,
//         appBarTheme: const AppBarTheme(
//           backgroundColor: Colors.black,
//           foregroundColor: Colors.white,
//         ),
//       ),

//       themeMode: themeController.themeMode,
//       home: const SplashScreen(),
//     );
//   }
// }





























// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'screens/splash_screen.dart';
// import 'screens/theme_controller.dart';

// void main() {
//   runApp(
//     ChangeNotifierProvider(
//       create: (_) => ThemeController(),
//       child: const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final themeController = context.watch<ThemeController>();

//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Magna Credit',

//       themeMode: themeController.themeMode,

//       // 🌞 LIGHT THEME
//       theme: ThemeData(
//         brightness: Brightness.light,

//         // Keep your colors fixed
//         primaryColor: const Color(0xFF007BFF),   // blue
//         colorScheme: const ColorScheme.light(
//           primary: Color(0xFF007BFF),
//           secondary: Color(0xFF1BBE6D),          // green
//         ),

//         scaffoldBackgroundColor: const Color(0xFFF4F7FB),
//         appBarTheme: const AppBarTheme(
//           backgroundColor: Color(0xFF007BFF),
//           foregroundColor: Colors.white,
//         ),
//         cardColor: Colors.white,
//         dividerColor: Colors.black12,
//         shadowColor: Colors.black12,

//         textTheme: const TextTheme(
//           bodyMedium: TextStyle(color: Colors.black87),
//           bodySmall: TextStyle(color: Colors.black87),
//           titleMedium: TextStyle(color: Colors.black87),
//           headlineSmall: TextStyle(color: Colors.black87),
//         ),
//       ),

//       // 🌙 DARK THEME
//       darkTheme: ThemeData(
//         brightness: Brightness.dark,

//         // Keep your colors the same (blue + green)
//         primaryColor: const Color(0xFF007BFF),
//         colorScheme: const ColorScheme.dark(
//           primary: Color(0xFF007BFF),
//           secondary: Color(0xFF1BBE6D),
//         ),

//         scaffoldBackgroundColor: Colors.black,
//         appBarTheme: const AppBarTheme(
//           backgroundColor: Colors.black,
//           foregroundColor: Colors.white,
//         ),

//         cardColor: const Color(0xFF1A1A1A),
//         dividerColor: Colors.white24,
//         shadowColor: Colors.white12,

//         textTheme: const TextTheme(
//           bodyMedium: TextStyle(color: Colors.white70),
//           bodySmall: TextStyle(color: Colors.white70),
//           titleMedium: TextStyle(color: Colors.white70),
//           headlineSmall: TextStyle(color: Colors.white70),
//         ),
//       ),

//       home: const SplashScreen(),
//     );
//   }
// }