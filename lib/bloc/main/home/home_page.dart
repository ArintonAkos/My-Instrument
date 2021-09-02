import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_instrument/bloc/shared/listing_card.dart';
import 'package:my_instrument/bloc/shared/page-transformer/data.dart';
import 'package:my_instrument/bloc/shared/page-transformer/intro_page_item.dart';
import 'package:my_instrument/bloc/shared/page-transformer/page_transformer.dart';
import 'package:my_instrument/services/auth/auth_model.dart';
import 'package:my_instrument/shared/translation/app_localizations.dart';
import 'package:provider/provider.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'

  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //HomeTitle(),
          Padding(padding: EdgeInsets.all(20.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  AppLocalizations.of(context)!.translate('HOME.INSTRUMENTS'),
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          ClipRRect(
           // borderRadius: BorderRadius.circular(18.0),
            child: SizedBox.fromSize(
              size: const Size.fromHeight(300.0),
              child: ClipRRect(
                //borderRadius: BorderRadius.circular(28.0),
                child: PageTransformer(
                  pageViewBuilder: (_context, visibilityResolver) {
                    var sampleItems = <IntroItem>[
                      new IntroItem(title: AppLocalizations.of(context)!.translate(
                          'HOME.INSTRUMENT_CARD.GUITAR_TEXT'),
                        category: AppLocalizations.of(context)!.translate(
                            'HOME.INSTRUMENT_CARD.GUITAR_TITLE'),
                        imageUrl: 'assets/guitar1.jpeg',),
                      new IntroItem(title: AppLocalizations.of(context)!.translate(
                          'HOME.INSTRUMENT_CARD.DRUM_TEXT'),
                        category: AppLocalizations.of(context)!.translate(
                            'HOME.INSTRUMENT_CARD.DRUM_TITLE'),
                        imageUrl: 'assets/drums.jpg',),
                      new IntroItem(title: AppLocalizations.of(context)!.translate(
                          'HOME.INSTRUMENT_CARD.BASS_TEXT'),
                        category: AppLocalizations.of(context)!.translate(
                            'HOME.INSTRUMENT_CARD.BASS_TITLE'),
                        imageUrl: 'assets/bass-guitar.jpg',),
                      new IntroItem(title: AppLocalizations.of(context)!.translate(
                          'HOME.INSTRUMENT_CARD.VIOLIN_TEXT'),
                        category: AppLocalizations.of(context)!.translate(
                            'HOME.INSTRUMENT_CARD.VIOLIN_TITLE'),
                        imageUrl: 'assets/violin.jpeg',),
                      new IntroItem(title: AppLocalizations.of(context)!.translate(
                          'HOME.INSTRUMENT_CARD.PIANO_TEXT'),
                        category: AppLocalizations.of(context)!.translate(
                            'HOME.INSTRUMENT_CARD.PIANO_TITLE'),
                        imageUrl: 'assets/piano.jpeg',),
                    ];
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
                        );
                      },
                    );
                  },
                ),
              ),
              
            ),
          ),
          Padding(
              padding: EdgeInsets.all(0),
            child: InstrumentScroll(),
          ),
          Padding(padding: EdgeInsets.only(top: 20.0, bottom: 35.0,left: 20.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  AppLocalizations.of(context)!.translate('HOME.LISTINGS'),
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          DiscoverSlider(imgList: imgList),
          SizedBox(height: 70.0,)
        ],
      ),
    );
  }
}

class HomeTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            AppLocalizations.of(context)!.translate('HOME.TITLE'),
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          )
        ]
      ),
    );
  }
}

class DiscoverSlider extends StatelessWidget {
  final controller = PageController(viewportFraction: 0.8);
  final List<String> imgList;

  DiscoverSlider({Key? key,
    required this.imgList
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           // SizedBox(height: 16),
            SizedBox(
              height: 350,
              child: PageView(
                controller: controller,
                children: List.generate(
                    6,
                        (index) => ListingCard(
                          imgUrl: imgList[index],
                          listingName: 'Shecter Guitar',
                          listingPrice: '420.69',
                          listingDescription: 'Description',
                        )
                ),
              ),
            ),
           // SizedBox(height: 16),
            /*Container(
              child: SmoothPageIndicator(
                controller: controller,
                count: 6,
                effect: ExpandingDotsEffect(
                  expansionFactor: 4,
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }
  
}