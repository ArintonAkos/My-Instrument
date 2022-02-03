import 'package:flutter/material.dart';

import 'choice_select.dart';
import 'choice_select_item.dart';

class CustomChoiceSelect extends StatelessWidget {
  final List<ChoiceSelect> choices;
  final int selectedChoiceId;
  final Function(int id) onTap;

  const CustomChoiceSelect({
    Key? key,
    required this.choices,
    required this.selectedChoiceId,
    required this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Row(
        children: List.generate(
          choices.length,
          (index) => ChoiceSelectItem(
            length: choices.length,
            index: index,
            choice: choices[index],
            selected: (choices[index].selectId == selectedChoiceId),
            onTap: onTap,
          )
        ).toList(),
      ),
    );
  }
}