import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodpedia/data/food/food_repository.dart';
import 'package:foodpedia/data/food/response/food_list_response.dart';

part 'food_event.dart';

part 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  final FoodRepository foodRepository;

  FoodBloc({required this.foodRepository}) : super(FoodInitialState()) {
    on<GetFoodListEvent>(_getFoodList);
  }

  void _getFoodList(GetFoodListEvent event, Emitter<FoodState> emit) async {
    emit(FoodLoadingState());
    final result = await foodRepository.getFoodList(event.category);

    await result.fold(
      (failure) async {
        emit(FoodErrorState());
      },
      (response) async {
        emit(
          FoodLoadedState(foodListResponse: response),
        );
      },
    );
  }
}
