import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget btsNotFound(String text) {
  return Center(
      child: Column(
        children: [
          SizedBox(
            height: 50.h,
          ),
          Image.asset(
            'assets/data_not_found.png',
            width: 198.w,
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            "Ups, " + text,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            "Go check your keyword again or\ntry another keyword",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
          )
        ],
      ));
}