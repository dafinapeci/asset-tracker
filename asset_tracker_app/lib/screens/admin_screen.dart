import 'package:flutter/material.dart';
import '../models/checkout_log.dart';
import '../services/api_service.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State createState() => _AdminScreenState();
}

class _AdminScreenState extends State {
  final ApiService apiService = ApiService();
  late Future<List<CheckoutLog>> futurePendingLogs;

  @override
  void initState() {
    super.initState();
    _refreshLogs();
  }

  void _refreshLogs() {
    setState(() {
      futurePendingLogs = apiService.getPendingCheckouts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Approval Dashboard'),
        backgroundColor: Colors.deepPurple,
      ),
      body: FutureBuilder<List<CheckoutLog>>(
        future: futurePendingLogs,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No pending requests! You are all caught up.'));
          }

          List logs = snapshot.data!;
          return ListView.builder(
            itemCount: logs.length,
            itemBuilder: (context, index) {
              CheckoutLog log = logs[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  leading: const Icon(Icons.person, color: Colors.deepPurple),
                  title: Text(log.asset.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Requested by: ${log.user.name}\nDate: ${log.checkoutDate}'),
                  isThreeLine: true,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.check_circle, color: Colors.green),
                        onPressed: () async {
                          try {
                            await apiService.approveCheckout(log.id);
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Request Approved!'), backgroundColor: Colors.green),
                            );
                            _refreshLogs(); // Refresh to remove it from the pending list
                          } catch (e) {
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Error approving request'), backgroundColor: Colors.red),
                            );
                          }

                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.cancel, color: Colors.red),
                        onPressed: () async {
                          try {
                            await apiService.rejectCheckout(log.id);
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Request Rejected!'), backgroundColor: Colors.red),
                            );
                            _refreshLogs(); // Refresh to remove it from the pending list
                          } catch (e) {
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Error rejecting request'), backgroundColor: Colors.red),
                            );
                          }
                        },
                      ),
                    ],
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