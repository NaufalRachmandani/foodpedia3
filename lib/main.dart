import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodpedia/presentation/feature/splash/splash_screen.dart';

import 'package:foodpedia/presentation/theme/theme_data.dart';
import 'package:foodpedia/injection.dart' as di;

void main() {
  di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'FoodPedia',
          theme: lightThemeData,
          darkTheme: darkThemeData,
          home: child,
        );
      },
      child: const SplashScreen(),
    );
  }
}