import 'package:flutter/material.dart';
import 'package:my_instrument/src/shared/theme/app_theme_data.dart';
import 'package:my_instrument/src/data/data_providers/change_notifiers/theme_manager.dart';
import 'package:provider/provider.dart';

/// Please use it like this when calling: getCustomTheme(context)?.yourProperty
/// ? is necessary, because an error could be thrown
/// @param context The build context whose provider will be acquired
CustomAppTheme? getCustomTheme(BuildContext context) {
  return Provider.of<ThemeNotifier>(context).getTheme()?.customTheme;
}