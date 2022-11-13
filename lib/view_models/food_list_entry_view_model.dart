import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/list_food_entry.dart';
import 'package:flutter_application_1/models/food_item.dart';
import 'package:flutter_application_1/view_models/food_item_view_model.dart';

final List<ListFoodEntry> initialData = List.generate(
  10,
  (index) => ListFoodEntry(
      id: index,
      storage: "Fridge",
      quantity: 3,
      owner: "Jennifer Zheng",
      dateAdded: DateTime.now()),
);

class FoodListEntryViewModel with ChangeNotifier {
  final List<ListFoodEntry> _foodItems = initialData;

  List<ListFoodEntry> get foodItems => _foodItems;

  static FoodItem? getFoodItem(id) {
    return FoodItemViewModel.getFoodItem(id);
  }

  static String getInitials(ListFoodEntry listFoodEntry) {
    var buffer = StringBuffer();
    var split = listFoodEntry.owner.split(' ');
    for (var i = 0; i < split.length; i++) {
      buffer.write(split[i][0].toUpperCase());
    }

    return buffer.toString();
  }

  static String expirationString(int id) {
    var foodItem = FoodItemViewModel.getFoodItem(id);
    var daysLeft = foodItem?.daysToExpire;
    if (daysLeft == 0) {
      return "Expires Today";
    }

    if (daysLeft! < 0) {
      daysLeft = daysLeft * -1;
      return "Expired $daysLeft Day Ago";
    }

    return "$daysLeft days left";
  }
}
