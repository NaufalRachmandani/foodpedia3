part of 'bts_category_bloc.dart';

abstract class BtsCategoryEvent extends Equatable {
  const BtsCategoryEvent();
}

class BtsGetCategoryEvent extends BtsCategoryEvent {
  @override
  List<Object> get props => [];
}

class BtsSearchCategoryEvent extends BtsCategoryEvent {
  final String query;

  const BtsSearchCategoryEvent({required this.query});

  @override
  List<Object> get props => [query];
}