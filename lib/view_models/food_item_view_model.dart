import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/models/food_item.dart';

final List<FoodItem> initialData = List.generate(
  10,
  (index) => FoodItem(
      id: index, name: "Food Item $index", category: "Produce", image: "image"),
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
}
