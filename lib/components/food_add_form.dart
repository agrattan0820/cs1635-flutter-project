import 'package:flutter/material.dart';

class FoodAddForm extends StatefulWidget {
  const FoodAddForm({super.key});

  @override
  State<FoodAddForm> createState() => _FoodAddFormState();
}

class _FoodAddFormState extends State<FoodAddForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: Column(
        children: [
          Row(
            children: const [
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.ac_unit,
                  size: 48,
                ),
              ),
              Text(
                "Chicken",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Quantity",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                "4",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Storage",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Chip(
                label: Text("Fridge"),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Expires on",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Chip(
                label: Text("Fridge"),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Category",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Chip(
                label: Text("Oct 5th"),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Belongs to",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              CircleAvatar(
                backgroundColor: Colors.grey[300],
                child: const Text(
                  "AG",
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
