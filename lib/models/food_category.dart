import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FoodCategory {
  final int id;
  final String name;
  final MaterialColor color;
  final FaIcon icon;

  FoodCategory({
    required this.id,
    required this.name,
    required this.color,
    required this.icon,
  });

  factory FoodCategory.fromJson(Map<String, dynamic> json) {
    return FoodCategory(
      id: json["id"],
      name: json["name"],
      color: json["color"],
      icon: json["icon"],
    );
  }
}
