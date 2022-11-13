import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/list_food_entry.dart';

final List<ListFoodEntry> initialData = List.generate(
  10,
  (index) => ListFoodEntry(
      name: "Food Item $index",
      storage: "Fridge",
      quantity: 3,
      owner: "Jennifer Zheng",
      daysToExpire: 2),
);

class FoodListEntryViewModel with ChangeNotifier {
  final List<ListFoodEntry> _foodItems = initialData;

  List<ListFoodEntry> get foodItems => _foodItems;

  void addFoodItemEntry(String name, String storage, int quantity, String owner,
      int daysToExpire) {
    _foodItems.add(
      ListFoodEntry(
          name: name,
          storage: storage,
          quantity: quantity,
          owner: owner,
          daysToExpire: daysToExpire),
    );
  }

  static String getInitials(ListFoodEntry listFoodEntry) {
    var buffer = StringBuffer();
    var split = listFoodEntry.owner.split(' ');
    for (var i = 0; i < split.length; i++) {
      buffer.write(split[i][0].toUpperCase());
    }

    return buffer.toString();
  }

  static String expirationString(ListFoodEntry listFoodEntry) {
    var daysLeft = listFoodEntry.daysToExpire;
    if (daysLeft == 0) {
      return "Expires Today";
    }

    if (daysLeft < 0) {
      daysLeft = daysLeft * -1;
      return "Expired $daysLeft Day Ago";
    }

    return "$daysLeft days left";
  }
}
