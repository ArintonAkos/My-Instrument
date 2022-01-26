
import 'package:auto_route/auto_route.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_instrument/src/business_logic/blocs/home_page/home_page_bloc.dart';
import 'package:my_instrument/src/data/models/view_models/filter_data.dart';
import 'package:my_instrument/src/presentation/widgets/category_slider/category_slider.dart';
import 'package:my_instrument/src/presentation/widgets/error_info.dart';
import 'package:my_instrument/src/shared/theme/theme_methods.dart';
import 'package:my_instrument/src/shared/translation/app_localizations.dart';
import 'package:my_instrument/structure/route/router.gr.dart';

import '../../../widgets/discover_slider.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({
    Key? key
  }) : super(key: key);

  @override
  _HomePageBodyState createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {

  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  Widget buildInstrumentsHeader() {
    return buildSliderHeader(
      title: AppLocalizations.of(context)!.translate('HOME.INSTRUMENTS'),
      subTitle: AppLocalizations.of(context)!.translate('SHARED.INFO.SEE_MORE'),
      onTap: () {
        AutoRouter.of(context).push(
          ProductListRoute(
            filterData: FilterData.initial(
              categories: [1],
            )
          )
        );
      }
    );
  }

  Widget buildListingsHeader() {
    return buildSliderHeader(
      title: AppLocalizations.of(context)!.translate('HOME.LISTINGS'),
      subTitle: AppLocalizations.of(context)!.translate('SHARED.INFO.SEE_MORE'),
      onTap: () {
        AutoRouter.of(context).push(
          ProductListRoute(
            filterData: FilterData.initial()
          )
        );
      }
    );
  }

  Widget buildSliderHeader({
    required String title,
    required String subTitle,
    required Function() onTap
  }) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
          children: [
            Text(
              title,
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
              onPressed: onTap,
              child: Text(
                subTitle,
                style: const TextStyle(
                  fontSize: 16
                )
              )
            )
          ]
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      builder: (BuildContext context, Widget child, IndicatorController controller) => AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, _) =>
          Stack(
            alignment: Alignment.topCenter,
            children: [
              if (!controller.isIdle)
                Positioned(
                  top: 35.0 * controller.value,
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(
                      value: !controller.isLoading
                          ? controller.value.clamp(0.0, 1.0)
                          : null,
                      color: getCustomTheme(context)?.loginButtonText,
                    ),
                  ),
                ),
              Transform.translate(
                offset: Offset(0, 100.0 * controller.value),
                child: child,
              ),
            ],
          ),
      ),
      onRefresh: () async {
        await Future.delayed(const Duration(milliseconds: 400));
        context.read<HomePageBloc>().add(const HomePageReload());
      },
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: BlocBuilder<HomePageBloc, HomePageState>(
           builder: (context, homePageState) => AnimatedSwitcher(
             duration: const Duration(milliseconds: 350),
             child: renderHomePage(context, homePageState)
           )
        )
      ),
    );
  }

  Widget renderHomePage(BuildContext context, HomePageState state) {
    if (state.isFailure) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 200),
        child: ErrorInfo()
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const SizedBox(height: 20),
        CategorySlider(
          headerText: AppLocalizations.of(context)!.translate('HOME.CATEGORIES'),
        ),
        CategorySlider(
          headerText: AppLocalizations.of(context)!.translate('HOME.INSTRUMENTS'),
          categoryId: 1,
        ),
        CategorySlider(
          headerText: AppLocalizations.of(context)!.translate('HOME.ACCESSORIES'),
          categoryId: 2,
        ),
        CategorySlider(
          headerText: AppLocalizations.of(context)!.translate('HOME.GADGETS'),
          categoryId: 3,
        ),
        buildListingsHeader(),
        DiscoverSlider(imgList: imgList),
        const SizedBox(
          height: 70.0,
        ),
      ],
    );
  }

}
