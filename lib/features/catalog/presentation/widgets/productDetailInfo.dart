import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mini_katalog_app/features/catalog/data/models/productModel.dart';
import 'package:mini_katalog_app/features/catalog/presentation/widgets/containerCard.dart';

class ProductDetailInfo extends StatelessWidget {
  final Product product;
  const ProductDetailInfo({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          30,
                        ), 
                        child: CachedNetworkImage(
                          imageUrl: product.image,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          placeholder: (context, url) => Container(
                            height: 300,
                            color: Colors.grey[200],
                            child: const Center(
                              child: CircularProgressIndicator.adaptive(),
                            ),
                          ),
                          errorWidget: (context, url, error) => const SizedBox(
                            height: 300,
                            child: Icon(
                              Icons.error,
                              color: Colors.red,
                              size: 50,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      product.name,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(product.tagline, style: TextStyle(fontSize: 10)),
                    SizedBox(height: 10),
                    Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(product.description),
                    SizedBox(height: 10),
                    Text(
                      "Specifications",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    containerCard(product: product),
                  ],
                ),
              ),
            );
  
  }
}