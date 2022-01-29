import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_instrument/src/presentation/widgets/long_press_item.dart';
import 'package:my_instrument/src/presentation/widgets/popup_action.dart';

class Popup extends StatelessWidget {
  final String tag;
  final String actionsTag;
  final PopupBuilder popupBuilder;
  final List<PopupAction> actions;

  const Popup({
    Key? key,
    required this.tag,
    required this.actionsTag,
    required this.popupBuilder,
    required this.actions
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black54,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          Navigator.pop(context);
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Center(
                  child: Column(
                    children: [
                      Hero(
                        tag: tag,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {

                            },
                            child: popupBuilder(context)
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Hero(
                        tag: actionsTag,
                        child: SingleChildScrollView(
                          child: Column(
                            children: actions,
                            /*[
                              const PopupAction(
                                index: 1,
                                count: 3,
                                iconData: LineIcons.boxOpen,
                                text: 'Open',
                              ),
                              const PopupAction(
                                index: 2,
                                count: 3,
                                iconData: LineIcons.alternateShare,
                                text: 'Share',
                              ),
                              PopupAction(
                                index: 3,
                                count: 3,
                                iconData: LineIcons.alternateTrashAlt,
                                text: 'Delete',
                                isDanger: true,
                                onTap: () {

                                },
                              )
                            ]*/
                          ),
                        ),
                      )
                    ]
                  ),
                ),
              ),
            ),
          ),
          backgroundColor: Colors.black12,
        ),
      ),
    );
  }
}
