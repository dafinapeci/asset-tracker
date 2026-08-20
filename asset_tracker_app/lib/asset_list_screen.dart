import 'package:flutter/material.dart';
import '../models/asset.dart';
import '../services/api_service.dart';

class AssetListScreen extends StatefulWidget {
  const AssetListScreen({super.key});

  @override
  State createState() => _AssetListScreenState();
}

class _AssetListScreenState extends State {
  final ApiService apiService = ApiService();
  // ignore: non_constant_identifier_names, strict_top_level_inference, prefer_typing_uninitialized_variables
  late Future<List<Asset>> futureAssets;

  @override
  void initState() {
    super.initState();
    _refreshAssets();
  }

  void _refreshAssets() {
    setState(() {
      futureAssets = apiService.getAvailableAssets();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Available Assets')),
      body: FutureBuilder<List<Asset>>(
        future: futureAssets,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No assets available right now.'));
          }

          List assets = snapshot.data!;
          return ListView.builder(
            itemCount: assets.length,
            itemBuilder: (context, index) {
              Asset asset = assets[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  leading: const Icon(Icons.laptop_mac, color: Colors.blue),
                  title: Text(asset.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Tag: ${asset.tagNumber}'),
                  trailing: ElevatedButton(
                    onPressed: () async {
                      try {
                        await apiService.checkoutAsset(asset.id);
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Asset borrowed!'), backgroundColor: Colors.green),
                        );
                        _refreshAssets();
                      } catch (e) {
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Failed to borrow asset.'), backgroundColor: Colors.red),
                        );
                      }
                    },
                    child: const Text('Borrow'),
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