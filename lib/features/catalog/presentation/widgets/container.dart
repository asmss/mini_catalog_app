import 'package:flutter/material.dart';

Widget container({
  required IconData icon,
  required TextEditingController controller,
  required hintext,
  required Function(String) onChanged,
}) {
  return Container(
    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 227, 227, 227),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: [
        Icon(icon),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hintext,
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    ),
  );
}
