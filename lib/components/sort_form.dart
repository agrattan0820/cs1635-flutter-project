import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/food_list_entry_view_model.dart';

class SortForm extends StatefulWidget {
  const SortForm({
    super.key,
  });

  @override
  State<SortForm> createState() => _SortFormState();
}

class _SortFormState extends State<SortForm> {
  @override
  Widget build(BuildContext context) {
    int sortOptionChoice =
        context.watch<FoodListEntryViewModel>().sortOptionChoice;
    List<String> options =
        context.watch<FoodListEntryViewModel>().sortOptionsList;

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
            "Sort Items",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
          const SizedBox(
            height: 8,
          ),
          Wrap(
            spacing: 8,
            children: List.generate(options.length, (index) {
              return ChoiceChip(
                label: Text(
                  options[index],
                ),
                labelStyle: const TextStyle(
                  color: Colors.black,
                ),
                selected: sortOptionChoice == index,
                selectedColor: Colors.amber,
                backgroundColor: Colors.yellow[100],
                shape: const StadiumBorder(side: BorderSide()),
                elevation: 2,
                onSelected: (value) {
                  context
                      .read<FoodListEntryViewModel>()
                      .onOptionSelect(value, index);
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
                fixedSize: MaterialStateProperty.all<Size>(
                  const Size(150, 24),
                ),
              ),
              child: const Text("Save"),
            ),
          )
        ],
      ),
    );
  }
}
