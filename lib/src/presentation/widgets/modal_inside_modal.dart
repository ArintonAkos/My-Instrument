import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:my_instrument/src/presentation/pages/main/product_list_page/product_list_app_bar.dart';

class ModalInsideModal extends StatelessWidget {
  final bool reverse;
  final List<OrderByModel> orderByModels;
  final String title;
  final Function(int value) onTap;

  const ModalInsideModal({
    Key? key,
    required this.orderByModels,
    required this.title,
    this.reverse = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 70,
          bottomOpacity: 0.0,
          elevation: 0.0,
          backgroundColor: Theme.of(context).colorScheme.surface,
          leading: Container(),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, top: 10),
                  child: Container(
                    height: 6,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
                    ),
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ),
                )
              ]
            )
          )
        ),
        body: SafeArea(
          bottom: false,
          child: ListView.builder(
            reverse: reverse,
            shrinkWrap: true,
            controller: ModalScrollController.of(context),
            physics: const ClampingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) => OrderByItem(
              model: OrderByModel(
                value: orderByModels[index].value,
                text: orderByModels[index].text
              ),
              onTap: (value) { onTap(value); },
              isSelected: (index == 2),
            ),
            itemCount: orderByModels.length,
          ),
        ),
      )
    );
  }
}