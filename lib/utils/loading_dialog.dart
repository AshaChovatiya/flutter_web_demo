import 'package:ayi_connect/utils/constants.dart';
import 'package:flutter/material.dart';

showLoader(context) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => true,
          child: const Center(
            child: CircularProgressIndicator(
              color: appColor,
            ),
          ),
        );
      });
}
