part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class UpdateCategoryEvent extends HomeEvent {
  final String category;

  const UpdateCategoryEvent({required this.category});

  @override
  List<Object> get props => [category];
}