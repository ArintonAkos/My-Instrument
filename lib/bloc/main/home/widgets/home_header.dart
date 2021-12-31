import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:my_instrument/bloc/main/home/widgets/search_field.dart';
import 'package:my_instrument/structure/route/router.gr.dart';

class HomeHeader extends StatelessWidget {
  final TextEditingController? searchController;
  final Function(String)? onSubmitted;

  const HomeHeader({
    Key? key,
    this.searchController,
    this.onSubmitted
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SearchField(
            width: MediaQuery.of(context).size.width - 100,
            controller: searchController,
            onSubmitted: onSubmitted,
          ),
          Ink(
            decoration: ShapeDecoration(
              color: const Color(0xFF979797).withOpacity(0.1),
              shape: const CircleBorder()
            ),
            child: IconButton(
              // color: const Color(0xFF979797).withOpacity(0.1),
              icon: const Icon(
                LineIcons.shoppingCart
              ),
              onPressed: () {
                AutoRouter.of(context).push(const ShoppingCartRoute());
              },
            ),
          )
        ],
      )
    );
  }
}
