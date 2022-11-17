import 'package:flutter/material.dart';

class SortForm extends StatefulWidget {
  final List<String> options;
  final Function(bool, int) onOptionSelect;

  const SortForm({
    super.key,
    required this.options,
    required this.onOptionSelect,
  });

  @override
  State<SortForm> createState() => _SortFormState();
}

class _SortFormState extends State<SortForm> {
  int defaultChoiceIndex = 0;

  @override
  Widget build(BuildContext context) {
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
            children: List.generate(widget.options.length, (index) {
              return ChoiceChip(
                label: Text(
                  widget.options[index],
                ),
                labelStyle: const TextStyle(
                  color: Colors.black,
                ),
                selected: defaultChoiceIndex == index,
                selectedColor: Colors.amber,
                backgroundColor: Colors.yellow[100],
                shape: const StadiumBorder(side: BorderSide()),
                elevation: 2,
                onSelected: (value) {
                  setState(() {
                    defaultChoiceIndex = value ? index : defaultChoiceIndex;
                  });
                  widget.onOptionSelect(value, index);
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
