import 'dart:convert';
import 'package:fake_store/src/core/domain/constants.dart';
import 'package:http/http.dart' as http;

class CategoryRepository {
  Future<List<String>> getCategories() async {
    {
      try {
        final response = await http.get(
          Uri.parse(
            Constants.categoriesUrl,
          ),
        );
        if (response.statusCode == 200) {
          final data = json.decode(response.body) as List;
          final categories = data.map((e) => e as String).toList();
          return categories;
        } else {
          throw Exception('Failed to get Categories');
        }
      } catch (e) {
        rethrow;
      }
    }
  }
}
