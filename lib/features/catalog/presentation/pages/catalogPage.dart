import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mini_katalog_app/core/network/api_service.dart';
import 'package:mini_katalog_app/features/catalog/data/models/productModel.dart';
import 'package:mini_katalog_app/features/catalog/presentation/pages/SepetPage.dart';
import 'package:mini_katalog_app/features/catalog/presentation/pages/productDetailPage.dart';
import 'package:mini_katalog_app/features/catalog/presentation/widgets/bannerImage.dart';
import 'package:mini_katalog_app/features/catalog/presentation/widgets/catalogAppBar.dart';
import 'package:mini_katalog_app/features/catalog/presentation/widgets/productGrid.dart';
import 'package:shared_preferences/shared_preferences.dart';

//siz sayfaları incelerken kolaylık sağlamasıs açısından widgertsleri ve yollarını ekledim

class Catalogpage extends StatefulWidget {
  const Catalogpage({super.key});

  @override
  State<Catalogpage> createState() => _CatalogpageState();
}

class _CatalogpageState extends State<Catalogpage> {
  final ApiService apiService = ApiService();
  final TextEditingController _searchController = TextEditingController();
  List<Product> _product = [];
  bool _isLoading = false;
  String? _error = null;
  List<Product> _eklenmisProduct = [];
  List<Product> _filteredProducts = [];

  void go(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ProductDetailPage(product: product, isLoading: _isLoading),
      ),
    );
  }

  void _filterProducts(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredProducts = _product;
      } else {
        _filteredProducts = _product
            .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  Future<void> addList(Product product) async {
    final prefs = await SharedPreferences.getInstance();

    if (_eklenmisProduct.any((item) => item.id == product.id)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Bu ürün zaten sepetinizde!")),
      );
      return;
    } else {
      setState(() {
        _eklenmisProduct.add(product);
      });
      prefs.setString(
        "Sepet",
        jsonEncode(_eklenmisProduct.map((item) => item.toJson()).toList()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("${product.name} sepete eklendi!")),
      );
    }
  }

  Future<void> SaveLocal() async {
    final prefs = await SharedPreferences.getInstance();
    String? localData = prefs.getString("Product");

    setState(() {
      if (localData != null) {
        List<dynamic> datas = jsonDecode(localData);
        _product = datas.map((item) => Product.fromJson(item)).toList();
        _filteredProducts = _product;
        for (var element in datas) {
          print(element["name"]);
        }
      }
    });
  }

  Future<void> LoadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _error = null;
      _isLoading = true;
    });
    try {
      _product = await apiService.fetchProducts();
      _filteredProducts = _product;
      await prefs.setString(
        "Product",
        jsonEncode(_filteredProducts.map((item) => item.toJson()).toList()),
      );
    } catch (e) {
      _error = "bir hatayla karşılaşıldı ApiService ${e}";
      throw Exception(_error);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    SaveLocal().then((_) => LoadData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CatalogAppBar( // /widgets/catalogAppBar
        searchController: _searchController,
        onSearchChanged: _filterProducts,
        onCartTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  SepetPage(eklenmisProduct: _eklenmisProduct),
            ),
          );
        },
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator.adaptive())
          : _filteredProducts.isEmpty
          ? const Center(child: Text("Aradığınız ürün bulunamadı."))
          : Column(
            children: [
              BannerImage( // widgets/bannerImage 
                imagePath: "assets/img/banner.png",
              ), 
          
              Expanded(
                child: RefreshIndicator.adaptive(
                  onRefresh: () => SaveLocal().then((_)=>LoadData()),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        ProductGrid( //widgets/productGrid
                          products: _filteredProducts,
                          onAddCart: addList,
                          onProductTap: go,
                          currentSepet: _eklenmisProduct,
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ),
              
            ],
          ),
    );
  }
}
