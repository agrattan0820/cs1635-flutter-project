import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_application_1/models/list_food_entry.dart';
import 'package:flutter_application_1/models/food_item.dart';
import 'package:flutter_application_1/view_models/food_item_view_model.dart';

final Random _random = Random();
const int max = 1000000000;

final List<ListFoodEntry> initialData = List.generate(
  10,
  (index) => ListFoodEntry(
      entryId: _random.nextInt(max),
      foodId: index,
      storage: "Fridge",
      quantity: 3,
      owner: "Jennifer Zheng",
      dateAdded: DateTime.now()),
);

class FoodListEntryViewModel with ChangeNotifier {
  final List<ListFoodEntry> _foodItems = initialData;

  int _sortOptionChoice = 0;
  final List<String> _sortOptionsList = ['Expiration', 'Name', 'Newest'];
  final List<String> _categoryFilters = [];
  final List<String> _userFilters = [];
  final List<String> _categoryOptions = [
    "Produce",
    "Dairy",
    "Meat",
    "Baking Goods",
    "Seafood",
    "Snacks"
  ];
  final List<String> _userOptions = [
    "Alexander Grattan",
    "Crystal Li",
    "Jennifer Zheng"
  ];

  List<ListFoodEntry> get foodItems => _foodItems;
  int get sortOptionChoice => _sortOptionChoice;
  List<String> get sortOptionsList => _sortOptionsList;
  List<String> get categoryFilters => _categoryFilters;
  List<String> get userFilters => _userFilters;
  List<String> get categoryOptions => _categoryOptions;
  List<String> get userOptions => _userOptions;

  set quantity(int q) => {quantity = q};

  FoodItem? getFoodItem(foodId) {
    return FoodItemViewModel.getFoodItem(foodId);
  }

  ListFoodEntry? getListFoodEntry(int entryId) {
    for (var item in initialData) {
      if (item.entryId == entryId) return item;
    }
    return null;
  }

  void addFoodItemEntry(
      int id, String storage, int quantity, String owner, DateTime dateAdded) {
    _foodItems.add(
      ListFoodEntry(
        entryId: _random.nextInt(max),
        foodId: id,
        storage: storage,
        quantity: quantity,
        owner: owner,
        dateAdded: dateAdded,
      ),
    );
  }

  void removeFoodItemEntry(int entryId) {
    for (int i = 0; i < _foodItems.length; i++) {
      if (_foodItems[i].entryId == entryId) {
        _foodItems.removeAt(i);
        notifyListeners();

        break;
      }
    }
  }

  String expirationString(int entryId) {
    ListFoodEntry? listFoodEntry = getListFoodEntry(entryId);
    FoodItem? foodItem = FoodItemViewModel.getFoodItem(listFoodEntry!.foodId);
    Duration timePassed = DateTime.now().difference(listFoodEntry.dateAdded);

    if (timePassed.inDays == foodItem!.daysToExpire) {
      return "Expires Today";
    }

    if (timePassed.inDays > foodItem.daysToExpire) {
      return "Expired by ${timePassed.inDays - foodItem.daysToExpire} Day";
    }

    if (foodItem.daysToExpire - timePassed.inDays > 1) {
      return "${foodItem.daysToExpire - timePassed.inDays} days left";
    } else {
      return "${foodItem.daysToExpire - timePassed.inDays} day left";
    }
  }

  void onOptionSelect(bool value, int index) {
    _sortOptionChoice = value ? index : sortOptionChoice;
    debugPrint("sortOptionChoice $sortOptionChoice");
    notifyListeners();
  }

  void onCategorySelect(bool value, int index) {
    if (value) {
      _categoryFilters.add(_categoryOptions[index]);
    } else {
      _categoryFilters.removeWhere((String filter) {
        return filter == _categoryOptions[index];
      });
    }
    notifyListeners();
  }

  void onUserSelect(bool value, int index) {
    if (value) {
      _userFilters.add(_userOptions[index]);
    } else {
      _userFilters.removeWhere((String filter) {
        return filter == _userOptions[index];
      });
    }
    notifyListeners();
  }
}
