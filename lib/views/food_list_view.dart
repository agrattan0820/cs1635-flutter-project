import 'package:flutter/material.dart';
import 'package:flutter_application_1/view_models/food_list_entry_view_model.dart';
import 'package:flutter_application_1/components/food_item_row.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// const List<String> inventories = <String>[
//   'All Food Items',
//   'Fridge',
//   'Freezer',
//   'Pantry'
// ];

class FoodListView extends StatefulWidget {
  const FoodListView({super.key});

  @override
  State<FoodListView> createState() => _FoodListViewState();
}

class _FoodListViewState extends State<FoodListView> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      if (_selectedIndex == 0) {
        GoRouter.of(context).go("/");
      } else if (_selectedIndex == 1) {
        GoRouter.of(context).go("/add_item");
      } else if (_selectedIndex == 2) {
        GoRouter.of(context).go("/login");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var foodItems = context.watch<FoodListEntryViewModel>().foodItems;

    return Scaffold(
        backgroundColor: Colors.yellow[200],
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Lists',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              label: 'Add Item',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.yellow[800],
          backgroundColor: Colors.yellow[100],
          onTap: _onItemTapped,
        ),
        body: Container(
            margin: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              children: [
                Container(
                  // margin: const EdgeInsets.only(top: 24, left: 24),
                  padding: const EdgeInsets.only(top: 28),
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
                    TextButton(
                        onPressed: () {},
                        child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Color(0xD6D6D6D6),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.search,
                                color: Colors.black, size: 28)))
                  ]),
                ),
                Expanded(
                    child: ListView.builder(
                        // padding: const EdgeInsets.all(8),
                        itemCount: foodItems.length,
                        itemBuilder: (BuildContext context, int index) {
                          return FoodItemRow(
                              foodItems: foodItems, index: index);
                        })),
                Container(
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.only(left: 10, top: 0, bottom: 0),
                    width: 270,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: IntrinsicHeight(
                      child: Row(children: <Widget>[
                        Container(
                            // margin: const EdgeInsets.only(top: 8, bottom: 8),
                            margin: const EdgeInsets.all(0),
                            padding: const EdgeInsets.all(0),
                            child: TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.all(0),
                                ),
                                child: Row(
                                  children: const [
                                    Icon(Icons.sort_rounded),
                                    Text("Sort")
                                  ],
                                ))),
                        const VerticalDivider(
                          thickness: 1,
                          indent: 5,
                          endIndent: 5,
                          color: Colors.black,
                        ),
                        Container(
                            // margin: const EdgeInsets.all(4),
                            child: TextButton(
                                onPressed: () {},
                                child: Row(
                                  children: const [
                                    Icon(Icons.filter_alt_outlined),
                                    Text("Filter")
                                  ],
                                ))),
                        const VerticalDivider(
                          width: 20,
                          thickness: 1,
                          indent: 5,
                          endIndent: 5,
                          color: Colors.black,
                        ),
                        Container(
                            // margin: const EdgeInsets.all(4),
                            child: TextButton(
                                onPressed: () {},
                                child: Row(
                                  children: const [
                                    Icon(Icons.ios_share),
                                    Text("Share")
                                  ],
                                ))),
                      ]),
                    )),
              ],
            )));
  }
}
