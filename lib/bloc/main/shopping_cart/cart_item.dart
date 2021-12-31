import 'package:flutter/material.dart';

import 'cart_item_data.dart';

class CartItem extends StatelessWidget {
  final CartItemData cartItemData;

  const CartItem({
    Key? key,
    required this.cartItemData
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Theme.of(context).cardColor
      ),
      height: 50,
    );
  }
}
