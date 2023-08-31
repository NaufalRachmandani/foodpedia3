import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodpedia/data/food/response/food_list_response.dart';
import 'package:foodpedia/injection.dart' as di;
import 'package:foodpedia/presentation/feature/food_detail/bloc/food_detail_bloc.dart';
import 'package:foodpedia/presentation/feature/food_detail/food_detail_page.dart';
import 'package:foodpedia/presentation/feature/home/bloc/food/food_bloc.dart';
import 'package:foodpedia/presentation/feature/home/bloc/home/home_bloc.dart';
import 'package:foodpedia/presentation/feature/home/bottom_sheet_category/bloc/bts_category_bloc.dart';
import 'package:foodpedia/presentation/feature/home/bottom_sheet_category/bottom_sheet_category.dart';
import 'package:foodpedia/presentation/style/style.dart';
import 'package:foodpedia/presentation/widget/ink_effect.dart';
import 'package:foodpedia/presentation/widget/skeleton_loading.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController categoryTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Foodpedia",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: themeData.colorScheme.primary,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              SizedBox(
                height: 16.h,
              ),
              _typeFormCategory(),
              SizedBox(
                height: 16.h,
              ),
              buildList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _typeFormCategory() {
    ThemeData themeData = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: Image.asset(
                  'assets/logo.png',
                  width: 21.w,
                  height: 19.w,
                ),
              ),
              WidgetSpan(
                child: SizedBox(
                  width: 8.w,
                ),
              ),
              TextSpan(
                text: 'Food Category',
                style: TextStyle(
                  color: themeData.colorScheme.primary,
                  fontSize: 12.sp,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(
                text: '*',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 12.sp,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 6.h,
        ),
        textFieldCategory(context, categoryTextController),
      ],
    );
  }

  Widget textFieldCategory(BuildContext homepageContext,
      TextEditingController textEditingController) {
    ThemeData themeData = Theme.of(context);

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          isDismissible: true,
          backgroundColor: Colors.transparent,
          context: homepageContext,
          builder: (context) {
            return BlocProvider(
              create: (context) =>
                  di.getIt<BtsCategoryBloc>()..add(BtsGetCategoryEvent()),
              child: BottomSheetCategory(
                homepageContext: homepageContext,
              ),
            );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          color: Colors.white,
        ),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeInitialState) {
              textEditingController.value =
                  textEditingController.value.copyWith(text: state.category);

              if (state.category != null) {
                BlocProvider.of<FoodBloc>(context)
                    .add(GetFoodListEvent(category: state.category ?? ''));
              }
            }
            return TextFormField(
              style: TextStyle(
                fontSize: 14.sp,
                color: themeData.colorScheme.outline,
                fontWeight: FontWeight.w400,
              ),
              controller: textEditingController,
              decoration: styleBorderWithDropdown(themeData, "Select category"),
              enabled: false,
            );
          },
        ),
      ),
    );
  }

  Widget buildList() {
    return BlocBuilder<FoodBloc, FoodState>(
      builder: (context, state) {
        if (state is FoodLoadedState) {
          FoodListResponse? foodListResponse = state.foodListResponse;

          return ListView.separated(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: foodListResponse.meals?.length ?? 0,
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 20.h,
              );
            },
            itemBuilder: (context, index) {
              Meals? meal = foodListResponse.meals?.elementAt(index);

              return _buildListCard(
                meal,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (builder) => MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (context) => di.getIt<FoodDetailBloc>()
                              ..add(GetFoodDetailEvent(
                                foodId: meal?.idMeal ?? '',
                              )),
                          ),
                        ],
                        child: FoodDetailPage(
                          foodId: meal?.idMeal ?? '',
                          foodName: meal?.strMeal ?? '',
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        } else if (state is FoodErrorState) {
          return const Text("Failed load data");
        } else if (state is FoodLoadingState) {
          return foodLoading();
        } else {
          //initial state
          return Container();
        }
      },
    );
  }

  Widget foodLoading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.separated(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (BuildContext context, index) {
            return foodCardSkeleton();
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 20.h,
            );
          },
        ),
      ],
    );
  }

  Widget _buildListCard(
    Meals? meal,
    VoidCallback onTap,
  ) {
    ThemeData themeData = Theme.of(context);

    return InkEffect(
      onTap: onTap,
      boxDecoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              meal?.strMealThumb ?? '',
              width: 60.w,
              height: 60.w,
              fit: BoxFit.contain,
            ),
            SizedBox(
              width: 12.w,
            ),
            Flexible(
              child: Text(
                meal?.strMeal ?? '',
                style: TextStyle(
                  color: themeData.colorScheme.outline,
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget foodCardSkeleton() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkeletonLoading(
            width: 60.w,
            height: 60.w,
            cornerRadius: 10.r,
          ),
          SizedBox(
            width: 12.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonLoading(width: double.infinity, height: 15.h),
                SizedBox(
                  height: 8.h,
                ),
                SkeletonLoading(width: double.infinity, height: 15.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    categoryTextController.dispose();
    super.dispose();
  }
}
