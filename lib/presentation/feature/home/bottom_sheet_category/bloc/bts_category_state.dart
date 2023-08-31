part of 'bts_category_bloc.dart';

abstract class BtsCategoryState extends Equatable {
  const BtsCategoryState();
}

class BtsCategoryLoadingState extends BtsCategoryState {
  @override
  List<Object> get props => [];
}

class BtsCategoryNotFoundState extends BtsCategoryState {
  @override
  List<Object> get props => [];
}

class BtsCategoryLoadedState extends BtsCategoryState {
  final List<String> listCategory;
  final List<String> filteredListCategory;

  const BtsCategoryLoadedState({required this.listCategory, required this.filteredListCategory});

  @override
  List<Object> get props => [listCategory, filteredListCategory];
}