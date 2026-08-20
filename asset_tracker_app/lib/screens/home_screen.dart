import 'package:flutter/material.dart';
import '../asset_list_screen.dart'; // 1. This tells the home screen where to find your list
import 'admin_screen.dart'; // 1. This tells the home screen where to find your admin screen
import '../screens/my_items_screen.dart'; // 1. This tells the home screen where to find your my items screen

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IT Asset Tracker'),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.devices, size: 80, color: Colors.blueAccent),
            const SizedBox(height: 20),
            const Text(
              'Welcome to Asset Tracker',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text('API connected!'),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // 2. This is the magic that moves the user to the next screen!
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AssetListScreen()),
                );
              },
              child: const Text('View Available Assets'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent, foregroundColor: Colors.white),
              onPressed: () {
                // 2. This is the magic that moves the user to the next screen!
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AdminScreen()),
                );
              },
              child: const Text('Admin Dashboard'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyItemsScreen()),
                );
              },
              child: const Text('My Items & Status'),
            ),
          ],
        ),
      ),
    );
  }
}