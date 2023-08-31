import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodpedia/data/food/response/food_detail_response.dart';
import 'package:foodpedia/presentation/feature/food_detail/bloc/food_detail_bloc.dart';

class FoodDetailPage extends StatefulWidget {
  final String? foodId;
  final String? foodName;

  const FoodDetailPage({Key? key, required this.foodId, required this.foodName})
      : super(key: key);

  @override
  State<FoodDetailPage> createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.foodName ?? 'Foodpedia',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: themeData.colorScheme.primary,
        centerTitle: true,
      ),
      body: BlocBuilder<FoodDetailBloc, FoodDetailState>(
        builder: (context, state) {
          if (state is FoodDetailErrorState) {
            return const Center(
              child: Text("Failed load data"),
            );
          } else if (state is FoodDetailLoadedState) {
            Meals? meal = state.foodDetailResponse.meals?.first;

            return SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    Image.network(
                      meal?.strMealThumb ?? '',
                      width: double.infinity,
                      height: 200.h,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Text(
                      meal?.strMeal ?? '',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: themeData.colorScheme.outline,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Text(
                      meal?.strArea ?? '',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: themeData.colorScheme.outline,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      meal?.strTags ?? '',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: themeData.colorScheme.outline,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Text(
                      meal?.strInstructions ?? '',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: themeData.colorScheme.outline,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}