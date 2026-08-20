import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const AssetTrackerApp());
}

class AssetTrackerApp extends StatelessWidget {
  const AssetTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IT Asset Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}