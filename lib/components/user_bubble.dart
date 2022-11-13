import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/list_food_entry.dart';
import 'package:flutter_application_1/view_models/food_list_entry_view_model.dart';

class UserBubble extends StatelessWidget {
  final ListFoodEntry user;

  const UserBubble({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        shape: BoxShape.circle,
      ),
      child: Text(FoodListEntryViewModel.getInitials(user),
          style: const TextStyle(color: Colors.black)),
    );
  }
}
