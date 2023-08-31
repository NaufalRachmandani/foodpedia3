part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitialState extends HomeState {
  final String? category;

  const HomeInitialState({this.category});

  @override
  List<Object> get props => [category ?? ''];
}
