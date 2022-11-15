import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/tag.dart';
import 'package:flutter_application_1/components/user_bubble.dart';
import 'package:flutter_application_1/models/list_food_entry.dart';
import 'package:flutter_application_1/view_models/food_list_entry_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class FoodItemRow extends StatelessWidget {
  final List<ListFoodEntry> foodItems;
  final int index;

  const FoodItemRow({super.key, required this.foodItems, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: InkWell(
            onTap: () {
              GoRouter.of(context).go("/item_details/$index");
            },
            child: Container(
                margin: const EdgeInsets.only(top: 8, bottom: 8),
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                    color: Color(0xD6D6D6D6),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        "${foodItems[index].quantity.toString()}x ${context.read<FoodListEntryViewModel>().getFoodItem(foodItems[index].id)!.name}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black),
                      ),
                    ),
                    UserBubble(user: foodItems[index]),
                    Tag(
                        text: context
                            .read<FoodListEntryViewModel>()
                            .expirationString(foodItems[index].id))
                  ],
                ))));
  }
}
