import 'package:flutter/material.dart';
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

  final quanitityValidator = ValidationBuilder()
      .regExp(RegExp(r'(\d)'), "Quantity must be a number")
      .build();
  final storageValidator = ValidationBuilder().build();

  List<String> storageList = ["Fridge", "Pantry", "Freezer"];
  List<String> peopleList = [
    "Alexander Grattan",
    "Jennifer Zheng",
    "Crystal Li"
  ];

  String? quantity = "";
  String? storage = "";
  String? expirationDate = "";
  String? category = "";
  List<String> belongsTo = [];

  @override
  Widget build(BuildContext context) {
    var foodCategories = context.watch<FoodCategoryViewModel>().foodCategories;

    return Container(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: foodCategories.elementAt(widget.foodItem.category).icon,
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
          const SizedBox(
            height: 24,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: const [
          //     Text(
          //       "Quantity",
          //       style: TextStyle(
          //         fontWeight: FontWeight.bold,
          //         fontSize: 16,
          //       ),
          //     ),
          //     Text(
          //       "4",
          //       style: TextStyle(
          //         fontWeight: FontWeight.bold,
          //         fontSize: 16,
          //       ),
          //     ),
          //   ],
          // ),
          // const SizedBox(
          //   height: 8,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: const [
          //     Text(
          //       "Storage",
          //       style: TextStyle(
          //         fontWeight: FontWeight.bold,
          //         fontSize: 16,
          //       ),
          //     ),
          //     Chip(
          //       label: Text("Fridge"),
          //     ),
          //   ],
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: const [
          //     Text(
          //       "Expires on",
          //       style: TextStyle(
          //         fontWeight: FontWeight.bold,
          //         fontSize: 16,
          //       ),
          //     ),
          //     Chip(
          //       label: Text("Oct 5th"),
          //     ),
          //   ],
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: const [
          //     Text(
          //       "Category",
          //       style: TextStyle(
          //         fontWeight: FontWeight.bold,
          //         fontSize: 16,
          //       ),
          //     ),
          //     Chip(
          //       label: Text("Meat"),
          //     ),
          //   ],
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     const Text(
          //       "Belongs to",
          //       style: TextStyle(
          //         fontWeight: FontWeight.bold,
          //         fontSize: 16,
          //       ),
          //     ),
          //     CircleAvatar(
          //       backgroundColor: Colors.grey[300],
          //       child: const Text(
          //         "AG",
          //         style: TextStyle(color: Colors.black),
          //       ),
          //     )
          //   ],
          // ),
          // const SizedBox(
          //   height: 48,
          // ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: "Enter item quantity"),
                  keyboardType: TextInputType.number,
                  validator: quanitityValidator,
                  onSaved: ((value) => setState(() => quantity = value)),
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
                  onChanged: ((value) => setState(() => storage = value)),
                  onSaved: ((value) => setState(() => storage = value)),
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
                  onChanged: ((value) => setState(() {
                        if (belongsTo.contains(value)) {
                          belongsTo.remove(value);
                        } else {
                          belongsTo.add(value!);
                        }
                      })),
                  onSaved: ((value) => setState(() => storage = value)),
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

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Quantity $quantity')),
                      );

                      debugPrint(_formKey.currentState.toString());
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
