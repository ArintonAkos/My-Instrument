import 'package:flutter/material.dart';
import 'package:my_instrument/src/shared/theme/app_theme_data.dart';
import 'package:my_instrument/src/data/data_providers/change_notifiers/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';

class AuthPagesConstants {
  static const accountType = [
    "Individual seller",
    "Company"
  ];
}

const nHintTextStyle = TextStyle(
  color: Colors.black,
  fontFamily: 'OpenSans',
);

const kLabelStyle = TextStyle(
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
    padding: const EdgeInsets.symmetric(vertical: 25.0),
    width: double.infinity,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 5.0,
        padding: const EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        primary: customTheme?.loginButtonsColor,
        onPrimary: Colors.grey[400]
      ),
      onPressed: disabled ? null : onPressed,
      child: Text(
        buttonText,
        style: TextStyle(
          color: customTheme?.loginButtonText,
          letterSpacing: 1.5,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'OpenSans',
        ),
      ),
    ),
  );
}

Widget buildTF(String inputLabel, String hintText, AppThemeData? theme, IconData iconData,
{
  TextEditingController? inputController,
  TextInputType? textInputType,
  bool? obscureText,
  TextStyle? labelStyle,
  FormFieldValidator<String>? validator,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        inputLabel,
        style: labelStyle ?? kLabelStyle,
      ),
      const SizedBox(height: 10.0),
      Stack(
        children: [
          const SizedBox(
            height: 55,
            width: double.infinity,
          ).elevation(12, 
            shadowColor: Colors.black,
            borderRadius: BorderRadius.circular(10.0)
          ),
          TextFormField(
            keyboardType: textInputType,
            controller: inputController,
            obscureText: obscureText ?? false,
            validator: validator,
            style: TextStyle(
              color: theme?.materialTheme.colorScheme.onSurface,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              errorMaxLines: 3,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              filled: true,
              fillColor: theme?.materialTheme.colorScheme.surface,
              prefixIcon: Icon(
                iconData,
                color: theme?.materialTheme.colorScheme.onSurface.withOpacity(0.75),
                size: 23
              ),
              hintText: hintText,
              hintStyle: TextStyle(
                color: theme?.materialTheme.colorScheme.onSurface.withOpacity(0.65),
                fontFamily: 'OpenSans',
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

BoxDecoration nBoxDecorationStyle() {
  return const BoxDecoration(
    color: Colors.transparent,
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
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
    // decoration: kBoxDecorationStyle(Provider.of<ThemeNotifier>(context).getTheme()),
    child: DropdownButtonFormField(
      dropdownColor: Provider.of<ThemeNotifier>(context).getTheme()?.customTheme.dropdownItemColor,
      icon: const Icon(
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