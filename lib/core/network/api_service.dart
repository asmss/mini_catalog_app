import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mini_katalog_app/features/catalog/data/models/productModel.dart';
import 'package:http/http.dart' as http;

class ApiService extends ChangeNotifier {
  String baseURL = "https://wantapi.com";

  Future<List<Product>> fetchProducts() async {
    final res = await http.get(Uri.parse("$baseURL/products.php"));

    if (res.statusCode != 200) {
      throw Exception("Veriler çekilemedi: ${res.statusCode}");
    } else {
      final Map<String, dynamic> dataAll = json.decode(res.body);
      if (dataAll.containsKey('data') && dataAll['data'] is List) {
        List<dynamic> jsonData = dataAll["data"];

        return jsonData
            .map((toElement) => Product.fromJson(toElement))
            .toList();
      } else {
        throw Exception("Beklenen veri formatı bulunamadı.");
      }
    }
  }
}
