import 'asset.dart';
import 'user.dart';

class CheckoutLog {
  final int id;
  final User user;
  final Asset asset;
  final String checkoutDate;
  final String? returnDate; // The ? means it can be null (not returned yet)
  final String status;

  CheckoutLog({
    required this.id,
    required this.user,
    required this.asset,
    required this.checkoutDate,
    this.returnDate,
    required this.status,
  });

  factory CheckoutLog.fromJson(Map<String, dynamic> json) {
    return CheckoutLog(
      id: json['id'],
      user: User.fromJson(json['user']),
      asset: Asset.fromJson(json['asset']),
      checkoutDate: json['checkoutDate'],
      returnDate: json['returnDate'],
      status: json['status'],
    );
  }
}