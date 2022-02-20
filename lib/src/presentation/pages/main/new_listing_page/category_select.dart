import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:my_instrument/src/data/models/responses/main/category/category_model.dart';
import 'package:my_instrument/src/presentation/widgets/category_select_modal/default_select_modal.dart';
import 'package:my_instrument/src/shared/translation/app_localizations.dart';

class CategorySelect extends StatelessWidget {

  final Color selectedBorder;
  final CategoryModel selectedCategory;
  final Function(CategoryModel selectedCategory) onCategorySelect;

  const CategorySelect({
    Key? key,
    required this.selectedCategory,
    required this.selectedBorder,
    required this.onCategorySelect
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: selectedBorder,
          )
        )
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
          ),
          color: Colors.grey.withOpacity(0.2),
        ),
        height: 50,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  (selectedCategory.id == 0)
                      ? AppLocalizations.of(context)!.translate('NEW_LISTING.CATEGORY_SELECT.HINT')
                      : selectedCategory.getCategoryName(context),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                    fontSize: 16,
                    overflow: TextOverflow.ellipsis
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: IconButton(
                icon: const Icon(
                  LineIcons.angleRight
                ),
                splashRadius: 22,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                onPressed: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  showCupertinoModalBottomSheet(
                    barrierColor: Colors.black.withOpacity(0.8),
                    context: context,
                    builder: (context) => DefaultCategorySelectModal(
                      newListingContext: context,
                      updateSelectedCategory: onCategorySelect,
                      selectedCategory: selectedCategory.id
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
