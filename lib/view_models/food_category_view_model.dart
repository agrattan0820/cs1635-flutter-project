import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/food_category.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final List<FoodCategory> initialData = [
  FoodCategory(
    name: "Produce",
    color: Colors.green,
    icon: const FaIcon(
      FontAwesomeIcons.appleWhole,
      size: 48,
      color: Colors.green,
    ),
  ),
  FoodCategory(
    name: "Dairy",
    color: Colors.blue,
    icon: const FaIcon(
      FontAwesomeIcons.cow,
      size: 48,
      color: Colors.blue,
    ),
  ),
  FoodCategory(
    name: "Meat",
    color: Colors.red,
    icon: const FaIcon(
      FontAwesomeIcons.drumstickBite,
      size: 48,
      color: Colors.red,
    ),
  ),
  FoodCategory(
    name: "Baking Goods",
    color: Colors.orange,
    icon: const FaIcon(
      FontAwesomeIcons.breadSlice,
      size: 48,
      color: Colors.orange,
    ),
  ),
  FoodCategory(
    name: "Seafood",
    color: Colors.purple,
    icon: const FaIcon(
      FontAwesomeIcons.fish,
      size: 48,
      color: Colors.purple,
    ),
  ),
  FoodCategory(
    name: "Snacks",
    color: Colors.yellow,
    icon: const FaIcon(
      FontAwesomeIcons.cookieBite,
      size: 48,
      color: Colors.yellow,
    ),
  ),
];

class FoodCategoryViewModel with ChangeNotifier {
  final List<FoodCategory> _foodCategories = initialData;

  List<FoodCategory> get foodCategories => _foodCategories;
}
