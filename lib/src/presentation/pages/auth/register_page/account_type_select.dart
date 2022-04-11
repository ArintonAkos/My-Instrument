import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:my_instrument/src/data/data_providers/change_notifiers/app_language.dart';
import 'package:my_instrument/src/shared/data/page_data.dart';
import 'package:my_instrument/src/shared/translation/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';

class AccountTypeSelect extends StatefulWidget {
  final int? accountType;
  final Function(int?) onSelect;

  const AccountTypeSelect({
    Key? key,
    required this.accountType,
    required this.onSelect
  }) : super(key: key);

  @override
  State<AccountTypeSelect> createState() => _AccountTypeSelectState();
}

class _AccountTypeSelectState extends State<AccountTypeSelect> {
  bool pressed = false;

  String getAccountTypeText() {
    if (widget.accountType == null) {
      return AppLocalizations.of(context)!.translate('REGISTER.ACCOUNT_TYPE_LABEL');
    }

    return PageData.getAccountType(Provider.of<AppLanguage>(context), widget.accountType!);
  }

  Color getAccountTypeColor() {
    if (widget.accountType == null) {
      return Theme.of(context).colorScheme.onSurface.withOpacity(0.55);
    }

    return Theme.of(context).colorScheme.onSurface;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Account type',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
        const SizedBox(height: 10,),
        Container(
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Icon(
                  LineIcons.addressCard,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.75),
                  size: 23,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      getAccountTypeText(),
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontFamily: 'OpenSans',
                        color: getAccountTypeColor(),
                        fontSize: 16
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Icon(
                    LineIcons.angleRight,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.75),
                    size: 23,
                  ),
                ),
              ],
            ),
          ),
        )
        .elevation(12, 
          shadowColor: Colors.black,
          borderRadius: BorderRadius.circular(10.0)
        )
        .gestures(
          onTapChange: (tapStatus) => setState(() => pressed = tapStatus),
          onTap: () {
            showCupertinoModalBottomSheet(
              context: context,
              topRadius: const Radius.circular(30),
              barrierColor: Colors.black.withOpacity(0.8),
              builder: (context) => Material(
                color: Theme.of(context).colorScheme.surface,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        AppLocalizations.of(context)!.translate('REGISTER.ACCOUNT_TYPE_LABEL'),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.75)
                        ),
                      ),
                    ),
                    // const SizedBox(height: 5,),
                    ListView(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        ListTile(
                            leading: Icon(
                              LineIcons.userTie,
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.75)
                            ),
                            title: Text(
                              PageData.getAccountType(Provider.of<AppLanguage>(context), 0)
                            ),
                            onTap: () {
                              widget.onSelect(0);
                              Navigator.of(context).pop();
                            },
                            trailing:  Visibility(
                              visible: (widget.accountType == 0),
                              child: Icon(
                                LineIcons.check,
                                color: Theme.of(context).colorScheme.primary
                              ),
                            )
                        ),
                        ListTile(
                          leading: Icon(
                            LineIcons.briefcase,
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.75)
                          ),
                          title: Text(
                            PageData.getAccountType(Provider.of<AppLanguage>(context), 1)
                          ),
                          onTap: () {
                            widget.onSelect(1);
                            Navigator.of(context).pop();
                          },
                          trailing: Visibility(
                            visible: (widget.accountType == 1),
                            child: Icon(
                              LineIcons.check,
                              color: Theme.of(context).colorScheme.primary
                            ),
                          )
                        )
                      ],
                    ),
                    const SizedBox(height: 10)
                  ],
                ),
              )
            ).then((value) {
              FocusManager.instance.primaryFocus?.unfocus();
            });
            // widget.onSelect(0);
            /*if (widget.onTap != null) {
              widget.onTap!(context);
            }*/
          },
        )
        .scale(all: pressed ? 0.95 : 1.0, animate: true)
        .animate(
          const Duration(milliseconds: 150),
          Curves.easeOut
        )
      ]
    );
  }
}
