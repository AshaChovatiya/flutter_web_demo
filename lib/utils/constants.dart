import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Colors
const Color appColor = Color(0xFF00CCCC);
const Color btnColor1 = Color(0xFFFA9D6B);
Color blackColor = const Color(0XFF000000);
Color whiteColor = const Color(0XFFFFFFFF);
Color greyColor = const Color(0XFFA9A9A9);
Color transparentColor = Colors.transparent;

var apppadding26 = EdgeInsets.symmetric(horizontal: 26.w).copyWith(top: 20.h);
TextStyle regular18 = TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400);

// Text
var blackRegular16 = TextStyle(
    color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w600);
var greyRegular16 =
    TextStyle(color: greyColor, fontSize: 16.sp, fontWeight: FontWeight.w400);

var hintTextStyle = TextStyle(
  color: const Color(0xFFA6A6A6),
  fontSize: 18.sp,
);

var commonDivider = Container(
  width: double.infinity,
  alignment: Alignment.center,
  margin: EdgeInsets.symmetric(vertical: 8.h),
  child: Divider(color: const Color(0XFFD9D9D9), thickness: 1.sp),
);

String googleApiKey = "adcfaaaaadffasdasddd";
