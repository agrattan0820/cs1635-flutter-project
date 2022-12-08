import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:grosseries/components/tag.dart';
import 'package:grosseries/components/user_bubble.dart';
import 'package:grosseries/models/list_food_entry.dart';
import 'package:grosseries/view_models/food_list_entry_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../models/food_item.dart';
import '../view_models/food_category_view_model.dart';
import '../view_models/food_item_view_model.dart';

class FoodItemRow extends StatelessWidget {
  final List<ListFoodEntry> foodItems;
  final int index;

  const FoodItemRow({super.key, required this.foodItems, required this.index});

  @override
  Widget build(BuildContext context) {
    FoodItem? foodItem = FoodItemViewModel.getFoodItem(foodItems[index].foodId);
    ListFoodEntry? listFoodEntry = foodItems[index];

    var foodCategories = context.watch<FoodCategoryViewModel>().foodCategories;

    debugPrint("${foodItem!.name}${foodItem.daysToExpire}");

    return Container(
        padding: const EdgeInsets.only(top: 8, bottom: 28, left: 8, right: 8),
        child: Slidable(
            endActionPane: ActionPane(motion: const ScrollMotion(), children: [
              SlidableAction(
                onPressed: (context) => {
                  context
                      .read<FoodListEntryViewModel>()
                      .removeFoodItemEntry(foodItems[index].entryId)
                },
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                icon: Icons.delete,
                label: 'Delete',
              ),
            ]),
            child: InkWell(
                onTap: () {
                  GoRouter.of(context)
                      .go("/item_details/${foodItems[index].entryId}");
                },
                child: Container(
                    // margin: const EdgeInsets.only(top: 8, bottom: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      // color: foodCategories[foodItem.category].color[100],
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.25),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset:
                              const Offset(0, 2), // changes position of shadow
                        ),
                      ],
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            "${foodItems[index].quantity.toString()}x ${foodItem.name}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        UserBubble(
                            user: foodItems[index].owner,
                            borderSize: 4,
                            textSize: 15),
                        Tag(
                          text: listFoodEntry.expiration()["text"],
                          color: listFoodEntry.expiration()["color"],
                        )
                      ],
                    )))));
  }
}
