import 'package:flutter/material.dart';
import 'package:mini_katalog_app/features/catalog/data/models/productModel.dart';
import 'package:mini_katalog_app/features/catalog/presentation/widgets/productDetailInfo.dart';

//siz sayfaları incelerken kolaylık sağlamasıs açısından widgertsleri ve yollarını ekledim

class ProductDetailPage extends StatelessWidget {
  final Product product;
  final bool _isLoading;
  const ProductDetailPage({
    super.key,
    required this.product,
    required bool isLoading,
  }) : _isLoading = isLoading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator.adaptive())
          : ProductDetailInfo(product: product), //widgets/productDetailInfo
    );
  }
}
