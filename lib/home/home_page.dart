import 'package:flutter/material.dart';
import 'package:my_instrument/auth/auth_model.dart';
import 'package:my_instrument/translation/app_localizations.dart';
import 'package:provider/provider.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          HomeTitle(),
          // DiscoverSlider(),
        ],
      ),
    );
  }
}

class HomeTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          TextButton(
            onPressed: () {
              Provider.of<AuthModel>(context, listen: false).signOut();
            },
            child: Text('log - out'),
          ),
          Text(
            AppLocalizations.of(context)!.translate('HOME.TITLE'),
          )
        ]
      ),
    );
  }
}

class DiscoverSlider extends StatelessWidget {
  final controller = PageController(viewportFraction: 0.8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Column(
        children: <Widget>[
          Text('Asd 123'),
          TextButton(
            onPressed: () {
              Provider.of<AuthModel>(context).signOut();
            },
            child: Text('log - out'),
          )
        ],
      )/*Center(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 16),
              SizedBox(
                height: 300,
                child: PageView(
                  controller: controller,
                  children: List.generate(
                      6,
                          (_) => Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        child: Container(height: 280),
                      )),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 8),
                child: Text("Expanding Dots "),
              ),
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
      ),*/
    );
  }
  
}