import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeInitialState()) {
    on<UpdateCategoryEvent>(_updateCategory);
  }

  void _updateCategory(
      UpdateCategoryEvent event, Emitter<HomeState> emit) async {
    emit(HomeInitialState(category: event.category));
  }
}
