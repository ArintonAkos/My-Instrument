import 'package:flutter/cupertino.dart';

class CardItemModel {
  final IconData icon;
  final Color color;
  final String title;
  final String description;
  final Function(BuildContext context)? onTap;

  const CardItemModel({
    required this.color,
    required this.description,
    required this.icon,
    required this.title,
    this.onTap
  });
}