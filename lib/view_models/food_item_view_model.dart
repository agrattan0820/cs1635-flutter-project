import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/models/food_item.dart';

final _random = Random();

/// Generates a positive random integer uniformly distributed on the range
/// from [min], inclusive, to [max], exclusive.
int next(int min, int max) => min + _random.nextInt(max - min);

// final List<FoodItem> initialData = List.generate(
//   10,
//   (index) => FoodItem(
//     id: index,
//     name: "Food Item $index",
//     category: next(0, 5),
//     image: "assets/food-items/apple.jpeg",
//   ),
// );

final List<FoodItem> initialData = [
  FoodItem(
    id: 0,
    name: "Apple",
    category: 0,
    image: "assets/food-items/apple.jpeg",
    daysToExpire: 12,
  ),
  FoodItem(
    id: 1,
    name: "Honey Ham",
    category: 2,
    image: "assets/food-items/honey_ham.jpeg",
    daysToExpire: 9,
  ),
  FoodItem(
    id: 2,
    name: "Whole Milk",
    category: 1,
    image: "assets/food-items/whole_milk.jpeg",
    daysToExpire: 8,
  ),
  FoodItem(
    id: 3,
    name: "Bread",
    category: 3,
    image: "assets/food-items/bread.jpg",
    daysToExpire: 10,
  ),
  FoodItem(
    id: 4,
    name: "Cereal",
    category: 5,
    image: "assets/food-items/cereal.jpeg",
    daysToExpire: 120,
  ),
  FoodItem(
    id: 5,
    name: "Salmon",
    category: 4,
    image: "assets/food-items/salmon.jpeg",
    daysToExpire: 5,
  ),
  FoodItem(
    id: 6,
    name: "Fish Sticks",
    category: 4,
    image: "assets/food-items/fish_sticks.jpeg",
    daysToExpire: 120,
  ),
  FoodItem(
    id: 7,
    name: "Butter",
    category: 1,
    image: "assets/food-items/butter.jpeg",
    daysToExpire: 30,
  ),
  FoodItem(
    id: 8,
    name: "Ground Beef",
    category: 2,
    image: "assets/food-items/ground_beef.jpeg",
    daysToExpire: 4,
  ),
  FoodItem(
    id: 9,
    name: "Broccoli",
    category: 0,
    image: "assets/food-items/broccoli.jpeg",
    daysToExpire: 7,
  ),
  FoodItem(
    id: 10,
    name: "Tomato",
    category: 0,
    image: "assets/food-items/tomato.jpeg",
    daysToExpire: 7,
  ),
  FoodItem(
    id: 11,
    name: "Potato Chip",
    category: 5,
    image: "assets/food-items/potato_chip.jpeg",
    daysToExpire: 120,
  ),
  FoodItem(
    id: 12,
    name: "Banana",
    category: 0,
    image: "assets/food-items/banana.jpeg",
    daysToExpire: 8,
  ),
  FoodItem(
    id: 13,
    name: "Shrimp",
    category: 4,
    image: "assets/food-items/shrimp.jpeg",
    daysToExpire: 30,
  ),
];

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
