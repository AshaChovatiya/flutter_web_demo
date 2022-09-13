import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'constants.dart';

class CommonTextfield extends StatelessWidget {
  CommonTextfield({
    Key? key,
    this.labelText,
    required this.controller,
    required this.hintText,
    this.textInput = TextInputType.text,
    this.textAlign = TextAlign.left,
    this.isSecure = false,
    this.isDisabled = false,
    this.isDigitsOnly = false,
    this.maxLength,
    this.suffixWidget,
    this.prefixWidget,
    this.focus,
    this.validation,
    this.emptyValidation = true,
    this.nextFocus,
    this.onChange,
    this.maxLine,
    this.contentPadding,
    this.fillColor,
    this.counterText,
  }) : super(key: key);

  String? labelText;
  final TextEditingController controller;
  final TextInputType textInput;
  final TextAlign textAlign;
  final String hintText;
  int? maxLength;
  bool isSecure;
  bool isDisabled = false;
  bool isDigitsOnly;
  bool emptyValidation;
  FocusNode? focus;
  Widget? suffixWidget;
  Widget? prefixWidget;
  var validation;
  var nextFocus;
  var onChange;
  int? maxLine;
  Color? fillColor;
  EdgeInsetsGeometry? contentPadding;
  String? counterText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 3),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: greyColor),
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: textInput,
            textInputAction: TextInputAction.next,
            inputFormatters: isDigitsOnly
                ? [
                    FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      try {
                        final text = newValue.text;
                        if (text.isNotEmpty) double.parse(text);
                        return newValue;
                      } catch (e) {}
                      return oldValue;
                    }),
                  ]
                : null,
            maxLength: maxLength,
            maxLines: maxLine,
            obscureText: isSecure,
            focusNode: focus,
            cursorColor: blackColor,
            // enabled: isDisabled,
            textAlignVertical: TextAlignVertical.bottom,
            textAlign: textAlign,
            style: regular18,
            decoration: InputDecoration(
                counterText: counterText,
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(
                    right: 15,
                  ),
                  child: suffixWidget,
                ),
                prefixIcon: Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 2),
                  child: prefixWidget,
                ),
                prefixIconConstraints: const BoxConstraints(maxHeight: 24),
                filled: true,
                fillColor: fillColor ?? Colors.transparent,
                suffixIconConstraints: const BoxConstraints(maxHeight: 24),
                hintText: hintText,
                hintStyle: hintTextStyle,
                contentPadding: contentPadding ??
                    const EdgeInsets.only(bottom: 15, top: 15, left: 15),
                isDense: true,
                border: InputBorder.none
                // focusedBorder: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(10.r),
                //   borderSide: BorderSide(color: greyColor),
                // ),
                // enabledBorder: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(10.r),
                //   borderSide: BorderSide(color: greyColor),
                // ),
                // disabledBorder: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(10.r),
                //   borderSide: BorderSide(color: greyColor),
                // ),
                // border: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(10.r),
                //   borderSide: BorderSide(color: greyColor),
                // ),
                ),
            validator: emptyValidation
                ? (value) {
                    if (value == null || value.isEmpty) {
                      return '$hintText Required';
                    }
                    return null;
                  }
                : validation,
            onEditingComplete: nextFocus,
            onChanged: onChange,
          ),
        ),
      ],
    );
  }
}
