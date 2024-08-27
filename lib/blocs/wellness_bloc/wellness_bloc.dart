import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payuung_pribadi_app/models/wellness_model.dart';
import 'package:payuung_pribadi_app/repos/wellness_repository.dart';

abstract class WellnessEvent {}

class LoadWellnessItems extends WellnessEvent {}

abstract class WellnessState {}

class WellnessLoading extends WellnessState {}

class WellnessLoaded extends WellnessState {
  final List<Wellness> wellnessItems;

  WellnessLoaded({required this.wellnessItems});
}

class WellnessError extends WellnessState {
  final String message;

  WellnessError({required this.message});
}

class WellnessBloc extends Bloc<WellnessEvent, WellnessState> {
  final WellnessRepository wellnessRepository;

  WellnessBloc({required this.wellnessRepository}) : super(WellnessLoading()) {
    on<LoadWellnessItems>(_onLoadWellnessItems);
  }

  void _onLoadWellnessItems(
      LoadWellnessItems event, Emitter<WellnessState> emit) async {
    try {
      final wellnessItems = wellnessRepository.getWellnessItems();
      emit(WellnessLoaded(wellnessItems: wellnessItems));
    } catch (e) {
      emit(WellnessError(message: e.toString()));
    }
  }
}
