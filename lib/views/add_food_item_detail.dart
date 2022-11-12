import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/food_add_form.dart';
import 'package:flutter_application_1/models/food_item.dart';
import 'package:flutter_application_1/view_models/food_item_view_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class AddFoodDetailView extends StatefulWidget {
  const AddFoodDetailView({super.key});

  @override
  State<AddFoodDetailView> createState() => _AddFoodDetailViewState();
}

class _AddFoodDetailViewState extends State<AddFoodDetailView> {
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
    var selectedFoodItem = context.watch<FoodItemViewModel>().selectedFoodItem;

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(top: 16, left: 32, right: 32),
        color: Colors.yellow[200],
        child: const Center(
          child: FoodAddForm(),
        ),
      ),
    );
  }
}
