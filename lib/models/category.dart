import 'package:flutter/material.dart';

class Category with ChangeNotifier {
  final String id;
  final String title;
  final  onPressed;

  Category({
    required this.id,
    required this.title,
    required this.onPressed
  });
}
