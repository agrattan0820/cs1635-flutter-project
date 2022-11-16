import 'package:flutter/material.dart';

class SortForm extends StatefulWidget {
  // final List<String> options;
  // final Function(bool, int) onOptionSelect;

  const SortForm({super.key});

  @override
  State<SortForm> createState() => _SortFormState();
}

class _SortFormState extends State<SortForm> {
  int defaultChoiceIndex = 0;
  final List<String> _choicesList = ['Expiration', 'Name', 'Newest'];

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
            children: List.generate(_choicesList.length, (index) {
              return ChoiceChip(
                label: Text(
                  _choicesList[index],
                ),
                labelStyle: const TextStyle(
                  color: Colors.black,
                ),
                selected: defaultChoiceIndex == index,
                selectedColor: Colors.yellow[800],
                backgroundColor: Colors.yellow[100],
                shape: const StadiumBorder(side: BorderSide()),
                onSelected: (value) {
                  debugPrint("selected");
                  setState(() {
                    defaultChoiceIndex = value ? index : defaultChoiceIndex;
                  });
                },
              );
            }),
          )
        ],
      ),
    );
  }
}

// class SortForm extends StatelessWidget {
//   final List<String> options;
//   final Function(bool, int) onOptionSelect;
//   final int selectedOption;

//   const SortForm({
//     super.key,
//     required this.selectedOption,
//     required this.options,
//     required this.onOptionSelect,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Center(
//             child: Container(
//               width: 48,
//               height: 4,
//               decoration: BoxDecoration(
//                 color: Colors.black,
//                 borderRadius: BorderRadius.circular(16),
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 48,
//           ),
//           const Text(
//             "Sort Items",
//             style: TextStyle(
//               fontSize: 32,
//               fontWeight: FontWeight.bold,
//             ),
//             textAlign: TextAlign.left,
//           ),
//           const SizedBox(
//             height: 8,
//           ),
//           Wrap(
//             spacing: 8,
//             children: List.generate(options.length, (index) {
//               return ChoiceChip(
//                 label: Text(
//                   options[index],
//                 ),
//                 labelStyle: const TextStyle(
//                   color: Colors.black,
//                 ),
//                 selected: selectedOption == index,
//                 selectedColor: Colors.yellow[800],
//                 backgroundColor: Colors.yellow[100],
//                 shape: const StadiumBorder(side: BorderSide()),
//                 onSelected: (value) {
//                   debugPrint("selected");
//                   onOptionSelect(value, index);
//                 },
//               );
//             }),
//           )
//         ],
//       ),
//     );
//   }
// }
