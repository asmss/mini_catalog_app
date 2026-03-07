import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mini_katalog_app/features/catalog/data/models/productModel.dart';

class Sepetexpanded extends StatelessWidget {
  final List<Product> _eklenmisProduct;
  final Function(Product) removeCard;

  const Sepetexpanded({super.key, required List<Product> eklenmisProduct, required this.removeCard})
    : _eklenmisProduct = eklenmisProduct;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: _eklenmisProduct.length,
        itemBuilder: (context, index) {
          final item = _eklenmisProduct[index];

          return ListTile(
            title: Text(item.name),
            subtitle: Text(item.price),
            leading: CachedNetworkImage(
              imageUrl: item.image,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) =>
                  const Icon(Icons.broken_image),
            ),
            trailing: IconButton(
              onPressed: () {
                removeCard(item);
              },
              icon: Icon(Icons.delete),
            ),
          );
        },
      ),
    );
  }
}
