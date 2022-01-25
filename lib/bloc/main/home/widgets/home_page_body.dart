
import 'package:auto_route/auto_route.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:my_instrument/bloc/main/product_list/filter_data.dart';
import 'package:my_instrument/shared/theme/theme_methods.dart';
import 'package:my_instrument/shared/translation/app_localizations.dart';
import 'package:my_instrument/shared/widgets/page-transformer/data.dart';
import 'package:my_instrument/shared/widgets/page-transformer/intro_page_item.dart';
import 'package:my_instrument/shared/widgets/page-transformer/page_transformer.dart';
import 'package:my_instrument/structure/route/router.gr.dart';

import 'discover_slider.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({
    Key? key
  }) : super(key: key);

  @override
  _HomePageBodyState createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {

  bool isLoading = false;

  List<IntroItem> getSampleItems() {
    return <IntroItem>[
      IntroItem(
        title: AppLocalizations.of(context)!.translate(
            'HOME.INSTRUMENT_CARD.GUITAR_TEXT'
        ),
        category: AppLocalizations.of(context)!.translate(
            'HOME.INSTRUMENT_CARD.GUITAR_TITLE'
        ),
        imageUrl: 'assets/guitar1.jpeg',
      ),
      IntroItem(title: AppLocalizations.of(context)!.translate(
          'HOME.INSTRUMENT_CARD.DRUM_TEXT'),
        category: AppLocalizations.of(context)!.translate(
            'HOME.INSTRUMENT_CARD.DRUM_TITLE'),
        imageUrl: 'assets/drums.jpg',),
      IntroItem(title: AppLocalizations.of(context)!.translate(
          'HOME.INSTRUMENT_CARD.BASS_TEXT'),
        category: AppLocalizations.of(context)!.translate(
            'HOME.INSTRUMENT_CARD.BASS_TITLE'),
        imageUrl: 'assets/bass-guitar.jpg',),
      IntroItem(title: AppLocalizations.of(context)!.translate(
          'HOME.INSTRUMENT_CARD.VIOLIN_TEXT'),
        category: AppLocalizations.of(context)!.translate(
            'HOME.INSTRUMENT_CARD.VIOLIN_TITLE'),
        imageUrl: 'assets/violin.jpeg',),
      IntroItem(title: AppLocalizations.of(context)!.translate(
          'HOME.INSTRUMENT_CARD.PIANO_TEXT'),
        category: AppLocalizations.of(context)!.translate(
            'HOME.INSTRUMENT_CARD.PIANO_TITLE'),
        imageUrl: 'assets/piano.jpeg',),
    ];
  }

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
            filterData: FilterData(
              filters: <int, List<int>>{},
              categories: [1],
              search: ''
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
            filterData: FilterData(
              filters: <int, List<int>>{},
              categories: [],
              search: ''
            )
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
      builder: (BuildContext context, Widget child, IndicatorController controller) =>
        AnimatedBuilder(
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
      onRefresh: () => Future.delayed(const Duration(seconds: 3)),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildInstrumentsHeader(),
            SizedBox(
              width: 200,
              height: 200,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: const BlurHash(
                      image: 'https://storage.googleapis.com/myinstrument-project-bucket/listings/303e8a52-de93-42a9-93dd-7744e9be818c/12e0b093-93c8-4145-ad48-24c1f04ff51e/images-20211230-134758.jpg',
                      imageFit: BoxFit.cover,
                      hash: "LfGR-ftRW9t7~qSiNGt7.9WsWDof",
                    ),
                  ),
                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {  },
                      ),
                    ),
                  ),
                ]
              )
            ),
            ClipRRect(
              child: SizedBox.fromSize(
                size: const Size.fromHeight(300.0),
                child: ClipRRect(
                  child: PageTransformer(
                    pageViewBuilder: (_context, visibilityResolver) {
                      final sampleItems = getSampleItems();

                      return PageView.builder(
                        controller: PageController(viewportFraction: 0.85),
                        itemCount: sampleItems.length,
                        itemBuilder: (context, index) {
                          final item = sampleItems[index];
                          final pageVisibility =
                          visibilityResolver.resolvePageVisibility(index);

                          return IntroPageItem(
                            item: item,
                            pageVisibility: pageVisibility,
                            onTap: () {},
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            buildListingsHeader(),
            DiscoverSlider(imgList: imgList),
            const SizedBox(
              height: 70.0,
            ),
          ],
        ),
      ),
    );
  }
}
