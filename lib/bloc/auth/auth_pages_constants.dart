import 'package:flutter/material.dart';
import 'package:my_instrument/shared/theme/app_theme_data.dart';

final kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

BoxDecoration kBoxDecorationStyle(AppThemeData? appThemeData) {
  return BoxDecoration(
    color: appThemeData?.customTheme.LoginInputColor,
    borderRadius: BorderRadius.circular(10.0),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 6.0,
        offset: Offset(0, 2),
      ),
    ],
  );
}