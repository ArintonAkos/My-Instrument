import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:my_instrument/src/data/models/responses/main/category/category_model.dart';
import 'package:my_instrument/src/presentation/widgets/category_select_modal/default_select_modal.dart';
import 'package:my_instrument/src/shared/translation/app_localizations.dart';

class CategorySelect extends StatefulWidget {

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
  _CategorySelectState createState() => _CategorySelectState();
}

class _CategorySelectState extends State<CategorySelect> {


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: widget.selectedBorder,
          )
        )
      ),
      child: Container(
        color: Colors.grey.withOpacity(0.2),
        height: 50,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                (widget.selectedCategory.id == 0)
                    ? AppLocalizations.of(context)!.translate('NEW_LISTING.CATEGORY_SELECT.HINT')
                    : widget.selectedCategory.getCategoryName(context),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  fontSize: 16
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                onPressed: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  showCupertinoModalBottomSheet(context: context,
                    builder: (context) => DefaultCategorySelectModal(
                      newListingContext: context,
                      updateSelectedCategory: widget.onCategorySelect,
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
