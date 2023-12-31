import 'package:dio/dio.dart';
import 'package:foodpedia/data/common/dio.dart';
import 'package:foodpedia/presentation/feature/food_detail/bloc/food_detail_bloc.dart';
import 'package:foodpedia/presentation/feature/home/bloc/food/food_bloc.dart';
import 'package:foodpedia/presentation/feature/home/bloc/home/home_bloc.dart';
import 'package:foodpedia/presentation/feature/home/bottom_sheet_category/bloc/bts_category_bloc.dart';
import 'package:get_it/get_it.dart';

import 'data/food/food_repository.dart';

final getIt = GetIt.instance;

void init() {
  initRepository();
  initBloc();

  getIt.registerLazySingleton<Dio>(() => configureDio());
}

void initRepository() {
  getIt.registerLazySingleton<FoodRepository>(
    () => FoodRepository(dio: getIt.get<Dio>()),
  );
}

void initBloc() {
  getIt.registerFactory(
    () => HomeBloc(),
  );

  getIt.registerFactory(
    () => BtsCategoryBloc(
      foodRepository: getIt.get<FoodRepository>(),
    ),
  );

  getIt.registerFactory(
    () => FoodBloc(
      foodRepository: getIt.get<FoodRepository>(),
    ),
  );

  getIt.registerFactory(
    () => FoodDetailBloc(
      foodRepository: getIt.get<FoodRepository>(),
    ),
  );
}
