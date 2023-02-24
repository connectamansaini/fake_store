import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fake_store/src/core/domain/enums.dart';
import 'package:fake_store/src/product/models/product.dart';
import 'package:fake_store/src/product/repository/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc(this.productRepository) : super(const ProductState()) {
    on<ProductRequested>(_onProductRequested);
    on<ProductDeleted>(_onProductDeleted);
    on<ProductByCategoryRequested>(_onProductByCategoryRequested);
    on<ProductViewChanged>(_onProductViewChanged);
    on<ProductSearched>(_onProductSearched);
    on<FiltersRemoved>(_onFiltersRemoved);
    on<PriceFilterChanged>(_onPriceFilterChanged);
    on<RatingFilterChanged>(_onRatingFilterChanged);
    on<ProductsFiltered>(_onProductsFiltered);
    on<FilterViewChanged>(_onFilterViewChanged);
  }
  final ProductRepository productRepository;

  Future<void> _onProductRequested(
    ProductRequested event,
    Emitter<ProductState> emit,
  ) async {
    try {
      emit(state.copyWith(productStatus: ProductStatus.loading));

      final product = await productRepository.getProductData();
      emit(
        state.copyWith(
          products: product,
          productStatus: ProductStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(productStatus: ProductStatus.failure),
      );
    }
  }

  Future<void> _onProductDeleted(
    ProductDeleted event,
    Emitter<ProductState> emit,
  ) async {
    final currentList = List.of(state.products)..removeAt(event.index);
    emit(state.copyWith(products: currentList));
  }

  Future<void> _onProductByCategoryRequested(
    ProductByCategoryRequested event,
    Emitter<ProductState> emit,
  ) async {
    try {
      emit(state.copyWith(productStatus: ProductStatus.loading));

      final product =
          await productRepository.getProductsByCategory(event.category);
      emit(
        state.copyWith(
          products: product,
          productStatus: ProductStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(productStatus: ProductStatus.failure),
      );
    }
  }

  void _onProductViewChanged(
    ProductViewChanged event,
    Emitter<ProductState> emit,
  ) {
    emit(state.copyWith(isListView: !state.isListView));
  }

  void _onProductSearched(
    ProductSearched event,
    Emitter<ProductState> emit,
  ) {
    final searchedList = List.of(state.products)
        .where(
          (element) =>
              element.title.contains(event.searchedText) ||
              element.description.contains(event.searchedText),
        )
        .toList();

    emit(state.copyWith(searchedList: searchedList));
  }

  void _onPriceFilterChanged(
    PriceFilterChanged event,
    Emitter<ProductState> emit,
  ) {
    emit(state.copyWith(priceFilter: event.price));
  }

  void _onRatingFilterChanged(
    RatingFilterChanged event,
    Emitter<ProductState> emit,
  ) {
    emit(state.copyWith(ratingFilter: event.rating));
  }

  void _onProductsFiltered(
    ProductsFiltered event,
    Emitter<ProductState> emit,
  ) {
    final filteredList = <Product>[];
    final list = List.of(state.products);
    var flag = false;
    if (state.priceFilter != 0 && state.ratingFilter != 0) {
      filteredList.addAll(
        list
            .where(
              (product) =>
                  product.price <= state.priceFilter &&
                  product.rating.rate >= state.ratingFilter,
            )
            .toList(),
      );
      flag = true;
    }
    if (state.priceFilter != 0 && flag == false) {
      filteredList.addAll(
        list.where((product) => product.price <= state.priceFilter).toList(),
      );
    }
    if (state.ratingFilter != 0 && flag == false) {
      filteredList.addAll(
        list
            .where((product) => product.rating.rate >= state.ratingFilter)
            .toList(),
      );
    }
    emit(state.copyWith(filteredList: filteredList));
  }

  void _onFiltersRemoved(
    FiltersRemoved event,
    Emitter<ProductState> emit,
  ) {
    emit(
      state.copyWith(
        priceFilter: 0,
        ratingFilter: 0,
        filteredList: [],
      ),
    );
  }

  void _onFilterViewChanged(
    FilterViewChanged event,
    Emitter<ProductState> emit,
  ) {
    emit(state.copyWith(productFilterType: event.productFilterType));
  }
}
