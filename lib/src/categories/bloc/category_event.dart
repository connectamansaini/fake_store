part of 'category_bloc.dart';

abstract class CategoryEvent {
  const CategoryEvent();
}

class CategoryRequested extends CategoryEvent {}
