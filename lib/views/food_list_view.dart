import 'package:flutter/material.dart';
import 'package:flutter_application_1/view_models/food_list_entry_view_model.dart';
import 'package:flutter_application_1/components/food_item_row.dart';
import 'package:provider/provider.dart';

class FoodListView extends StatefulWidget {
  const FoodListView({super.key});

  @override
  State<FoodListView> createState() => _FoodListViewState();
}

class _FoodListViewState extends State<FoodListView> {
  @override
  Widget build(BuildContext context) {
    var foodItems = context.watch<FoodListEntryViewModel>().foodItems;

    void onSortPress() {
      debugPrint('You just pressed the sort button');
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              height: 500,
              decoration: BoxDecoration(color: Colors.yellow[100]),
              padding: const EdgeInsets.only(top: 16, left: 32, right: 32),
              child: const Text("Sort Container"),
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
              child: const Text("Filter Container"),
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

    return SafeArea(
      child: Container(
          color: Colors.yellow[200],
          margin: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            children: [
              Container(
                // margin: const EdgeInsets.only(top: 24, left: 24),
                padding: const EdgeInsets.only(top: 20),
                child: Row(children: [
                  Expanded(
                      flex: 2,
                      child: TextButton(
                          onPressed: () {},
                          child: Row(
                            children: const [
                              Text(
                                "All Food Items",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28,
                                    color: Colors.black),
                              ),
                              Icon(
                                Icons.arrow_drop_down_rounded,
                                color: Colors.black,
                                size: 56,
                              )
                            ],
                          ))),
                  Ink(
                      decoration: const ShapeDecoration(
                        color: Color(0xD6D6D6D6),
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.search,
                              color: Colors.black, size: 28)))
                ]),
              ),
              Expanded(
                  child: ListView.builder(
                      // padding: const EdgeInsets.all(8),
                      itemCount: foodItems.length,
                      itemBuilder: (BuildContext context, int index) {
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
          )),
    );
  }
}
