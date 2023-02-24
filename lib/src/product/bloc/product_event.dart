part of 'product_bloc.dart';

abstract class ProductEvent {
  const ProductEvent();
}

class ProductRequested extends ProductEvent {}

class ProductDeleted extends ProductEvent {
  ProductDeleted(this.index);

  final int index;
}

class ProductViewChanged extends ProductEvent {}

class ProductSearched extends ProductEvent {
  ProductSearched(this.searchedText);

  final String searchedText;
}

class ProductByCategoryRequested extends ProductEvent {
  ProductByCategoryRequested(this.category);

  final String category;
}

class FilterViewChanged extends ProductEvent {
  FilterViewChanged(this.productFilterType);

  final ProductFilterType productFilterType;
}

class FiltersRemoved extends ProductEvent {
  FiltersRemoved(this.productFilterType, {this.remove = false});

  final ProductFilterType productFilterType;
  final bool remove;
}

class PriceFilterChanged extends ProductEvent {
  PriceFilterChanged(this.price);

  final int price;
}

class RatingFilterChanged extends ProductEvent {
  RatingFilterChanged(this.rating);

  final int rating;
}

class ProductsFiltered extends ProductEvent {}
