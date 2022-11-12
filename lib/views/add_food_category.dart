import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/food_item.dart';
import 'package:flutter_application_1/view_models/food_item_view_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../components/food_category_card.dart';

class AddFoodCategoryView extends StatefulWidget {
  const AddFoodCategoryView({super.key});

  @override
  State<AddFoodCategoryView> createState() => _AddFoodCategoryViewState();
}

class _AddFoodCategoryViewState extends State<AddFoodCategoryView> {
  List foodCategories = [
    [
      "Produce",
      Colors.green,
      const FaIcon(
        FontAwesomeIcons.appleWhole,
        size: 48,
        color: Colors.green,
      )
    ],
    [
      "Dairy",
      Colors.blue,
      const FaIcon(
        FontAwesomeIcons.cow,
        size: 48,
        color: Colors.blue,
      )
    ],
    [
      "Meat",
      Colors.red,
      const FaIcon(
        FontAwesomeIcons.drumstickBite,
        size: 48,
        color: Colors.red,
      )
    ],
    [
      "Baking Goods",
      Colors.yellow,
      const FaIcon(
        FontAwesomeIcons.breadSlice,
        size: 48,
        color: Colors.yellow,
      )
    ],
    [
      "Seafood",
      Colors.blue,
      const FaIcon(
        FontAwesomeIcons.fish,
        size: 48,
        color: Colors.blue,
      )
    ],
    [
      "Snacks",
      Colors.orange,
      const FaIcon(
        FontAwesomeIcons.cookieBite,
        size: 48,
        color: Colors.orange,
      )
    ],
  ];

  List? _selectedCategory;

  void _onCardTapped(int index) {
    setState(() {
      _selectedCategory = foodCategories[index];
    });
  }

  static String _foodItemDisplay(FoodItem item) => item.name;

  @override
  Widget build(BuildContext context) {
    var foodItems = context.watch<FoodItemViewModel>().foodItems;

    void onFoodSelection(FoodItem item) {
      debugPrint('You just selected ${_foodItemDisplay(item)}');
      context.read<FoodItemViewModel>().updateSelectedFoodItem(item);
      GoRouter.of(context).go("/add_item/details/${item.id}");
    }

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(top: 16, left: 32, right: 32),
        color: Colors.yellow[200],
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
                  onFoodSelection(selection);
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
              _selectedCategory != null
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: foodItems.length,
                        itemBuilder: (((context, index) {
                          return ListTile(
                            title: Text(foodItems[index].name),
                            onTap: () => onFoodSelection(foodItems[index]),
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
                              icon: foodCategories[index][2],
                              onPress: () => _onCardTapped(index),
                            ),
                          );
                        }),
                      ),
                    )
              // const FoodAddForm()
            ],
          ),
        ),
      ),
    );
  }
}
