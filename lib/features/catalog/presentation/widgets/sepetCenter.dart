import 'package:flutter/material.dart';

Widget center() {
  return Center(
    child: Column(
      children: [
        Icon(Icons.shopping_cart_checkout_outlined, size: 50),
        Text("Sepetiniz boş"),
      ],
    ),
  );
}
