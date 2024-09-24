import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product_model.dart';
import 'package:http/http.dart' as http;

// Define ProductService as a provider
final productServiceProvider = Provider<ProductService>((ref) {
  return ProductService();
});

class ProductService {
  Future<List<Product>> fetchProducts() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
