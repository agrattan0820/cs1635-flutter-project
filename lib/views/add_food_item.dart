import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/food_add_form.dart';
import 'package:flutter_application_1/models/food_item.dart';
import 'package:flutter_application_1/view_models/food_item_view_model.dart';
import 'package:provider/provider.dart';

class AddFoodItemView extends StatefulWidget {
  const AddFoodItemView({super.key});

  @override
  State<AddFoodItemView> createState() => _AddFoodItemViewState();
}

class _AddFoodItemViewState extends State<AddFoodItemView> {
  List foodCategories = [
    ["Produce", Colors.green],
    ["Dairy", Colors.blue],
    ["Meat", Colors.red],
    ["Baking Goods", Colors.yellow],
    ["Seafood", Colors.blue],
    ["Snacks", Colors.orange],
  ];

  int _selectedIndex = 0;

  List? _selectedCategory;

  FoodItem? _selectedFoodItem;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onCardTapped(int index) {
    setState(() {
      _selectedCategory = foodCategories[index];
    });
  }

  void _onFoodSelection(FoodItem item) {
    setState(() {
      _selectedFoodItem = item;
    });
  }

  static String _foodItemDisplay(FoodItem item) => item.name;

  @override
  Widget build(BuildContext context) {
    var foodItems = context.watch<FoodItemViewModel>().foodItems;

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
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 16, left: 32, right: 32),
          child: Center(
            child: Column(
              children: [
                Autocomplete(
                  displayStringForOption: _foodItemDisplay,
                  optionsBuilder: ((textEditingValue) {
                    if (textEditingValue.text == "") {
                      return const Iterable<FoodItem>.empty();
                    }
                    return foodItems.where((FoodItem item) {
                      return item.name
                          .toLowerCase()
                          .contains(textEditingValue.text.toLowerCase());
                    });
                  }),
                  onSelected: (FoodItem selection) {
                    _onFoodSelection(selection);
                    debugPrint(
                        'You just selected ${_foodItemDisplay(selection)}');
                  },
                  fieldViewBuilder: ((context, textEditingController, focusNode,
                      onFieldSubmitted) {
                    return TextFormField(
                      controller: textEditingController,
                      focusNode: focusNode,
                      onFieldSubmitted: (String value) {
                        onFieldSubmitted();
                        debugPrint("You just typed a new entry $value");
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
                      ),
                    );
                  }),
                ),
                const SizedBox(
                  height: 24,
                ),
                _selectedCategory != null
                    ? InkWell(
                        onTap: (() => setState(() {
                              _selectedCategory = null;
                            })),
                        borderRadius: BorderRadius.circular(100),
                        child: Chip(
                          backgroundColor: _selectedCategory?[1][100],
                          label: Text(
                            _selectedCategory?[0],
                            style: TextStyle(color: _selectedCategory?[1]),
                          ),
                        ),
                      )
                    : const SizedBox(),
                // _selectedCategory != null
                //     ? Expanded(
                //         child: ListView.builder(
                //           itemCount: foodItems.length,
                //           itemBuilder: (((context, index) {
                //             return ListTile(
                //               title: Text(foodItems[index].name),
                //               onTap: () => _onFoodSelection(foodItems[index]),
                //             );
                //           })),
                //         ),
                //       )
                //     : Expanded(
                //         child: GridView.builder(
                //           scrollDirection: Axis.vertical,
                //           shrinkWrap: true,
                //           itemCount: foodCategories.length,
                //           gridDelegate:
                //               const SliverGridDelegateWithFixedCrossAxisCount(
                //                   crossAxisCount: 2),
                //           itemBuilder: ((context, index) {
                //             return Padding(
                //               padding: const EdgeInsets.all(8.0),
                //               child: FoodCategoryCard(
                //                 text: foodCategories[index][0],
                //                 cardColor: foodCategories[index][1],
                //                 onPress: () => _onCardTapped(index),
                //               ),
                //             );
                //           }),
                //         ),
                //       )
                const FoodAddForm()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
