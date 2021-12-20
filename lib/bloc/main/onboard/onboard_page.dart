import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:my_instrument/bloc/main/onboard/onboard_data.dart';
import 'package:my_instrument/bloc/main/onboard/onboard_tab.dart';
import 'package:my_instrument/shared/translation/app_localizations.dart';
import 'package:my_instrument/structure/route/router.gr.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardPage extends StatefulWidget {
  late final SharedPreferences prefs;
  late final LiquidController liquidController;

  OnBoardPage({Key? key}) : super(key: key) {
    init();
  }

  Future init() async {
    liquidController = LiquidController();
    prefs = await SharedPreferences.getInstance();
  }

  @override
  _OnBoardPageState createState() => _OnBoardPageState();
}

class _OnBoardPageState extends State<OnBoardPage> {
  int page = 0;

  _pages() {
    List<OnBoardData> pages = <OnBoardData>[
      OnBoardData(
          imagePath: 'assets/music_festival.svg',
          title: AppLocalizations.of(context)!.translate('ONBOARD_TAB.TITLE.FIRST'),
          description: AppLocalizations.of(context)!.translate('ONBOARD_TAB.DESCRIPTION.FIRST'),
          backgroundColor: Colors.blue
      ),
      OnBoardData(
          imagePath: 'assets/search_listing.svg',
          title: AppLocalizations.of(context)!.translate('ONBOARD_TAB.TITLE.SECOND'),
          description: AppLocalizations.of(context)!.translate('ONBOARD_TAB.DESCRIPTION.SECOND'),
          backgroundColor: Colors.blueAccent
      ),
      OnBoardData(
          imagePath: 'assets/profile.svg',
          title: AppLocalizations.of(context)!.translate('ONBOARD_TAB.TITLE.THIRD'),
          description: AppLocalizations.of(context)!.translate('ONBOARD_TAB.DESCRIPTION.THIRD'),
          backgroundColor: Colors.indigoAccent
      ),
    ];

    return pages;
  }

  _finishBoardingPage() {
    widget.prefs.setBool('boardingCompleted', true);
    AutoRouter.of(context).replace(const HomeRoute());
  }

  AnimatedContainer _buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: page == index ? 20 : 6,
      decoration: BoxDecoration(
        color: page == index ? Colors.white : Colors.grey,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }

  Widget _buildNextButton() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: page != _pages().length -1
            ? TextButton(
              onPressed: () {
                widget.liquidController.animateToPage(
                    page:
                    widget.liquidController.currentPage + 1 > _pages().length - 1
                        ? 0
                        : widget.liquidController.currentPage + 1
                );
              },
              child: const Text(
                "Next",
                style: TextStyle(
                    color: Colors.white
                ),
              ),
            )
            : null
        )
      )
    );
  }

  Widget _buildSkipButton() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: TextButton(
          onPressed: () {
            if (page != _pages().length - 1) {
              widget.liquidController.animateToPage(
                  page: _pages().length - 1, duration: 700);
            } else {
              _finishBoardingPage();
            }
          },
          child: Text(
            page != _pages().length -1
              ? "Skip to End"
              : "Continue"
            ,
            style: const TextStyle(
                color: Colors.white
            ),
          ),
          style: TextButton.styleFrom(
            backgroundColor: Colors.white.withOpacity(0.01)
          ),
        ),
      ),
    );
  }

  Widget _buildPageIndicators() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        bottom: 45.0
      ),
      child: Column(
        children: <Widget>[
          const Expanded(child: SizedBox()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List<Widget>.generate(
                _pages().length,
              _buildDot
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Stack(
            children: [
              LiquidSwipe(
                liquidController: widget.liquidController,
                ignoreUserGestureWhileAnimating: true,
                onPageChangeCallback: (int index) {
                  setState(() {
                    page = index;
                  });
                },
                enableLoop: false,
                pages: <Widget>[
                    ..._pages().map((pageData) => OnBoardTab(
                      onBoardData: pageData,
                    )
                  )
                ],
              ),
              _buildPageIndicators(),
              _buildNextButton(),
              _buildSkipButton(),
            ],
          )
      ),
    );
  }
}