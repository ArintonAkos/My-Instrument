import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';

Widget buildSelect(List<S2Choice<String>> choices, String? choice, void Function(dynamic)? onChange) {
  return SmartSelect<String>.single(

    title: 'Select the type of your instrument',
    onChange: onChange,
    choiceItems: choices,
    modalType: S2ModalType.bottomSheet,
    modalHeader: false,
    tileBuilder: (context, state) {
      return S2Tile.fromState(
        state,
        isTwoLine: true,
        leading: const CircleAvatar(
          backgroundImage: NetworkImage(
            'https://source.unsplash.com/8I-ht65iRww/100x100',
          ),
        ),
      );
    },
    selectedValue: choice ?? '',
    // selectedValue: ,
  );
}

