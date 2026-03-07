import 'package:flutter/material.dart';
import 'package:mini_katalog_app/features/catalog/data/models/productModel.dart';

Widget containerCard({required Product product}) {
  return Container(
    child: Row(
      children: product.specs.entries.map((item) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(255, 158, 152, 152),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  Text(
                    item.key,
                    style: TextStyle(
                      color: const Color.fromARGB(255, 156, 167, 173),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(item.value),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    ),
  );
}
