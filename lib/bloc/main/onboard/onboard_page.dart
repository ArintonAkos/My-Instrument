import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:my_instrument/bloc/main/onboard/onboard_data.dart';
import 'package:my_instrument/bloc/main/onboard/onboard_tab.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardPage extends StatefulWidget {
  late final SharedPreferences prefs;
  late final LiquidController liquidController;

  OnBoardPage({Key? key}) : super(key: key) {
    this.init();
  }

  Future init() async {
    this.liquidController = LiquidController();
    this.prefs = await SharedPreferences.getInstance();
  }

  @override
  _OnBoardPageState createState() => _OnBoardPageState();
}

class _OnBoardPageState extends State<OnBoardPage> {
  int page = 0;
  static List<OnBoardData> pages = <OnBoardData>[
    OnBoardData(
        imagePath: 'assets/music_festival.svg',
        title: 'New era of shopping',
        description: 'MyInstruments brings the new era of online shopping. Choosing a new instrument has never easier before.',
        backgroundColor: Colors.blue
    ),
    OnBoardData(
        imagePath: 'assets/search_listing.svg',
        title: 'Find the best instruments',
        description: 'Find the instrument that fits you the best. Using MyInstruments detailed filters and categories, you can easily find the product that you are looking for.',
        backgroundColor: Colors.blueAccent
    ),
    OnBoardData(
        imagePath: 'assets/profile.svg',
        title: 'Connect now',
        description: 'Connect now to a community of musicians. Sign Up or if you already have an account Log In.',
        backgroundColor: Colors.indigoAccent
    ),
  ];

  _finishBoardingPage() {
    widget.prefs.setBool('boardingCompleted', true);
    Modular.to.navigate('/home/');
  }

  AnimatedContainer _buildDot(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      margin: EdgeInsets.only(right: 5),
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
          duration: Duration(milliseconds: 250),
          child: page != pages.length -1
            ? TextButton(
              onPressed: () {
                widget.liquidController.animateToPage(
                    page:
                    widget.liquidController.currentPage + 1 > pages.length - 1
                        ? 0
                        : widget.liquidController.currentPage + 1
                );
              },
              child: Text(
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
            if (page != pages.length - 1) {
              widget.liquidController.animateToPage(
                  page: pages.length - 1, duration: 700);
            } else {
              _finishBoardingPage();
            }
          },
          child: Text(
            page != pages.length -1
              ? "Skip to End"
              : "Continue"
            ,
            style: TextStyle(
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
      padding: EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        bottom: 45.0
      ),
      child: Column(
        children: <Widget>[
          Expanded(child: SizedBox()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List<Widget>.generate(
              pages.length,
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
                    ...pages.map((pageData) => OnBoardTab(
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