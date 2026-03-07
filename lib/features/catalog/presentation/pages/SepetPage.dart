import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mini_katalog_app/features/catalog/data/models/productModel.dart';
import 'package:mini_katalog_app/features/catalog/presentation/widgets/sepetCenter.dart';
import 'package:mini_katalog_app/features/catalog/presentation/widgets/sepetExpanded.dart';
import 'package:shared_preferences/shared_preferences.dart';

//siz sayfaları incelerken kolaylık sağlamasıs açısından widgertsleri ve yollarını ekledim 


class SepetPage extends StatefulWidget {
  final List<Product> _eklenmisProduct;

  const SepetPage({super.key, required List<Product> eklenmisProduct})
    : _eklenmisProduct = eklenmisProduct;

  @override
  State<SepetPage> createState() => _SepetPageState();
}

class _SepetPageState extends State<SepetPage> {
  Future<void> removeCard(item) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      widget._eklenmisProduct.removeWhere((product) => product.id == item.id);
    });
    String? datas = jsonEncode(
      widget._eklenmisProduct.map((toElement) => toElement.toJson()).toList(),
    );
    prefs.setString("Sepet", datas);
  }

  Future<void> _loadBasketFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    String? sepetDatas = prefs.getString("Sepet");

    if (sepetDatas != null) {
      setState(() {
        List<dynamic> savedData = jsonDecode(sepetDatas);
        widget._eklenmisProduct.clear();
        widget._eklenmisProduct.addAll(
          savedData.map((item) => Product.fromJson(item)).toList(),
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadBasketFromPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: SizedBox(
        width: 250,
        child: FloatingActionButton.extended(
          onPressed: () {},
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(color: Colors.black, width: 10),
          ),
          label: Text("Checkout", style: TextStyle(color: Colors.white)),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      
      body: RefreshIndicator.adaptive(
        onRefresh: () => _loadBasketFromPrefs(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            widget._eklenmisProduct.isEmpty
                ? center() // widgets/sepetCenter
                : Sepetexpanded( //widgets/sepetExpanded
                    eklenmisProduct: widget._eklenmisProduct,
                    removeCard: removeCard,
                  ),
          ],
        ),
      ),
    );
  }
}
