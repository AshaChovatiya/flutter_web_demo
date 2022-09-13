import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'constants.dart';

class CenterButton extends StatelessWidget {
  CenterButton({
    Key? key,
    required this.ontap,
    required this.text,
    this.bgColor = appColor,
    this.boxShadow = appColor,
    this.txtColor = Colors.white,
    this.fontWeight,
    this.isExpanded = false,
    this.showArrow = false,
    this.margin = 0,
    this.padding = 0,
    this.radius = 10,
    this.isProgress = false,
    this.fontsize = 15,
  }) : super(key: key);

  var ontap;
  final String text;
  final Color bgColor;
  final Color txtColor;
  final Color boxShadow;
  final FontWeight? fontWeight;
  final bool isExpanded;
  final bool isProgress;
  final bool showArrow;
  final double margin;
  final double padding;
  final double fontsize;
  final double radius;
  // final textStyle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          alignment: Alignment.center,
          height: 60.h,
          width: isExpanded ? double.infinity : null,
          margin: margin > 0 ? EdgeInsets.symmetric(horizontal: margin) : null,
          padding:
              padding > 0 ? EdgeInsets.symmetric(horizontal: padding) : null,
          decoration: BoxDecoration(
            color: bgColor,
            boxShadow: const [
              BoxShadow(
                color: Colors.transparent,
                offset: Offset(4, 8),
                blurRadius: 24,
                spreadRadius: -17,
              )
            ],
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: blackRegular16.copyWith(
                    color: txtColor,
                    fontSize: fontsize,
                    fontWeight: fontWeight),
              ),
              showArrow
                  ? Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Icon(Icons.east_outlined, color: txtColor),
                    )
                  : Container(
                      height: 0,
                    )
            ],
          ),
        ),
      ),
    );
  }
}
