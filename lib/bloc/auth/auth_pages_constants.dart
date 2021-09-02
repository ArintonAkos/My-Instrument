import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_instrument/shared/data/page_data.dart';
import 'package:my_instrument/shared/theme/app_theme_data.dart';
import 'package:my_instrument/shared/theme/theme_manager.dart';
import 'package:provider/provider.dart';

class AuthPagesConstants {
  static const List<String> AccountType = [
    "Individual seller",
    "Company"
  ];
}

final kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

Container buildAuthButton(
  String buttonText,
  CustomAppTheme? customTheme,
  {
    VoidCallback? onPressed,
    bool disabled = false
  }) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 25.0),
    width: double.infinity,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 5.0,
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          primary: customTheme?.LoginButtonsColor,
          onPrimary: Colors.grey[400]
      ),
      onPressed: disabled ? null : onPressed,
      child: Text(
        buttonText,
        style: TextStyle(
          color: customTheme?.LoginButtonText,
          letterSpacing: 1.5,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'OpenSans',
        ),
      ),
    ),
  );
}

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

Widget buildTF(String inputLabel, String hintText, AppThemeData? theme, IconData iconData,
    {
      TextEditingController? inputController,
      TextInputType? textInputType,
      bool? obscureText
    }) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        inputLabel,
        style: kLabelStyle,
      ),
      SizedBox(height: 10.0),
      Container(
        alignment: Alignment.centerLeft,
        decoration: kBoxDecorationStyle(theme),
        height: 60.0,
        child: TextField(
          keyboardType: textInputType,
          controller: inputController,
          obscureText: obscureText ?? false,
          style: TextStyle(
            color: theme?.materialTheme.colorScheme.onPrimary,
            fontFamily: 'OpenSans',
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14.0),
            prefixIcon: Icon(
              iconData,
              color: Colors.white,
            ),
            hintText: hintText,
            hintStyle: kHintTextStyle,
          ),
        ),
      ),
    ],
  );
}

Widget buildDropDownInput(BuildContext context, List<String> data, int index, void Function(String?)? onChanged, {
  String? inputLabel
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        inputLabel ?? '',
        style: kLabelStyle,
      ),
      SizedBox(height: inputLabel != null ? 10.0 : 0.0),
      buildDropDown(context, data, index, onChanged)
    ],
  );
}

Widget buildDropDown(BuildContext context, List<String> data, int index, void Function(String?)? onChanged) {
  return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: kBoxDecorationStyle(Provider.of<ThemeNotifier>(context).getTheme()),
      child: DropdownButtonFormField(
        dropdownColor: Provider.of<ThemeNotifier>(context).getTheme()?.customTheme.DropdownItemColor,
        icon: Icon(
            Icons.arrow_drop_down,
            color: Colors.white
        ),
        value: data[index],
        decoration: const InputDecoration.collapsed(
          hintText: '',
        ),
        onChanged: onChanged,
        items: data.map((String val) {
          return DropdownMenuItem(
            value: val,
            child: Text(
              val,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary
              ),
            ),
          );
        }).toList(),
      )
  );
}