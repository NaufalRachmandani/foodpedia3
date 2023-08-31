part of 'food_bloc.dart';

abstract class FoodState extends Equatable {
  const FoodState();
}

class FoodInitialState extends FoodState {
  @override
  List<Object> get props => [];
}

class FoodLoadingState extends FoodState {
  @override
  List<Object> get props => [];
}

class FoodErrorState extends FoodState {
  @override
  List<Object> get props => [];
}

class FoodLoadedState extends FoodState {
  final FoodListResponse foodListResponse;

  const FoodLoadedState({required this.foodListResponse});

  @override
  List<Object> get props => [foodListResponse];
}
