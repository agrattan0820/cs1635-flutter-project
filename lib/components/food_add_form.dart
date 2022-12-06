import 'package:flutter/material.dart';
import 'package:grosseries/view_models/food_list_entry_view_model.dart';
import 'package:provider/provider.dart';
import 'package:form_validator/form_validator.dart';

import '../models/food_item.dart';
import '../view_models/food_category_view_model.dart';

class FoodAddForm extends StatefulWidget {
  final FoodItem foodItem;

  const FoodAddForm({super.key, required this.foodItem});

  @override
  State<FoodAddForm> createState() => _FoodAddFormState();
}

class _FoodAddFormState extends State<FoodAddForm> {
  final _formKey = GlobalKey<FormState>();

  List<String> storageList = ["Fridge", "Pantry", "Freezer"];
  List<String> peopleList = [
    "Alexander Grattan",
    "Jennifer Zheng",
    "Crystal Li"
  ];

  int quantity = 0;
  String storage = "";
  String owner = "";
  DateTime datePurchased = DateTime.now();

  final quanitityValidator =
      ValidationBuilder(requiredMessage: "Quantity is required")
          .regExp(RegExp(r'(\d)'), "Quantity must be a number")
          .build();
  final storageValidator =
      ValidationBuilder(requiredMessage: "Storage is required").build();

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    ).then((value) => setState(() {
          if (value != null) {
            datePurchased = value;
          }
        }));
  }

  @override
  Widget build(BuildContext context) {
    var foodCategories = context.watch<FoodCategoryViewModel>().foodCategories;

    return Container(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child:
                        foodCategories.elementAt(widget.foodItem.category).icon,
                  ),
                  Text(
                    widget.foodItem.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(
                  Icons.close,
                  size: 32,
                ),
                tooltip: 'Close add food form',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Enter item quantity",
                  ),
                  keyboardType: TextInputType.number,
                  validator: quanitityValidator,
                  onSaved: ((value) =>
                      setState(() => quantity = int.parse(value!))),
                ),
                const SizedBox(
                  height: 16,
                ),
                DropdownButtonFormField(
                  decoration:
                      const InputDecoration(labelText: "Choose item storage"),
                  validator: storageValidator,
                  items:
                      storageList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: ((value) => setState(() => storage = value!)),
                  onSaved: ((value) => setState(() => storage = value!)),
                ),
                DropdownButtonFormField(
                  decoration:
                      const InputDecoration(labelText: "Choose item owner"),
                  validator: storageValidator,
                  items:
                      peopleList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: ((value) => setState(() => owner = value!)),
                  onSaved: ((value) => setState(() => owner = value!)),
                ),
                const SizedBox(
                  height: 26,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "Date Purchased",
                        ),
                        Text(
                          "${datePurchased.month.toString()}-${datePurchased.day.toString()}-${datePurchased.year.toString()}",
                        ),
                      ],
                    ),
                    OutlinedButton(
                      onPressed: _showDatePicker,
                      child: const Text("Choose Date"),
                    )
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      _formKey.currentState?.save();

                      debugPrint(_formKey.currentState.toString());

                      context.read<FoodListEntryViewModel>().addFoodItemEntry(
                            widget.foodItem.id,
                            storage,
                            quantity,
                            owner,
                            datePurchased,
                          );

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content:
                                Text('${widget.foodItem.name} saved to list')),
                      );
                    }
                  },
                  child: const Text('Submit'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
