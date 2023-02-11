import 'dart:convert';

import 'package:flutter_challenge_ronisetiawan/dashboard/model/product.dart';
import 'package:http/http.dart' as http;

class ProductRepository {
  Future<List<Product>> getProduct() async {
    final response = await http.get(
      Uri.parse('https://dummyjson.com/products'),
    );

    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body)['products'];
      return jsonResponse.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load product.');
    }
  }
}
