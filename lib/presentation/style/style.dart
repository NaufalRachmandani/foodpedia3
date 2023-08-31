import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

InputDecoration styleWithSearchPrefix(ThemeData themeData,String hint) {
  return InputDecoration(
    prefixIcon: Container(
      margin: EdgeInsets.only(left: 20.w, right: 12.w),
      child: Image.asset(
        'assets/search_active.png',
        width: 18.w,
        height: 15.w,
        color: themeData.colorScheme.outline,
      ),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(10.r),
    ),
    hintText: hint,
    hintStyle: TextStyle(
      fontSize: 14.sp,
      color: themeData.colorScheme.outline,
      fontWeight: FontWeight.w400,
    ),
  );
}

InputDecoration styleBorderWithDropdown(ThemeData themeData, String hint) {
  return InputDecoration(
    suffixIcon: Icon(
      Icons.arrow_drop_down,
      color: themeData.colorScheme.outline,
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(5.r),
    ),
    hintText: hint,
    hintStyle: TextStyle(
      fontSize: 14.sp,
      color: themeData.colorScheme.outline,
      fontWeight: FontWeight.w400,
    ),
  );
}
