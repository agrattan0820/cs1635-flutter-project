import 'package:flutter/material.dart';

class UserBubble extends StatelessWidget {
  final String user;
  final double borderSize;
  final double textSize;

  const UserBubble({super.key, required this.user, required this.borderSize, required this.textSize});

  String _getInitials() {
    var buffer = StringBuffer();
    var split = user.split(' ');
    for (var i = 0; i < split.length; i++) {
      buffer.write(split[i][0].toUpperCase());
    }

    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(borderSize),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        shape: BoxShape.circle,
      ),
      child: Text(_getInitials(), style: TextStyle(color: Colors.black, fontSize: textSize)),
    );
  }
}
