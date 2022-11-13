import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/food_item.dart';

final List<FoodItem> initialData = List.generate(
  10,
  (index) => FoodItem(
      id: index,
      name: "Food Item $index",
      category: "Produce",
      image:
          "https://images.unsplash.com/photo-1568702846914-96b305d2aaeb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80"),
);

class FoodItemViewModel with ChangeNotifier {
  final List<FoodItem> _foodItems = initialData;

  List<FoodItem> get foodItems => _foodItems;

  static FoodItem? getFoodItem(int id) {
    for (var item in initialData) {
      if (item.id == id) return item;
    }
    return null;
  }
}
