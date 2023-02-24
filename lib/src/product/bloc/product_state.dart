part of 'product_bloc.dart';

class ProductState {
  const ProductState({
    this.products = const [],
    this.productStatus = ProductStatus.initial,
    this.isListView = true,
    this.searchedList = const [],
    this.filteredList = const [],
    this.productFilterType = ProductFilterType.price,
    this.priceFilter = 0,
    this.ratingFilter = 0,
  });

  final ProductStatus productStatus;
  final List<Product> products;
  final bool isListView;
  final List<Product> searchedList;
  final List<Product> filteredList;
  final ProductFilterType productFilterType;
  final int priceFilter;
  final int ratingFilter;

  ProductState copyWith({
    ProductStatus? productStatus,
    List<Product>? products,
    bool? isListView,
    List<Product>? searchedList,
    List<Product>? filteredList,
    ProductFilterType? productFilterType,
    int? priceFilter,
    int? ratingFilter,
  }) {
    return ProductState(
      productStatus: productStatus ?? this.productStatus,
      products: products ?? this.products,
      isListView: isListView ?? this.isListView,
      searchedList: searchedList ?? this.searchedList,
      filteredList: filteredList ?? this.filteredList,
      productFilterType: productFilterType ?? this.productFilterType,
      priceFilter: priceFilter ?? this.priceFilter,
      ratingFilter: ratingFilter ?? this.ratingFilter,
    );
  }
}
