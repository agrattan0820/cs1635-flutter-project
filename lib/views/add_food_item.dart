import 'package:flutter/material.dart';

import '../components/food_category_card.dart';

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

  @override
  Widget build(BuildContext context) {
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
        selectedItemColor: Colors.blue[500],
        backgroundColor: Colors.yellow[100],
        onTap: _onItemTapped,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
          child: Center(
            child: Column(
              children: <Widget>[
                TextField(
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
                      child: const Icon(Icons.search),
                    ),
                  ),
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
                _selectedCategory != null
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: 5,
                          itemBuilder: (((context, index) {
                            return const ListTile(
                              title: Text("Hello"),
                            );
                          })),
                        ),
                      )
                    : Expanded(
                        child: GridView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: foodCategories.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FoodCategoryCard(
                                text: foodCategories[index][0],
                                cardColor: foodCategories[index][1],
                                onPress: () => _onCardTapped(index),
                              ),
                            );
                          }),
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
