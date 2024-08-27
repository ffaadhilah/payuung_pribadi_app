import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payuung_pribadi_app/models/product_model.dart';
import 'package:payuung_pribadi_app/models/category_model.dart';
import 'package:payuung_pribadi_app/models/wellness_model.dart';
import 'package:payuung_pribadi_app/repos/product_repository.dart';
import 'package:payuung_pribadi_app/repos/category_repository.dart';
import 'package:payuung_pribadi_app/repos/wellness_repository.dart';

abstract class HomeEvent {}

class LoadHomePage extends HomeEvent {}

abstract class HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Product> products;
  final List<Category> categories;
  final List<Wellness> wellnessItems;

  HomeLoaded(
      {required this.products,
      required this.categories,
      required this.wellnessItems});
}

class HomeError extends HomeState {
  final String message;

  HomeError({required this.message});
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ProductRepository productRepository;
  final CategoryRepository categoryRepository;
  final WellnessRepository wellnessRepository;

  HomeBloc({
    required this.productRepository,
    required this.categoryRepository,
    required this.wellnessRepository,
  }) : super(HomeLoading()) {
    on<LoadHomePage>(_onLoadHomePage);
  }

  void _onLoadHomePage(LoadHomePage event, Emitter<HomeState> emit) async {
    try {
      final products = productRepository.getProducts();
      final categories = categoryRepository.getCategories();
      final wellnessItems = wellnessRepository.getWellnessItems();
      emit(HomeLoaded(
        products: products,
        categories: categories,
        wellnessItems: wellnessItems,
      ));
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }
}
