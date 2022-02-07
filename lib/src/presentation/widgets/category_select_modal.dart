import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:my_instrument/src/business_logic/blocs/category_select_modal/category_select_modal_bloc.dart';
import 'package:my_instrument/src/data/models/responses/main/category/category_model.dart';
import 'package:my_instrument/src/data/repositories/category_repository.dart';
import 'package:my_instrument/src/presentation/widgets/error_info.dart';
import 'package:my_instrument/src/presentation/widgets/gradient_indeterminate_progress_bar.dart';

class CategorySelectModal extends StatefulWidget {

  final CategoryModel category;
  final BuildContext newListingContext;
  final String selectedName;
  final Function(CategoryModel) updateSelectedCategory;

  const CategorySelectModal({
    Key? key,
    required this.category,
    required this.newListingContext,
    required this.selectedName,
    required this.updateSelectedCategory
  }) : super(key: key);

  @override
  _CategorySelectModalState createState() => _CategorySelectModalState();
}


class _CategorySelectModalState extends State<CategorySelectModal> {

  void popOut(CategoryModel actualCategory) {
    widget.updateSelectedCategory(actualCategory);
    Navigator.of(widget.newListingContext).pop();
  }

  Widget getBody(BuildContext context, CategorySelectModalState state, BuildContext rootContext) {
    if (state.isSuccess) {
      return ListView.builder(
        itemCount: state.categories.length,
        shrinkWrap: true,
        controller: ModalScrollController.of(context),
        itemBuilder: (BuildContext context, int index) => ListTile(
          title: Text(state.categories[index].getCategoryName(context)),
          onTap: (state.categories[index].children.isNotEmpty)
            ? () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CupertinoPageScaffold(
                    child: CategorySelectModal(
                      category: state.categories[index],
                      newListingContext: widget.newListingContext,
                      selectedName: state.categories[index].nameEn,
                      updateSelectedCategory: widget.updateSelectedCategory,
                    )
                  ),
                ),
              );
            }
            : () {
              popOut(state.categories[index]);
              setState(() {FocusScope.of(rootContext).requestFocus(FocusNode());});
            },
        )
      );
    } else if (state.isFailure) {
      return const ErrorInfo();
    } else if (state.isLoading) {
      return const Center(child: GradientIndeterminateProgressbar());
    }

    return Container();
  }

  @override
  Widget build(BuildContext rootContext) {
    return BlocProvider(
      create: (BuildContext context) => CategorySelectModalBloc(
        categoryRepository: RepositoryProvider.of<CategoryRepository>(context)
      )..add(LoadCategories(categoryId: widget.category.id)),
      child: Material(
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
                      widget.selectedName,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface
                    ),
                  )),

                child: SafeArea(
                  bottom: false,
                  child: BlocBuilder<CategorySelectModalBloc, CategorySelectModalState>(
                    builder: (BuildContext context, CategorySelectModalState state) {
                      return getBody(context, state, rootContext);
                    },

                  ),
                ),
              ),
            ),
          ),
        )
      ),
    );
  }
}
