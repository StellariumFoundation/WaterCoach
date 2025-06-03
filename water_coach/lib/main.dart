import 'package:flutter/material.dart';
import 'package:water_coach/water_coach_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Water Coach',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue), // Use color scheme from seed
        useMaterial3: true,
        textTheme: const TextTheme( // Example of customizing text theme
          displaySmall: TextStyle(fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
          labelLarge: TextStyle(fontSize: 16.0),
        )
      ),
      darkTheme: ThemeData( // Add a basic dark theme
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.dark),
        useMaterial3: true,
         textTheme: const TextTheme(
          displaySmall: TextStyle(fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
          labelLarge: TextStyle(fontSize: 16.0),
        )
      ),
      themeMode: ThemeMode.system, // Respect system theme settings
      home: const WaterCoachPage(),
      debugShowCheckedModeBanner: false, // Remove debug banner
    );
  }
}
