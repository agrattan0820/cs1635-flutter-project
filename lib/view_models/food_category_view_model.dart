import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/food_category.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final List<FoodCategory> initialData = [
  FoodCategory(
    id: 1,
    name: "Produce",
    color: Colors.green,
    icon: const FaIcon(
      FontAwesomeIcons.appleWhole,
      size: 40,
      color: Colors.green,
    ),
  ),
  FoodCategory(
    id: 2,
    name: "Dairy",
    color: Colors.blue,
    icon: const FaIcon(
      FontAwesomeIcons.cow,
      size: 40,
      color: Colors.blue,
    ),
  ),
  FoodCategory(
    id: 3,
    name: "Meat",
    color: Colors.red,
    icon: const FaIcon(
      FontAwesomeIcons.drumstickBite,
      size: 40,
      color: Colors.red,
    ),
  ),
  FoodCategory(
    id: 4,
    name: "Baking Goods",
    color: Colors.orange,
    icon: const FaIcon(
      FontAwesomeIcons.breadSlice,
      size: 40,
      color: Colors.orange,
    ),
  ),
  FoodCategory(
    id: 5,
    name: "Seafood",
    color: Colors.purple,
    icon: const FaIcon(
      FontAwesomeIcons.fish,
      size: 40,
      color: Colors.purple,
    ),
  ),
  FoodCategory(
    id: 6,
    name: "Snacks",
    color: Colors.yellow,
    icon: const FaIcon(
      FontAwesomeIcons.cookieBite,
      size: 40,
      color: Colors.yellow,
    ),
  ),
];

class FoodCategoryViewModel with ChangeNotifier {
  final List<FoodCategory> _foodCategories = initialData;

  List<FoodCategory> get foodCategories => _foodCategories;
}
