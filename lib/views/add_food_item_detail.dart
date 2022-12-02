import 'package:flutter/material.dart';
import 'package:grosseries/components/food_add_form.dart';
import 'package:grosseries/view_models/food_item_view_model.dart';
import 'package:provider/provider.dart';

class AddFoodDetailView extends StatefulWidget {
  const AddFoodDetailView({super.key});

  @override
  State<AddFoodDetailView> createState() => _AddFoodDetailViewState();
}

class _AddFoodDetailViewState extends State<AddFoodDetailView> {
  @override
  Widget build(BuildContext context) {
    var selectedFoodItem = context.watch<FoodItemViewModel>().selectedFoodItem!;

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(top: 16, left: 32, right: 32),
        color: Colors.yellow[200],
        child: Center(
          child: FoodAddForm(
            foodItem: selectedFoodItem,
          ),
        ),
      ),
    );
  }
}
