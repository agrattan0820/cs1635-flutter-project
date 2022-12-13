import 'package:flutter/material.dart';
import 'package:grosseries/components/notifications.dart';
import 'package:grosseries/components/utilities.dart';
import 'dart:math';
import 'package:grosseries/models/list_food_entry.dart';
import 'package:grosseries/models/food_item.dart';
import 'package:grosseries/view_models/food_item_view_model.dart';

final Random _random = Random();
const int max = 1000000000;

final List<ListFoodEntry> initialData = List.generate(
  10,
  (index) => ListFoodEntry(
    entryId: _random.nextInt(max),
    foodId: index,
    storage: "Fridge",
    quantity: 3,
    owner: "alex@grattan.me",
    dateAdded: index == 0
        ? DateTime.now().subtract(const Duration(days: 12))
        : DateTime.now(),
  ),
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

  Future<void> addFoodItemEntry(
    int id,
    String storage,
    int quantity,
    String owner,
    DateTime dateAdded,
    bool? addNotification,
    int? notificationDayAmount,
  ) async {
    ListFoodEntry entry = ListFoodEntry(
      entryId: _random.nextInt(max),
      foodId: id,
      storage: storage,
      quantity: quantity,
      owner: owner,
      dateAdded: dateAdded,
    );

    // Add entry to overall list
    _foodItems.add(entry);

    if (addNotification == true) {
      // Get relevant food item
      FoodItem? foodItem = getFoodItem(id);

      // Add days to expire to current day to get day of reminder
      DateTime dayOfReminder = dateAdded
          .add(Duration(days: foodItem!.daysToExpire + notificationDayAmount!));
      debugPrint(dayOfReminder.toIso8601String());

      // Determine particular day and time we want notification
      NotificationDay notificationSchedule = NotificationDay(
        day: dayOfReminder.day,
        month: dayOfReminder.month,
        year: dayOfReminder.year,
        timeOfDay: const TimeOfDay(hour: 10, minute: 0),
      );

      // Schedule notification
      await createFoodExpireReminderNotification(
        entry,
        foodItem,
        notificationSchedule,
      );
    }

    notifyListeners();
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
