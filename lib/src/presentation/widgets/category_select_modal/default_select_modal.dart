import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_instrument/src/business_logic/blocs/new_listing_page/new_listing_page_bloc.dart';
import 'package:my_instrument/src/data/models/responses/main/category/category_model.dart';
import 'package:my_instrument/src/presentation/widgets/category_select_modal/category_select_modal_methods.dart';
import 'package:my_instrument/src/presentation/widgets/gradient_indeterminate_progress_bar.dart';
import 'package:my_instrument/src/shared/theme/theme_methods.dart';
import 'package:my_instrument/src/shared/translation/app_localizations.dart';
import 'package:shimmer/shimmer.dart';

import '../error_info.dart';

class DefaultCategorySelectModal extends StatelessWidget {
  final BuildContext newListingContext;
  final Function(CategoryModel) updateSelectedCategory;

  const DefaultCategorySelectModal({
    Key? key,
    required this.newListingContext,
    required this.updateSelectedCategory,
  }) : super(key: key);

  Widget getMiddleText() {
    return BlocBuilder<NewListingPageBloc, NewListingPageState>(
      builder: (context, state) {
        if (state.isLoadingCategories) {
          return Shimmer.fromColors(
            baseColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
            highlightColor: getCustomTheme(context)?.shimmerColor.withOpacity(0.1) ?? Colors.white,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                height: 20,
                width: 150,
                color: Colors.grey[300],
              ),
            )
          );
        }

        String titleText = '';
        if (state.isCategoriesFailure) {
          titleText = AppLocalizations.of(context)!.translate('SHARED.ERROR.APPBAR_HEADER_TEXT');
        } else if (state.category != null) {
          titleText = state.category!.getCategoryName(context);
        }

        return Text(
          titleText,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        );
      }
    );
  }

  Widget getBody(BuildContext context, BuildContext rootContext, NewListingPageState state) {
    if (state.isCategoriesSuccess && state.category != null) {
      return ListView.builder(
        itemCount: state.category!.children.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(state.category!.children[index].getCategoryName(context)),
          onTap: (state.category!.children.isEmpty)
            ? () => selectCategoryAndPop(
              rootContext,
              newListingContext,
              updateSelectedCategory,
              state.category!.children[index]
            )
            : () => pushNewModal(
              context,
              newListingContext,
              updateSelectedCategory,
              state.category!.children[index]
            )
        )
      );
    } else if (state.isLoadingCategories) {
      return const Center(
        child: GradientIndeterminateProgressbar()
      );
    }

    return const Center(
      child: ErrorInfo(),
    );
  }

  @override
  Widget build(BuildContext rootContext) {
    return Material(
      child: Navigator(
        onGenerateRoute: (settings) => MaterialPageRoute(
          builder: (context) => Builder(
            builder: (context) => CupertinoPageScaffold(
              backgroundColor: Theme.of(context).backgroundColor,
              navigationBar: CupertinoNavigationBar(
                backgroundColor: Theme.of(context).backgroundColor,
                leading: IconButton(
                  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    Navigator.pop(rootContext);
                  },
                  icon: const Icon(
                    CupertinoIcons.back
                  ),
                ),
                middle: getMiddleText(),
              ),
              child: SafeArea(
                bottom: false,
                child: BlocBuilder<NewListingPageBloc, NewListingPageState>(
                  builder: (BuildContext context, NewListingPageState state) {
                    return getBody(context, rootContext, state);
                  }
                )
              ),
            ),
          )
        ),
      ),
    );
  }
}
