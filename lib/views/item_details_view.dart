import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/tag.dart';
import 'package:flutter_application_1/components/input_qty.dart';
import 'package:flutter_application_1/models/list_food_entry.dart';
import 'package:flutter_application_1/view_models/food_list_entry_view_model.dart';

const List<String> inventories = <String>['Fridge', 'Freezer', 'Pantry'];

class ItemDetailsView extends StatefulWidget {
  final String? id;

  const ItemDetailsView({super.key, this.id});

  @override
  State<ItemDetailsView> createState() => _ItemDetailsViewState();
}

class _ItemDetailsViewState extends State<ItemDetailsView> {
  @override
  Widget build(BuildContext context) {
    int id = int.parse(widget.id!);
    ListFoodEntry? listFoodEntry = FoodListEntryViewModel.getListFoodEntry(id);
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
                          "${FoodListEntryViewModel.getFoodItem(id)!.name}",
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
                        image: NetworkImage(
                            FoodListEntryViewModel.getFoodItem(id)!.image)))),
            TextButton(
                onPressed: () {},
                child: Tag(text: FoodListEntryViewModel.expirationString(id))),
            Container(
                margin: const EdgeInsets.only(top: 24, bottom: 24),
                padding: const EdgeInsets.only(left: 8),
                child: Row(children: [
                  Expanded(flex: 2, child: Text("Quantity", style: style)),
                  InputQty(
                    initVal: listFoodEntry!.quantity,
                    onQtyChanged: (val) {
                      listFoodEntry.quantity = val!.toInt();
                    },
                  ),
                  // Text("picker here")
                ])),
            Container(
                margin: const EdgeInsets.only(top: 24, bottom: 24),
                padding: const EdgeInsets.only(left: 8),
                child: Row(children: [
                  Expanded(flex: 2, child: Text("Storage", style: style)),
                  Text("dropdown here")
                ])),
            Container(
                margin: const EdgeInsets.only(top: 24, bottom: 24),
                padding: const EdgeInsets.only(left: 8),
                child: Row(children: [
                  Expanded(
                      flex: 2,
                      child: Text(
                        "Category",
                        style: style,
                      )),
                  Text("dropdown here")
                ])),
            Container(
                margin: const EdgeInsets.only(top: 24, bottom: 24),
                padding: const EdgeInsets.only(left: 8),
                child: Row(children: [
                  Expanded(
                      flex: 2,
                      child: Text(
                        "Belongs To",
                        style: style,
                      )),
                  Text("button here")
                ])),
          ])),
    );
  }
}
