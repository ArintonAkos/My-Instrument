import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:my_instrument/src/data/models/responses/main/category/category_model.dart';

import 'category_select_modal_methods.dart';

class CategorySelectModal extends StatelessWidget {

  final CategoryModel? category;
  final BuildContext newListingContext;
  final Function(CategoryModel) updateSelectedCategory;
  final int selectedCategory;

  const CategorySelectModal({
    Key? key,
    required this.category,
    required this.newListingContext,
    required this.updateSelectedCategory,
    required this.selectedCategory
  }) : super(key: key);

  @override
  Widget build(BuildContext rootContext) {
    return Material(
      child: Navigator(
        onGenerateRoute: (_) => MaterialPageRoute(
          builder: (context) => Builder(
            builder: (context) => Scaffold(
              backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(0.85),
              appBar: AppBar(
                centerTitle: true,
                shadowColor: Colors.black45,
                backgroundColor: Theme.of(rootContext).backgroundColor,
                leading: IconButton(
                  onPressed: () {
                    FocusScope.of(rootContext).requestFocus(FocusNode());
                    Navigator.pop(rootContext);
                  },
                  icon: Icon(
                    LineIcons.angleLeft,
                    color: Theme.of(context).colorScheme.onSurface
                  ),
                ),
                title: Text(
                  category?.getCategoryName(context) ?? '',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface
                  ),
                )
              ),
              body: SafeArea(
                bottom: false,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: category!.children.length,
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
                          category!.children[index],
                          selectedCategory: selectedCategory
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
