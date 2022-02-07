import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:my_instrument/src/presentation/widgets/search_field.dart';
import 'package:my_instrument/src/presentation/widgets/modal_inside_modal.dart';
import 'package:my_instrument/src/shared/translation/app_localizations.dart';

import '../filter_page/filter_page.dart';

class ProductListAppBar extends StatelessWidget {
  final TextEditingController? searchController;
  final List<OrderByModel> orderByModels = <OrderByModel>[
    OrderByModel(text: "Popular", value: 0),
    OrderByModel(text: "Newest", value: 1),
    OrderByModel(text: "Customer review", value: 2),
    OrderByModel(text: "Price: lowest to high", value: 3),
    OrderByModel(text: "Price: highest to low", value: 4),
  ];
  
  ProductListAppBar({
    Key? key,
    required this.searchController
  }) : super(key: key);

  Widget appBarItem(BuildContext context, {
    required Function() onPressed,
    required String text,
    required IconData iconData
  }) {
    return TextButton(
      onPressed: onPressed,
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
      backgroundColor: Theme.of(context).colorScheme.surface,
      automaticallyImplyLeading: false,
      floating: true,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)
          ),
        ),
        child: Padding(
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
                        showMaterialModalBottomSheet(
                          context: context,
                          builder: (context) => const FilterPage()
                        );
                      },
                      text: 'Filters',
                      iconData: LineIcons.filter,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: appBarItem(
                        context,
                        onPressed: () {
                          showCupertinoModalBottomSheet(
                            context: context,
                            topRadius: const Radius.circular(30),
                            barrierColor: Colors.black.withOpacity(0.8),
                            builder: (context) => FractionallySizedBox(
                              heightFactor: 0.5,
                              child: ModalInsideModal(
                                onTap: (value) {},
                                title: 'Order by',
                                orderByModels: orderByModels,
                              )
                            )
                          );
                        },
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
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(15),
          bottomLeft: Radius.circular(15)
        )
      )
    );
  }
}

class OrderByModel {
  final String text;
  final int value;

  OrderByModel({
    required this.text,
    required this.value
  });
}

class OrderByItem extends StatelessWidget {
  final Function(int value) onTap;
  final OrderByModel model;
  final bool isSelected;
  
  const OrderByItem({
    Key? key,
    required this.onTap,
    required this.model,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      color: isSelected 
        ? Theme.of(context).primaryColor.withOpacity(0.6)
        : Theme.of(context).colorScheme.surface,
      child: TextButton(
        onPressed: () => onTap(model.value),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Text(
            AppLocalizations.of(context)!.translate(model.text),
            textAlign: TextAlign.left,
            style: TextStyle(
              color: isSelected
                  ? Colors.white
                  : Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              fontSize: 18
            ),
          ),
        ),
        style: const ButtonStyle(
          alignment: Alignment.centerLeft
        ),
      )
    );
  }


}