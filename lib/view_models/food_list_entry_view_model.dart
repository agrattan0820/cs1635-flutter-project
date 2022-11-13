import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/list_food_entry.dart';

final List<ListFoodEntry> initialData = List.generate(
  10,
  (index) => ListFoodEntry(
    name: "Food Item $index",
    storage: "Fridge",
    quantity: 3,
    owner: "Jennifer Zheng",
    expirationDate: DateTime.now().subtract(const Duration(days: 5)),
  ),
);

class FoodListEntryViewModel with ChangeNotifier {
  final List<ListFoodEntry> _foodItems = initialData;

  List<ListFoodEntry> get foodItems => _foodItems;

  void addFoodItemEntry(String name, String storage, int quantity, String owner,
      DateTime expirationDate) {
    _foodItems.add(
      ListFoodEntry(
        name: name,
        storage: storage,
        quantity: quantity,
        owner: owner,
        expirationDate: expirationDate,
      ),
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
    var expirationDate = listFoodEntry.expirationDate;
    var dateDifference = expirationDate.difference(DateTime.now());

    int daysLeft = dateDifference.inDays;

    if (dateDifference.isNegative) {
      daysLeft = dateDifference.inDays * -1;

      if (daysLeft > 1) {
        return "Expired $daysLeft Days Ago";
      }
      return "Expired $daysLeft Day Ago";
    }

    if (dateDifference.inDays == 0) {
      return "Expires Today";
    }

    return "$daysLeft days left";
  }
}
