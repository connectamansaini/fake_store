part of 'category_bloc.dart';

class CategoryState {
  const CategoryState({
    this.categoryStatus = CategoryStatus.initial,
    this.categories = const [],
  });

  final CategoryStatus categoryStatus;
  final List<String> categories;

  CategoryState copyWith({
    CategoryStatus? categoryStatus,
    List<String>? categories,
  }) {
    return CategoryState(
      categoryStatus: categoryStatus ?? this.categoryStatus,
      categories: categories ?? this.categories,
    );
  }
}
