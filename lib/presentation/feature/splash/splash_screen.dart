import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodpedia/injection.dart' as di;
import 'package:foodpedia/presentation/feature/home/bloc/food/food_bloc.dart';
import 'package:foodpedia/presentation/feature/home/bloc/home/home_bloc.dart';
import 'package:foodpedia/presentation/feature/home/homepage.dart';
import 'package:foodpedia/presentation/theme/color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 1500),
    vsync: this,
  );

  late final Animation<double> _animation = Tween(
    begin: 0.0,
    end: 1.0,
  ).animate(_controller);

  @override
  Widget build(BuildContext context) {
    _controller.forward();

    ColorScheme colorScheme = Theme.of(context).colorScheme;

    Future.delayed(
      const Duration(
        milliseconds: 2000,
      ),
      () {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(
              seconds: 1,
            ),
            pageBuilder: (context, animation, animationTime) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider<HomeBloc>(
                    create: (BuildContext context) => di.getIt<HomeBloc>(),
                  ),
                  BlocProvider<FoodBloc>(
                    create: (BuildContext context) => di.getIt<FoodBloc>(),
                  ),
                ],
                child: const HomePage(),
              );
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        );
      },
    );

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: createSplashGradient(
            color1: colorScheme.primary,
            color2: colorScheme.inversePrimary,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: _animation,
              child: Image.asset(
                'assets/logo.png',
                height: 300.w,
                width: 300.w,
              ),
            ),
            SizedBox(height: 20.h),
            FadeTransition(
              opacity: _animation,
              child: Text(
                "Foodpedia",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
