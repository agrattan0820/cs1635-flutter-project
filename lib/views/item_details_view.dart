import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/tag.dart';
import 'package:flutter_application_1/components/input_qty.dart';
import 'package:flutter_application_1/components/user_bubble.dart';
import 'package:flutter_application_1/models/list_food_entry.dart';
import 'package:flutter_application_1/models/food_item.dart';
import 'package:flutter_application_1/view_models/food_list_entry_view_model.dart';
import 'package:provider/provider.dart';

import '../view_models/food_category_view_model.dart';

class ItemDetailsView extends StatefulWidget {
  final String? id;

  const ItemDetailsView({super.key, this.id});

  @override
  State<ItemDetailsView> createState() => _ItemDetailsViewState();
}

class _ItemDetailsViewState extends State<ItemDetailsView> {
  @override
  Widget build(BuildContext context) {
    var foodCategories = context.watch<FoodCategoryViewModel>().foodCategories;

    int id = int.parse(widget.id!);
    ListFoodEntry? listFoodEntry = FoodListEntryViewModel.getListFoodEntry(id);
    FoodItem? foodItem = FoodListEntryViewModel.getFoodItem(id);
    TextStyle style =
        const TextStyle(fontWeight: FontWeight.bold, fontSize: 20);

    return SafeArea(
      child: Container(
          margin: const EdgeInsets.only(left: 16, right: 16),
          child: Column(children: [
            Container(
                padding: const EdgeInsets.only(top: 20, left: 8),
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Text(
                          foodItem!.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                              color: Colors.black),
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.ios_share,
                          color: Colors.black,
                          size: 28,
                        ))
                  ],
                )),
            Container(
                height: 200,
                width: 200,
                margin: const EdgeInsets.only(top: 56, bottom: 8),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image(
                        fit: BoxFit.cover,
                        image: NetworkImage(foodItem.image)))),
            InkWell(
                onTap: () {},
                child: Tag(text: FoodListEntryViewModel.expirationString(id))),
            Container(
                margin: const EdgeInsets.only(top: 24, bottom: 16),
                padding: const EdgeInsets.only(left: 8),
                child: Row(children: [
                  Expanded(flex: 2, child: Text("Quantity", style: style)),
                  InputQty(
                    initVal: listFoodEntry!.quantity,
                    minVal: 1,
                    onQtyChanged: (val) {
                      listFoodEntry.quantity = val!.toInt();
                    },
                  ),
                ])),
            Container(
                margin: const EdgeInsets.only(top: 16, bottom: 16),
                padding: const EdgeInsets.only(left: 8),
                child: Row(children: [
                  Expanded(flex: 2, child: Text("Storage", style: style)),
                  InkWell(
                      onTap: () {},
                      child: Tag(
                        text: listFoodEntry.storage,
                        // padding: 12,
                      ))
                ])),
            Container(
                margin: const EdgeInsets.only(top: 16, bottom: 16),
                padding: const EdgeInsets.only(left: 8),
                child: Row(children: [
                  Expanded(
                      flex: 2,
                      child: Text(
                        "Category",
                        style: style,
                      )),
                  InkWell(
                      onTap: () {},
                      child: Tag(
                        text: foodCategories[foodItem.category].name,
                        // padding: 12,
                      ))
                ])),
            Container(
                margin: const EdgeInsets.only(top: 16, bottom: 16),
                padding: const EdgeInsets.only(left: 8),
                child: Row(children: [
                  Expanded(
                      flex: 2,
                      child: Text(
                        "Belongs To",
                        style: style,
                      )),
                  InkWell(onTap: () {}, child: UserBubble(user: listFoodEntry))
                ])),
          ])),
    );
  }
}
