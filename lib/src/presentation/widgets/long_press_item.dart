import 'package:flutter/material.dart';
import 'package:my_instrument/src/presentation/widgets/popup.dart';
import 'package:my_instrument/src/presentation/widgets/popup_action.dart';
import 'package:uuid/uuid.dart';

typedef PreviewBuilder = Widget Function(BuildContext context);
typedef PopupBuilder = Widget Function(BuildContext context);

class LongPressItem extends StatelessWidget {
  late final String heroTag;
  late final String actionsTag;

  final PreviewBuilder previewBuilder;
  final PopupBuilder? popupBuilder;
  final List<PopupAction> actions;
  final int index;

  LongPressItem({
    Key? key,
    required this.previewBuilder,
    required this.actions,
    required this.index,
    this.popupBuilder
  }) : super(key: key) {
    heroTag = 'new-listing-page-hero-preview-item-$index';
    actionsTag = 'new-listing-page-hero-popup-action-item-$index';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          highlightColor: Colors.transparent,
          child: Hero(
            tag: heroTag,
            child: previewBuilder(context),
          ),
          onLongPress: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                opaque: false,
                pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => Popup(
                  actions: actions,
                  tag: heroTag,
                  actionsTag: actionsTag,
                  popupBuilder: popupBuilder ?? previewBuilder
                ),
              )
            );
          },
        ),
        Hero(
          tag: actionsTag,
          child: const SizedBox(height: 0),
        )
      ]
    );
  }
}
