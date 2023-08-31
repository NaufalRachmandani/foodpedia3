import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodpedia/data/food/food_repository.dart';
import 'package:foodpedia/data/food/response/food_detail_response.dart';

part 'food_detail_event.dart';

part 'food_detail_state.dart';

class FoodDetailBloc extends Bloc<FoodDetailEvent, FoodDetailState> {
  final FoodRepository foodRepository;

  FoodDetailBloc({required this.foodRepository})
      : super(FoodDetailLoadingState()) {
    on<GetFoodDetailEvent>(_getFoodList);
  }

  void _getFoodList(
      GetFoodDetailEvent event, Emitter<FoodDetailState> emit) async {
    final result = await foodRepository.getFoodDetail(event.foodId);

    await result.fold(
      (failure) async {
        emit(FoodDetailErrorState());
      },
      (response) async {
        emit(FoodDetailLoadedState(foodDetailResponse: response));
      },
    );
  }
}
