import 'package:flutter/material.dart';
import 'package:grosseries/view_models/food_item_view_model.dart';

import 'food_item.dart';

class ListFoodEntry {
  final int entryId;
  final int foodId;
  String storage;
  int quantity;
  String owner;
  final DateTime dateAdded;

  ListFoodEntry({
    required this.entryId,
    required this.foodId,
    this.storage = "any",
    this.quantity = 1,
    this.owner = "",
    required this.dateAdded,
  });

  factory ListFoodEntry.fromJson(Map<String, dynamic> json) {
    return ListFoodEntry(
      entryId: json['entryId'],
      foodId: json["foodId"],
      storage: json["storage"],
      quantity: json["quantity"],
      owner: json["owner"],
      dateAdded: json["dateAdded"],
    );
  }

  Map expiration() {
    FoodItem? foodItem = FoodItemViewModel.getFoodItem(foodId);
    Duration timePassed = DateTime.now().difference(dateAdded);
    Map expirationInfo = {"text": "", "color": Colors.lightGreen};

    if (timePassed.inDays == foodItem!.daysToExpire) {
      expirationInfo["text"] = "Expires Today";
      expirationInfo["color"] = Colors.red[300];
    } else if (timePassed.inDays > foodItem.daysToExpire) {
      expirationInfo["text"] =
          "Expired by ${timePassed.inDays - foodItem.daysToExpire} ${(timePassed.inDays - foodItem.daysToExpire > 1) ? "days" : "day"}";
      expirationInfo["color"] = Colors.red[300];
    } else {
      expirationInfo["text"] =
          "${foodItem.daysToExpire - timePassed.inDays} ${(foodItem.daysToExpire - timePassed.inDays > 1) ? "days" : "day"} left";

      if (foodItem.daysToExpire - timePassed.inDays <= 3) {
        expirationInfo["color"] = Colors.amber;
      }
    }

    return expirationInfo;
  }

  @override
  String toString() {
    FoodItem? foodItem = FoodItemViewModel.getFoodItem(foodId);
    Map expirationInfo = expiration();
    return "${foodItem!.name} - ${expirationInfo['text']}\n$storage - #$quantity - $owner";
  }
}
