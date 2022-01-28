import 'package:flutter/material.dart';
import 'package:my_instrument/src/data/models/view_models/card_item_model.dart';
import 'package:my_instrument/src/presentation/widgets/settings/settings_item.dart';
import 'package:styled_widget/styled_widget.dart';

class Settings extends StatelessWidget {
  final List<CardItemModel> settingsItems;

  const Settings({
    Key? key,
    required this.settingsItems
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => settingsItems
    .map((settingsItem) => SettingsItem(
      icon: settingsItem.icon,
      iconBgColor: settingsItem.color,
      title: settingsItem.title,
      description: settingsItem.description,
      onTap: (context) {
        if (settingsItem.onTap != null) {
          settingsItem.onTap!(context);
        }
      },
    ))
    .toList()
    .toColumn();
}
