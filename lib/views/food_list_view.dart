import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/filter_form.dart';
import 'package:flutter_application_1/models/list_food_entry.dart';
import 'package:flutter_application_1/view_models/food_category_view_model.dart';
import 'package:flutter_application_1/view_models/food_list_entry_view_model.dart';
import 'package:flutter_application_1/components/food_item_row.dart';
import 'package:provider/provider.dart';

import '../components/sort_form.dart';
import '../models/food_item.dart';
import '../view_models/food_item_view_model.dart';

class FoodListView extends StatefulWidget {
  const FoodListView({super.key});

  @override
  State<FoodListView> createState() => _FoodListViewState();
}

class _FoodListViewState extends State<FoodListView> {
  String query = "";
  final textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Sorting and Filtering
    int sortOptionChoice =
        context.watch<FoodListEntryViewModel>().sortOptionChoice;
    final List<String> categoryFilters =
        context.watch<FoodListEntryViewModel>().categoryFilters;
    final List<String> userFilters =
        context.watch<FoodListEntryViewModel>().userFilters;
    // String query = context.watch<FoodListEntryViewModel>().query;

    // Food Categories
    var foodCategories = context.watch<FoodCategoryViewModel>().foodCategories;

    // Food Items
    var foodItems = context.watch<FoodListEntryViewModel>().foodItems.where(
      (item) {
        if (categoryFilters.isEmpty && userFilters.isEmpty) {
          return true;
        }

        // Filter by Categories
        if (categoryFilters.isNotEmpty) {
          FoodItem? foodItem = FoodItemViewModel.getFoodItem(item.foodId);
          return categoryFilters
              .contains(foodCategories[foodItem!.category].name);
        }
        // Filter by Users
        if (userFilters.isNotEmpty) {
          return userFilters.contains(item.owner);
        }

        return true;
      },
    ).toList();

    void onSortPress() {
      debugPrint('You just pressed the sort button');
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              height: 300,
              decoration: BoxDecoration(color: Colors.yellow[100]),
              padding: const EdgeInsets.only(top: 16, left: 32, right: 32),
              child: const SortForm(),
            );
          });
    }

    void onFilterPress() {
      debugPrint('You just pressed the filter button');
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              height: 500,
              decoration: BoxDecoration(color: Colors.yellow[100]),
              padding: const EdgeInsets.only(top: 16, left: 32, right: 32),
              child: const FilterForm(),
            );
          });
    }

    void onSharePress() {
      debugPrint('You just pressed the share button');
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              height: 500,
              decoration: BoxDecoration(color: Colors.yellow[100]),
              padding: const EdgeInsets.only(top: 16, left: 32, right: 32),
              child: const Text("Share Container"),
            );
          });
    }

    return SafeArea(child:
        Consumer<FoodListEntryViewModel>(builder: (context, viewModel, child) {
      return Container(
          color: Colors.yellow[200],
          margin: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            children: [
              Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: TextFormField(
                    controller: textEditingController,
                    onChanged: (value) {
                      setState(() {
                        query = value.toLowerCase();
                      });
                    },
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        hintText: "Search",
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                        prefixIcon: Container(
                          padding: const EdgeInsets.all(16),
                          width: 16,
                          child: Icon(
                            Icons.search,
                            color: Colors.yellow[800],
                          ),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () => {
                            textEditingController.clear(),
                            setState(() {
                              query = "";
                            })
                          },
                        )),
                  )),
              Expanded(
                  child: ListView.builder(
                      // padding: const EdgeInsets.all(8),
                      itemCount: foodItems.length,
                      itemBuilder: (BuildContext context, int index) {
                        foodItems.sort(((a, b) {
                          debugPrint("$sortOptionChoice");
                          switch (sortOptionChoice) {
                            case 0:
                              {
                                FoodItem? foodItemA =
                                    FoodItemViewModel.getFoodItem(a.foodId);
                                FoodItem? foodItemB =
                                    FoodItemViewModel.getFoodItem(b.foodId);
                                Duration timePassedA =
                                    DateTime.now().difference(a.dateAdded);
                                Duration timePassedB =
                                    DateTime.now().difference(b.dateAdded);
                                int aDifference = foodItemA!.daysToExpire -
                                    timePassedA.inDays;
                                int bDifference = foodItemB!.daysToExpire -
                                    timePassedB.inDays;
                                return aDifference.compareTo(bDifference);
                              }
                            case 1:
                              {
                                FoodItem? foodItemA =
                                    FoodItemViewModel.getFoodItem(a.foodId);
                                FoodItem? foodItemB =
                                    FoodItemViewModel.getFoodItem(b.foodId);
                                return foodItemA!.name
                                    .compareTo(foodItemB!.name);
                              }
                            case 2:
                              {
                                Duration timePassedA =
                                    DateTime.now().difference(a.dateAdded);
                                Duration timePassedB =
                                    DateTime.now().difference(b.dateAdded);
                                return timePassedA.compareTo(timePassedB);
                              }
                            default:
                              {
                                return 0;
                              }
                          }
                        }));

                        // filter by search input
                        if (query.isNotEmpty) {
                          FoodItem? foodItem = FoodItemViewModel.getFoodItem(
                              foodItems[index].foodId);
                          return foodItem!.name.toLowerCase().contains(query)
                              ? FoodItemRow(foodItems: foodItems, index: index)
                              : Container();
                        }

                        return FoodItemRow(foodItems: foodItems, index: index);
                      })),
              Container(
                  margin: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 20, right: 20),
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: IntrinsicHeight(
                      child: IntrinsicWidth(
                    child: Row(children: <Widget>[
                      Container(
                          // margin: const EdgeInsets.only(top: 8, bottom: 8),
                          margin: const EdgeInsets.all(0),
                          padding: const EdgeInsets.all(0),
                          child: TextButton(
                              onPressed: onSortPress,
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(0),
                              ),
                              child: Row(
                                children: const [
                                  Icon(Icons.sort_rounded, color: Colors.black),
                                  Text(
                                    "Sort",
                                    style: TextStyle(color: Colors.black),
                                  )
                                ],
                              ))),
                      const VerticalDivider(
                        thickness: 1,
                        indent: 5,
                        endIndent: 5,
                        color: Colors.black,
                      ),
                      TextButton(
                          onPressed: onFilterPress,
                          child: Row(
                            children: const [
                              Icon(
                                Icons.filter_alt_outlined,
                                color: Colors.black,
                              ),
                              Text("Filter",
                                  style: TextStyle(color: Colors.black))
                            ],
                          )),
                      const VerticalDivider(
                        width: 20,
                        thickness: 1,
                        indent: 5,
                        endIndent: 5,
                        color: Colors.black,
                      ),
                      TextButton(
                          onPressed: onSharePress,
                          child: Row(
                            children: const [
                              Icon(Icons.ios_share, color: Colors.black),
                              Text("Share",
                                  style: TextStyle(color: Colors.black))
                            ],
                          )),
                    ]),
                  ))),
            ],
          ));
    }));
  }
}
