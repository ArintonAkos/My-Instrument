import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_instrument/src/business_logic/blocs/category/category_bloc.dart';
import 'package:my_instrument/src/data/models/view_models/filter_data.dart';
import 'package:my_instrument/src/data/models/view_models/intro_item.dart';
import 'package:my_instrument/src/data/repositories/category_repository.dart';
import 'package:my_instrument/src/presentation/widgets/page-transformer/intro_page_item.dart';
import 'package:my_instrument/src/presentation/widgets/page-transformer/page_transformer.dart';
import 'package:my_instrument/src/shared/translation/app_localizations.dart';
import 'package:my_instrument/structure/route/router.gr.dart';
import 'package:shimmer/shimmer.dart';

class CategorySlider extends StatelessWidget {
  final PageController _controller = PageController(viewportFraction: 0.85);

  CategorySlider({
    Key? key
  }) : super(key: key);

  Widget buildCategoryHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Text(
            AppLocalizations.of(context)!.translate('HOME.CATEGORIES'),
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold
            ),
          ),
          const Spacer(),
          TextButton(
            style: TextButton.styleFrom(
              primary: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
            onPressed: () {
              AutoRouter.of(context).push(
                ProductListRoute(
                  filterData: FilterData.initial()
                )
              );
            },
            child: Text(
              AppLocalizations.of(context)!.translate('SHARED.INFO.SEE_MORE'),
              style: const TextStyle(
                fontSize: 16
              )
            )
          )
        ]
      ),
    );
  }

  PageView categoryCardBuilder(PageVisibilityResolver visibilityResolver, CategoryState state) {
    return PageView.builder(
      controller: _controller,
      itemCount: state.categories.length,
      itemBuilder: (context, index) => IntroPageItem(
        item: IntroItem.fromCategoryModel(state.categories[index]),
        pageVisibility: visibilityResolver.resolvePageVisibility(index),
        onTap: () {},
      ),
    );
  }

  PageView categoryShimmerBuilder() {
    return PageView.builder(
      controller: _controller,
      itemCount: 5,
      itemBuilder: (context, index) => Container(
        padding: EdgeInsets.all(10),
        child: Shimmer.fromColors(
          // baseColor: Theme.of(context).colorScheme.surface,
          // highlightColor: Theme.of(context).colorScheme.onSurface,
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 250,
                color: Colors.grey[300],
              ),
            )
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CategoryBloc(
            categoryRepository: RepositoryProvider.of<CategoryRepository>(context)
          )..add(const LoadBaseCategories())
        )
      ],
      child: Column(
        children: [
          buildCategoryHeader(context),
          ClipRRect(
            child: SizedBox.fromSize(
              size: const Size.fromHeight(300.0),
              child: ClipRRect(
                child: BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, categoryState) => AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: getChild(context, categoryState),
                  )
                )
              ),
            ),
          ),
        ]
      ),
    );
  }

  getChild(BuildContext context, CategoryState categoryState) {
    if (categoryState.isLoading) {
      return categoryShimmerBuilder();
    }
    else if (categoryState.isSuccess) {
      return PageTransformer(
          pageViewBuilder: (_context, visibilityResolver) =>
              categoryCardBuilder(visibilityResolver, categoryState)
      );
    }
    return Container();
  }
}
