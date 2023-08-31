part of 'food_bloc.dart';

abstract class FoodEvent extends Equatable {
  const FoodEvent();
}

class GetFoodListEvent extends FoodEvent {
  final String category;

  const GetFoodListEvent({required this.category});

  @override
  List<Object> get props => [category];
}