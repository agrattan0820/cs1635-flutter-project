import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/models/food_item.dart';

final _random = Random();

/// Generates a positive random integer uniformly distributed on the range
/// from [min], inclusive, to [max], exclusive.
int next(int min, int max) => min + _random.nextInt(max - min);

final List<FoodItem> initialData = List.generate(
  10,
  (index) => FoodItem(
      id: index,
      name: "Food Item $index",
      category: next(0, 5),
      image:
          "https://images.unsplash.com/photo-1568702846914-96b305d2aaeb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80"),
);

class FoodItemViewModel with ChangeNotifier {
  final List<FoodItem> _foodItems = initialData;

  FoodItem? _selectedFoodItem;

  List<FoodItem> get foodItems => _foodItems;

  FoodItem? get selectedFoodItem => _selectedFoodItem;

  void updateSelectedFoodItem(FoodItem item) {
    _selectedFoodItem = item;
    if (kDebugMode) {
      print('Updated selected food item is ${_selectedFoodItem?.name}');
    }
    notifyListeners();
  }

  static FoodItem? getFoodItem(int id) {
    for (var item in initialData) {
      if (item.id == id) return item;
    }
    return null;
  }
}
