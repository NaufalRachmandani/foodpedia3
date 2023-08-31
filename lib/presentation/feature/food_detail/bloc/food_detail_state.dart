part of 'food_detail_bloc.dart';

abstract class FoodDetailState extends Equatable {
  const FoodDetailState();
}

class FoodDetailLoadingState extends FoodDetailState {
  @override
  List<Object> get props => [];
}

class FoodDetailErrorState extends FoodDetailState {
  @override
  List<Object> get props => [];
}

class FoodDetailLoadedState extends FoodDetailState {
  final FoodDetailResponse foodDetailResponse;

  const FoodDetailLoadedState({required this.foodDetailResponse});

  @override
  List<Object> get props => [foodDetailResponse];
}