import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/food_list_entry_view_model.dart';

class FilterForm extends StatefulWidget {
  const FilterForm({
    super.key,
  });

  @override
  State<FilterForm> createState() => _FilterFormState();
}

class _FilterFormState extends State<FilterForm> {
  @override
  Widget build(BuildContext context) {
    List<String> categoryFilters =
        context.watch<FoodListEntryViewModel>().categoryFilters;
    List<String> categoryOptions =
        context.watch<FoodListEntryViewModel>().categoryOptions;
    List<String> userFilters =
        context.watch<FoodListEntryViewModel>().userFilters;
    List<String> userOptions =
        context.watch<FoodListEntryViewModel>().userOptions;

    return Container(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 48,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          const SizedBox(
            height: 48,
          ),
          const Text(
            "Filter Items",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            "Categories",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Wrap(
            spacing: 8,
            children: List.generate(categoryOptions.length, (index) {
              return FilterChip(
                label: Text(
                  categoryOptions[index],
                ),
                labelStyle: const TextStyle(
                  color: Colors.black,
                ),
                selected: categoryFilters.contains(categoryOptions[index]),
                selectedColor: Colors.amber,
                backgroundColor: Colors.yellow[100],
                shape: const StadiumBorder(side: BorderSide()),
                elevation: 2,
                onSelected: (value) {
                  context
                      .read<FoodListEntryViewModel>()
                      .onCategorySelect(value, index);
                },
              );
            }),
          ),
          const SizedBox(
            height: 24,
          ),
          const Text(
            "Users",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Wrap(
            spacing: 8,
            children: List.generate(userOptions.length, (index) {
              return FilterChip(
                label: Text(
                  userOptions[index],
                ),
                labelStyle: const TextStyle(
                  color: Colors.black,
                ),
                selected: userFilters.contains(userOptions[index]),
                selectedColor: Colors.amber,
                backgroundColor: Colors.yellow[100],
                shape: const StadiumBorder(side: BorderSide()),
                elevation: 2,
                onSelected: (value) {
                  setState(() {
                    if (value) {
                      userFilters.add(userOptions[index]);
                    } else {
                      userFilters.removeWhere((String filter) {
                        return filter == userOptions[index];
                      });
                    }
                  });
                  context
                      .read<FoodListEntryViewModel>()
                      .onUserSelect(value, index);
                },
              );
            }),
          ),
          const SizedBox(
            height: 24,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  fixedSize:
                      MaterialStateProperty.all<Size>(const Size(150, 24))),
              child: const Text("Save"),
            ),
          )
        ],
      ),
    );
  }
}
