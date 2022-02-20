import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class CustomListSelect extends StatelessWidget {
  final String title;
  final String? selectedValue;
  final void Function() onPressed;

  const CustomListSelect({
    Key? key,
    required this.title,
    required this.selectedValue,
    required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.black,
          ),
        )
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 16.0
                ),
                children: <TextSpan> [
                  TextSpan(
                    text: title,
                  ),
                ]
              )
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
              color: Colors.grey.withOpacity(0.2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      selectedValue ?? title,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis
                      )
                    ),
                  )
                ),
                Expanded(
                  flex: 2,
                  child: IconButton(
                    splashRadius: 22,
                    icon: const Icon(
                      LineIcons.angleRight
                    ),
                    onPressed: onPressed,
                  ),
                )
              ],
            ),
          ),
        ]
      ),
    );
  }
}
