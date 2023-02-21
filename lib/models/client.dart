import 'package:flutter/material.dart';

class Client with ChangeNotifier {
  final String id;
  final String name;
  final String region;

  Client({
    required this.id,
    required this.name,
    required this.region,
  });
}
