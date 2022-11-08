import 'package:flutter/material.dart';

class FoodCategoryCard extends StatelessWidget {
  final String text;
  final MaterialColor cardColor;
  final Widget icon;
  final VoidCallback onPress;

  const FoodCategoryCard({
    super.key,
    required this.text,
    required this.cardColor,
    required this.icon,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: cardColor[100],
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const FaIcon(FontAwesomeIcons.circleInfo),
            icon,
            const SizedBox(
              height: 8,
            ),
            Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}
