import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:foodpedia/data/common/base_url.dart';
import 'package:foodpedia/data/common/dio.dart';
import 'package:foodpedia/data/food/response/food_category_response.dart';
import 'package:foodpedia/data/food/response/food_detail_response.dart';
import 'package:foodpedia/data/food/response/food_list_response.dart';

import '../common/failure.dart';

class FoodRepository {
  final Dio dio;

  FoodRepository({required this.dio});

  Future<Either<Failure, FoodCategoryResponse>> getFoodCategory() async {
    try {
      final response = await dio.get("$urlStaging/list.php?c=list");

      return Right(FoodCategoryResponse.fromJson(response.data));
    } on DioException catch (e) {
      return Left(dioException(e));
    } catch (e) {
      return Left(ServerFailure(""));
    }
  }

  Future<Either<Failure, FoodListResponse>> getFoodList(
      String? category) async {
    try {
      final response = await dio.get("$urlStaging/filter.php?c=$category");

      return Right(FoodListResponse.fromJson(response.data));
    } on DioException catch (e) {
      return Left(dioException(e));
    } catch (e) {
      return Left(ServerFailure(""));
    }
  }

  Future<Either<Failure, FoodDetailResponse>> getFoodDetail(
      String? foodId) async {
    try {
      final response = await dio.get("$urlStaging/lookup.php?i=$foodId");

      return Right(FoodDetailResponse.fromJson(response.data));
    } on DioException catch (e) {
      return Left(dioException(e));
    } catch (e) {
      return Left(ServerFailure(""));
    }
  }
}
