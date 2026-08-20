import 'package:flutter/material.dart';
import '../models/checkout_log.dart';
import '../services/api_service.dart';

class MyItemsScreen extends StatefulWidget {
  const MyItemsScreen({super.key});

  @override
  State createState() => _MyItemsScreenState();
}

class _MyItemsScreenState extends State {
  final ApiService apiService = ApiService();
  late Future<List<CheckoutLog>> futureMyItems;

  @override
  void initState() {
    super.initState();
    futureMyItems = apiService.getMyItems();
  }

  // Helper method to color-code statuses
  Color _getStatusColor(String status) {
    switch (status) {
      case 'APPROVED': return Colors.green;
      case 'PENDING': return Colors.orange;
      case 'REJECTED': return Colors.red;
      default: return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Borrowed Items')),
      body: FutureBuilder<List<CheckoutLog>>(
        future: futureMyItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('You have not requested any items yet.'));
          }

          List logs = snapshot.data!;
          return ListView.builder(
            itemCount: logs.length,
            itemBuilder: (context, index) {
              CheckoutLog log = logs[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  leading: const Icon(Icons.devices_other, color: Colors.blueAccent),
                  title: Text(log.asset.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Requested on: ${log.checkoutDate.substring(0, 10)}'),
                  trailing: Chip(
                    label: Text(log.status, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    backgroundColor: _getStatusColor(log.status),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}