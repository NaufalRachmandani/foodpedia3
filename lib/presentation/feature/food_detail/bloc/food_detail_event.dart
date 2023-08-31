part of 'food_detail_bloc.dart';

abstract class FoodDetailEvent extends Equatable {
  const FoodDetailEvent();
}

class GetFoodDetailEvent extends FoodDetailEvent {
  final String foodId;

  const GetFoodDetailEvent({required this.foodId});

  @override
  List<Object> get props => [foodId];
}