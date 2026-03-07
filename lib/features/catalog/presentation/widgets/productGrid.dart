import 'package:flutter/material.dart';
import 'package:mini_katalog_app/features/catalog/data/models/productModel.dart';
import 'package:mini_katalog_app/features/catalog/presentation/widgets/productCard.dart';

class ProductGrid extends StatelessWidget {
  final List<Product> products;
  final Function(Product) onAddCart;
  final Function(Product) onProductTap;
  final List<Product> currentSepet;

  const ProductGrid({
    super.key,
    required this.products,
    required this.onAddCart,
    required this.onProductTap,
    required this.currentSepet,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        childAspectRatio: 0.75,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCard(
          product: products[index],
          onTap: () => onProductTap(products[index]),
          onAddCart: onAddCart,
          eklenmisProduct: currentSepet,
        );
      },
    );
  }
}