import 'package:flutter/cupertino.dart';

class PageHeaderText extends StatelessWidget {
  final String text;

  const PageHeaderText({
    Key? key,
    required this.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold
      ),
    );
  }
}
