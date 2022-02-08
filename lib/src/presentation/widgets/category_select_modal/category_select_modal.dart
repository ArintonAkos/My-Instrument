import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:my_instrument/src/data/models/responses/main/category/category_model.dart';

import 'category_select_modal_methods.dart';

class CategorySelectModal extends StatelessWidget {

  final CategoryModel? category;
  final BuildContext newListingContext;
  final Function(CategoryModel) updateSelectedCategory;

  const CategorySelectModal({
    Key? key,
    required this.category,
    required this.newListingContext,
    required this.updateSelectedCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext rootContext) {
    return Material(
      child: Navigator(
        onGenerateRoute: (_) => MaterialPageRoute(
          builder: (context) => Builder(
            builder: (context) => CupertinoPageScaffold(
              backgroundColor: Theme.of(rootContext).backgroundColor,
              navigationBar: CupertinoNavigationBar(
                backgroundColor: Theme.of(rootContext).colorScheme.surface,
                leading: IconButton(
                  onPressed: () {
                    FocusScope.of(rootContext).requestFocus(FocusNode());
                    Navigator.pop(rootContext);
                  },
                  icon: const Icon(
                    CupertinoIcons.back,
                  ),

                ),
                middle: Text(
                  category?.getCategoryName(context) ?? '',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface
                  ),
                )
              ),
              child: SafeArea(
                bottom: false,
                child: ListView.builder(
                  itemCount: category!.children.length,
                  shrinkWrap: true,
                  controller: ModalScrollController.of(context),
                  itemBuilder: (BuildContext context, int index) => ListTile(
                    title: Text(category!.children[index].getCategoryName(context)),
                    onTap: (category!.children[index].isLastElement)
                      ? () => selectCategoryAndPop(
                          rootContext,
                          newListingContext,
                          updateSelectedCategory,
                          category!.children[index]
                        )
                      : () => pushNewModal(
                          context,
                          newListingContext,
                          updateSelectedCategory,
                          category!.children[index]
                        ),
                  )
                ),
              ),
            ),
          ),
        ),
      )
    );
  }
}
