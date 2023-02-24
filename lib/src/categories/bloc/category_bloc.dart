import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:fake_store/src/categories/repository/category_repository.dart';
import 'package:fake_store/src/core/domain/enums.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc(this.categoryRepository) : super(const CategoryState()) {
    on<CategoryRequested>(_onCategoryRequested);
  }
  final CategoryRepository categoryRepository;

  FutureOr<void> _onCategoryRequested(
    CategoryRequested event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      emit(state.copyWith(categoryStatus: CategoryStatus.loading));
      final categories = await categoryRepository.getCategories();
      emit(
        state.copyWith(
          categoryStatus: CategoryStatus.success,
          categories: categories,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(categoryStatus: CategoryStatus.failure),
      );
    }
  }
}
