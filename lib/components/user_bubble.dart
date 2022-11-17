import 'package:flutter/material.dart';

class UserBubble extends StatelessWidget {
  final String user;

  const UserBubble({super.key, required this.user});

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
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        shape: BoxShape.circle,
      ),
      child: Text(_getInitials(), style: const TextStyle(color: Colors.black)),
    );
  }
}
