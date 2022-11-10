import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/list_food_entry.dart';
import 'package:flutter_application_1/view_models/food_list_entry_view_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

const List<String> inventories = <String>[
  'All Food Items',
  'Fridge',
  'Freezer',
  'Pantry'
];

class ItemListView extends StatefulWidget {
  const ItemListView({super.key});

  @override
  State<ItemListView> createState() => _ItemListViewState();
}

class _ItemListViewState extends State<ItemListView> {
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
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 25),
              padding: const EdgeInsets.only(
                  top: 28, bottom: 16, left: 24, right: 24),
              // color: Colors.white,
              width: MediaQuery.of(context).size.width,
              child: Row(children: [
                const Text(
                  "inventories dropdown here",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 24),
                )
              ]),
            ),
            Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: foodItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          margin: const EdgeInsets.all(16),
                          padding: const EdgeInsets.all(16),
                          decoration: const BoxDecoration(
                              color: Colors.white70,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "${foodItems[index].quantity.toString()}x ${foodItems[index].name}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                margin: const EdgeInsets.only(right: 4),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  shape: BoxShape.circle,
                                ),
                                child: Text(FoodListEntryViewModel.getInitials(
                                    foodItems[index])),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20))),
                                child: Text(
                                    FoodListEntryViewModel.expirationString(
                                        foodItems[index])),
                              )
                            ],
                          ));
                    }))
          ],
        ));
  }
}
