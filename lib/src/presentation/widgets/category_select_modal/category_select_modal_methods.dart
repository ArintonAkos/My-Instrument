import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_instrument/src/data/models/responses/main/category/category_model.dart';

import 'category_select_modal.dart';

popOut(CategoryModel actualCategory, BuildContext newListingContext, Function(CategoryModel) updateSelectedCategory) {
  updateSelectedCategory(actualCategory);
  Navigator.of(newListingContext).pop();
}

pushNewModal(BuildContext context, BuildContext newListingContext, Function(CategoryModel) updateSelectedCategory, CategoryModel category, { required int selectedCategory }) {
  Navigator.of(context).push(
    CupertinoPageRoute(
      builder: (context) => Scaffold(
        body: CategorySelectModal(
          category: category,
          newListingContext: newListingContext,
          updateSelectedCategory: updateSelectedCategory,
          selectedCategory: selectedCategory
        )
      ),
    ),
  );
}

selectCategoryAndPop(BuildContext rootContext, BuildContext newListingContext, Function(CategoryModel) updateSelectedCategory, CategoryModel category) {
  popOut(category, newListingContext, updateSelectedCategory);
}