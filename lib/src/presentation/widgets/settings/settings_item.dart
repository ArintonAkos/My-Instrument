import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

class SettingsItem extends StatefulWidget {
  const SettingsItem({
    Key? key,
    required this.icon,
    required this.iconBgColor,
    required this.title,
    required this.description,
    this.onTap
  }) : super (key: key);

  final IconData icon;
  final Color iconBgColor;
  final String title;
  final String description;
  final Function(BuildContext context)? onTap;

  @override
  _SettingsItemState createState() => _SettingsItemState();
}

class _SettingsItemState extends State<SettingsItem> {
  bool pressed = false;

  settingsItem({required Widget child}) => Styled.widget(child: child)
    .alignment(Alignment.center)
    .borderRadius(all: 15)
    .ripple()
    .backgroundColor(
      Theme.of(context).cardColor,
      animate: true
    )
    .clipRRect(all: 25) // clip ripple
    .borderRadius(all: 25, animate: true)
    .elevation(
      pressed
        ? 0
        : 20,
      borderRadius: BorderRadius.circular(25),
      shadowColor: Colors.grey.withOpacity(0.25),
    )
    .constrained(height: 80)
    .padding(vertical: 12) // margin
    .gestures(
      onTapChange: (tapStatus) => setState(() => pressed = tapStatus),
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!(context);
        }
      },
    )
    .scale(all: pressed ? 0.95 : 1.0, animate: true)
    .animate(
      const Duration(milliseconds: 150),
      Curves.easeOut
    );

  @override
  Widget build(BuildContext context) {
    final Widget icon = Icon(widget.icon, size: 20, color: Colors.white)
        .padding(all: 12)
        .decorated(
      color: widget.iconBgColor,
      borderRadius: BorderRadius.circular(30),
    )
        .padding(left: 15, right: 10);

    final Widget title = Text(
      widget.title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    ).padding(bottom: 5);

    final Widget description = Text(
      widget.description,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
    );

    return settingsItem(
      child: <Widget>[
        icon,
        <Widget>[
          title,
          description,
        ].toColumn(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ].toRow(),
    );
  }
}