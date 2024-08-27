import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payuung_pribadi_app/models/category_model.dart';
import 'package:payuung_pribadi_app/repos/category_repository.dart';

abstract class CategoryEvent {}

class LoadCategories extends CategoryEvent {}

abstract class CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<Category> categories;

  CategoryLoaded({required this.categories});
}

class CategoryError extends CategoryState {
  final String message;

  CategoryError({required this.message});
}

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository categoryRepository;

  CategoryBloc({required this.categoryRepository}) : super(CategoryLoading()) {
    on<LoadCategories>(_onLoadCategories);
  }

  void _onLoadCategories(
      LoadCategories event, Emitter<CategoryState> emit) async {
    try {
      final categories = categoryRepository.getCategories();
      emit(CategoryLoaded(categories: categories));
    } catch (e) {
      emit(CategoryError(message: e.toString()));
    }
  }
}
