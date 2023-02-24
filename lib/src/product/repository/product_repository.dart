import 'dart:convert';
import 'package:fake_store/src/core/domain/constants.dart';
import 'package:fake_store/src/product/models/product.dart';
import 'package:http/http.dart' as http;

class ProductRepository {
  Future<List<Product>> getProductData() async {
    try {
      final response = await http.get(
        Uri.parse(
          Constants.baseUrl,
        ),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        final product = data
            .map((e) => Product.fromJson(e as Map<String, dynamic>))
            .toList();
        return product;
      } else {
        throw Exception('Failed to get Products');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Product>> getProductsByCategory(String category) async {
    try {
      final response = await http.get(
        Uri.parse(Constants.productsByCategory + category),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        final product = data
            .map((e) => Product.fromJson(e as Map<String, dynamic>))
            .toList();
        return product;
      } else {
        throw Exception('Failed to get Products by category');
      }
    } catch (e) {
      rethrow;
    }
  }
}
