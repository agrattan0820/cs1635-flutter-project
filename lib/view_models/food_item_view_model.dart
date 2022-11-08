import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/food_item.dart';

final List<FoodItem> initialData = List.generate(
  10,
  (index) =>
      FoodItem(name: "Food Item $index", category: "Produce", image: "image"),
);

class FoodItemViewModel with ChangeNotifier {
  final List<FoodItem> _foodItems = initialData;

  List<FoodItem> get foodItems => _foodItems;
}
