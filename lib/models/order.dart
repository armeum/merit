import 'package:flutter/material.dart';

class Order with ChangeNotifier {

  // final String userId;
  // final String clientId;
  // final String productId;
  final int amount;
  // final bool isDelivered;
  // final DateTime orderedDate;
  final DateTime deadline;

  Order({

    // required this.userId,
    // required this.clientId,
    // required this.productId,
    required this.amount,
    // required this.isDelivered,
    // required this.orderedDate,
    required this.deadline,
  });

  // Order.fromJson(Map<String, dynamic> json) {
  //   amount = json['avatar'];
  //   name = json['name'];
  //   date = json['date'];
  //   amount = json['amount'];
  // }
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['avatar'] = avatar;
  //   data['name'] = name;
  //   data['date'] = date;
  //   data['amount'] = amount;
  //   return data;
  // }
}
