import 'package:flutter/material.dart';

class Order with ChangeNotifier {
  final String id;
  final String userId;
  final String clientId;
  final String productId;
  final int amount;
  final bool isDelivered;
  final DateTime orderedDate;
  final DateTime deadline;

  Order({
    required this.id,
    required this.userId,
    required this.clientId,
    required this.productId,
    required this.amount,
    required this.isDelivered,
    required this.orderedDate,
    required this.deadline,
  });
}
