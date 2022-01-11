import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:my_instrument/bloc/main/home/widgets/search_field.dart';

class ProductListAppBar extends StatelessWidget {
  final TextEditingController? searchController;

  const ProductListAppBar({
    Key? key,
    required this.searchController
  }) : super(key: key);

  Widget appBarItem(BuildContext context, {
    required Function() onPressed,
    required String text,
    required IconData iconData
  }) {
    return TextButton(
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (context) => Container(
                child: Text(
                    'Order By'
                )
            )
        );
      },
      child: Row(
        children: [
          Icon(
            iconData,
            size: 24,
            color: Theme.of(context).colorScheme.onSurface
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onSurface
              ),
            ),
          )
        ],
      ),
      style: TextButton.styleFrom(
        backgroundColor: const Color(0xFF979797).withOpacity(0.1),
        primary: Colors.black12,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      collapsedHeight: 110 + MediaQuery.of(context).padding.top,
      backgroundColor: Theme.of(context).backgroundColor,
      automaticallyImplyLeading: false,
      floating: true,
      flexibleSpace: Padding(
        padding: EdgeInsets.only(top: 10 + MediaQuery.of(context).padding.top),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(
                    CupertinoIcons.back
                  ),
                  onPressed: () => AutoRouter.of(context).pop(),
                  splashRadius: 25,
                ),
                SearchField(
                  width: MediaQuery.of(context).size.width - 80,
                  controller: searchController,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Row(
                children: [
                  appBarItem(
                    context,
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                          child: Text(
                            'Order By'
                          )
                        )
                      );
                    },
                    text: 'Filters',
                    iconData: LineIcons.filter,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: appBarItem(
                      context,
                      onPressed: () {},
                      text: 'Order By',
                      iconData: LineIcons.sortAmountUp
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
