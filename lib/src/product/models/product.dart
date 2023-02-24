import 'package:fake_store/src/product/models/rating.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  const Product({
    this.id = 0,
    this.title = '',
    this.price = 0,
    this.description = '',
    this.category = '',
    this.image = '',
    this.rating = const Rating(),
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);

  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final Rating rating;

  static const empty = Product();
}
