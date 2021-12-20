import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:my_instrument/shared/theme/theme_methods.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:styled_widget/styled_widget.dart';

class ListingDetailsPage extends StatefulWidget {
  const ListingDetailsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ListingDetailsPageState();
}

class _ListingDetailsPageState extends State<ListingDetailsPage> {

  final List<String> imgList = [
    'https://images.unsplash.com/photo-1558098329-a11cff621064?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=636&q=80',
    'https://images.unsplash.com/photo-1510915361894-db8b60106cb1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1100&q=80',
    'https://images.unsplash.com/photo-1564186763535-ebb21ef5277f?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8Z3VpdGFyfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1550291652-6ea9114a47b1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=634&q=80'
  ];
  final controller = PageController(viewportFraction: 1.0, keepPage: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 60.0),
          child: (
            <Widget>[
              Stack(
                children: [
                  ClipPath(
                    clipper: ImageClipper(),
                    child: SizedBox(
                      height: 300,
                      child: PageView.builder(
                        controller: controller,
                        itemCount: imgList.length,
                        itemBuilder: (_, index) {
                          final pics = imgList[index];
                          return FittedBox(
                              fit: BoxFit.cover,
                              child: Image(
                                image: NetworkImage(pics),
                              )
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: imgList.length,
                      effect: WormEffect(
                          dotColor: getCustomTheme(context)?.DotColor ?? Colors.blueGrey,
                          activeDotColor: getCustomTheme(context)?.ActiveDotColor ?? Colors.white,
                          dotHeight: 8.0,
                          dotWidth: 8.0
                      ),
                    ),
                    left: 30,
                    bottom: 3,
                  ),
                  Positioned(
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue
                      ),
                      alignment: Alignment.center,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 20,
                        ),
                        onPressed: () {
                          AutoRouter.of(context).popUntilRouteWithName('/');
                        },
                      ),
                    ),
                    top: 30,
                    left: 20,
                  )
                ],
              ),

            ].toColumn()
          ),
        ),
      ),
    );
  }
}

class ImageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0, size.height - 65);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
  
}