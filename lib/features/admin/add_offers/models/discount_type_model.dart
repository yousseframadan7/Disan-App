import 'package:flutter/material.dart';

class DiscountTypeModel {
  final String title;
  final String description;
  final IconData icon;
  final String keyValue;

  const DiscountTypeModel({
    required this.title,
    required this.description,
    required this.icon,
    required this.keyValue,
  });
}
