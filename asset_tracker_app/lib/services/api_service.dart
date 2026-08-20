import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import '../models/asset.dart';
import "../models/checkout_log.dart";

class ApiService {
  // 10.0.2.2 is the Android Emulator's bridge to your computer's localhost
  static const String baseUrl = 'http://10.0.2.2:8080/api';

  Future<List<Asset>> getAvailableAssets() async {
    final response = await http.get(Uri.parse('$baseUrl/assets?status=AVAILABLE'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Asset.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load assets: ${response.statusCode}');
    }
  }

  Future<bool> checkoutAsset(int assetId) async {
    // Note: We use userId: 1 assuming you created a user with ID 1 in Postgres
    final response = await http.post(
      Uri.parse('$baseUrl/checkouts'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'userId': 1, 
        'assetId': assetId,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Checkout failed. Server responded with: ${response.statusCode}');
    }
  }

  Future<List<CheckoutLog>> getPendingCheckouts() async {
    final response = await http.get(Uri.parse('$baseUrl/checkouts'));

    if (response.statusCode == 200) {
      List body = jsonDecode(response.body);
      // Map JSON to Dart objects, then filter only the PENDING requests
      return body
          .map((dynamic item) => CheckoutLog.fromJson(item))
          .where((log) => log.status == 'PENDING')
          .toList();
    } else {
      throw Exception('Failed to load pending checkouts');
    }
  }

  Future approveCheckout(int checkoutId) async {
    final response = await http.put(Uri.parse('$baseUrl/checkouts/$checkoutId/approve'));
    if (response.statusCode != 200) {
      throw Exception('Failed to approve checkout');
    }
  }

  Future rejectCheckout(int checkoutId) async {
    final response = await http.put(Uri.parse('$baseUrl/checkouts/$checkoutId/reject'));
    if (response.statusCode != 200) {
      throw Exception('Failed to reject checkout');
    }
  }

  Future<List<CheckoutLog>> getMyItems() async {
    // Fetching items specifically for User ID 1
    final response = await http.get(Uri.parse('$baseUrl/checkouts/user/1'));

    if (response.statusCode == 200) {
      List body = jsonDecode(response.body);
      return body.map((dynamic item) => CheckoutLog.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load your items');
    }
  }
}