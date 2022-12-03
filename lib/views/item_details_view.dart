import 'package:flutter/material.dart';
import 'package:grosseries/components/tag.dart';
import 'package:grosseries/components/input_qty.dart';
import 'package:grosseries/components/user_bubble.dart';
import 'package:grosseries/models/list_food_entry.dart';
import 'package:grosseries/models/food_item.dart';
import 'package:grosseries/view_models/food_list_entry_view_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

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
    ListFoodEntry? listFoodEntry =
        context.read<FoodListEntryViewModel>().getListFoodEntry(id);
    FoodItem? foodItem = context
        .read<FoodListEntryViewModel>()
        .getFoodItem(listFoodEntry!.foodId);
    TextStyle style =
        const TextStyle(fontWeight: FontWeight.bold, fontSize: 20);

    return SafeArea(
      child: Container(
          margin: const EdgeInsets.only(left: 16, right: 16),
          decoration: BoxDecoration(color: Colors.yellow[200]),
          child: Column(children: [
            Container(
                padding: const EdgeInsets.only(top: 20, left: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () => GoRouter.of(context).go('/'),
                      icon: const FaIcon(
                        FontAwesomeIcons.chevronLeft,
                        size: 24,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      transform: Matrix4.translationValues(-2.0, 0.0, 0.0),
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      decoration: BoxDecoration(
                          color: foodCategories[foodItem!.category].color[100],
                          borderRadius: BorderRadius.circular(32)),
                      child: Text(
                        foodItem.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Share.share(
                            "My Grosseries Food Item\n\n$listFoodEntry");
                      },
                      icon: const Icon(
                        Icons.ios_share,
                        color: Colors.black,
                        size: 28,
                      ),
                    )
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
                  image: AssetImage(foodItem.image),
                ),
              ),
            ),
            InkWell(
                onTap: () {},
                child: Container(
                    constraints: const BoxConstraints(maxWidth: 150),
                    child: Tag(
                        text: listFoodEntry.expiration()["text"],
                        color: listFoodEntry.expiration()["color"]))),
            Container(
                margin: const EdgeInsets.only(top: 24, bottom: 16),
                padding: const EdgeInsets.only(left: 8),
                child: Row(children: [
                  Expanded(flex: 2, child: Text("Quantity", style: style)),
                  InputQty(
                      initVal: listFoodEntry.quantity,
                      minVal: 1,
                      maxVal: 100,
                      onQtyChanged: (val) {
                        listFoodEntry.quantity = val!.toInt();
                      },
                      id: id),
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
                  InkWell(
                      onTap: () {},
                      child: UserBubble(
                          user: listFoodEntry.owner,
                          borderSize: 4,
                          textSize: 15))
                ])),
          ])),
    );
  }
}
