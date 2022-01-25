import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:my_instrument/shared/widgets/image_gallery.dart';
import 'package:my_instrument/src/data/data_providers/change_notifiers/theme_manager.dart';
import 'package:my_instrument/src/data/models/view_models/select_bottom_sheet.dart';
import 'package:my_instrument/src/shared/theme/app_theme_data.dart';
import 'package:my_instrument/src/shared/translation/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

final Color kAppBarDefaultColor = Colors.grey.withOpacity(0.4);

class ListingDetailsPage extends StatefulWidget {
  const ListingDetailsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ListingDetailsPageState();
}

class _ListingDetailsPageState extends State<ListingDetailsPage>
    with TickerProviderStateMixin {
  late AnimationController _colorAnimationController;
  Animation? _colorTween, _iconColorTween;

  int _selectIndex = 0;
  bool isAppbarCollapsing = false;

  @override
  void initState() {
    _colorAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 0));

    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _colorTween = ColorTween(
          begin: kAppBarDefaultColor,
          end: Theme.of(context).colorScheme.surface
      ).animate(_colorAnimationController);
      _iconColorTween = ColorTween(
          begin: Colors.white,
          end: Theme.of(context).colorScheme.onSurface
      ).animate(_colorAnimationController);
    });
  }

  bool _scrollListener(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.axis == Axis.vertical) {
      _colorAnimationController.animateTo(scrollInfo.metrics.pixels / 350);

      return true;
    }

    return false;
  }

  void imageGallery() => Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => GalleryImg(urlImages: imgList)
  ));

  @override
  void dispose() {
    super.dispose();
  }

  int titleCharNumb = 128;
  double titleFontSize = 20.0;
  double priceFontSize = 20.0;
  int priceCharNumb = 10;
  int descriptionCharNumb = 500;
  String _listingDescription = 'The description of your instrument';
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1558098329-a11cff621064?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=636&q=80',
    'https://images.unsplash.com/photo-1510915361894-db8b60106cb1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1100&q=80',
    'https://images.unsplash.com/photo-1564186763535-ebb21ef5277f?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8Z3VpdGFyfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1550291652-6ea9114a47b1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=634&q=80'
  ];
  final controller = PageController(viewportFraction: 1.0, keepPage: true);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _hero = 'bat';


  List<S2Choice<String>> heroes = [
    S2Choice<String>(value: 'sup', title: 'Drums'),
    S2Choice<String>(value: 'hul', title: 'Bass'),
    S2Choice<String>(value: 'spi', title: 'Piano'),
    S2Choice<String>(value: 'iro', title: 'Violin'),
  ];


  Widget _buildTF(String _formHint, AppThemeData? theme, {
    TextEditingController? inputController,
    TextInputType? textInputType,
    String? errorText,
    int? characterNumber,
    double? fSize,
    IconData? iconData,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20.0,right: 20.0),
          child: TextFormField(
            maxLines: 10,
            minLines: 1,
            maxLength: characterNumber,
            keyboardType: textInputType,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.black12,
              labelStyle: TextStyle(
                fontSize: fSize,
              ),
              labelText: _formHint,
              helperText: '',
              enabledBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(30)
              ),

            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Text(
            errorText ?? "",
            style: TextStyle(
              fontSize: 14,
              color: theme?.customTheme.authErrorColor,
            ),
          ),
        )
      ],
    );
  }


  Widget _buildTitleTF() {
    return _buildTF(
      AppLocalizations.of(context)!.translate('NEW_LISTING.TITLE_INPUT.HINT'),
      Provider.of<ThemeNotifier>(context).getTheme(),
      inputController: TextEditingController(),
      textInputType: TextInputType.name,
      characterNumber: titleCharNumb,
      fSize: titleFontSize,
    );
  }

  Widget _buildPriceTF() {
    return _buildTF(
      'Enter the price',
      Provider.of<ThemeNotifier>(context).getTheme(),
      inputController: TextEditingController(),
      textInputType: TextInputType.number,
      characterNumber: priceCharNumb,
      fSize: priceFontSize,
    );
  }

  Widget _buildDescriptionTF() {
    return _buildTF(
      'Enter the description of your instrument',
      Provider.of<ThemeNotifier>(context).getTheme(),
      inputController: TextEditingController(),
      textInputType: TextInputType.multiline,
      characterNumber: descriptionCharNumb,
      fSize: titleFontSize,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: _scrollListener,
        child: Stack(
          children: <Widget>[
            SizedBox(
              height: 300,
              child: PageView.builder(
                controller: controller,
                itemCount: imgList.length,
                itemBuilder: (_, index) {
                  final pics = imgList[index];
                  return FittedBox(
                      fit: BoxFit.cover,
                      child: InkWell(
                        child: Image(
                          image: NetworkImage(pics),
                        ),
                        onTap: imageGallery,
                      )
                  );
                },
              ),
            ),
            Positioned(
              left: 170,
              top: 240,
              child: SmoothPageIndicator(
                controller: controller,
                count: imgList.length,
                effect: WormEffect(
                    dotColor: Colors.grey,
                    activeDotColor:  Colors.white,
                    dotHeight: 7.0,
                    dotWidth: 7.0
                ),
              ),
            ),
            DraggableScrollableSheet(
                initialChildSize: 0.6,
                minChildSize: 0.6,
                maxChildSize: 1.0,
                expand: true,
                builder: (context, controller) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  child: ListView(
                    controller: controller,
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                      _buildTitleTF(),
                      _buildPriceTF(),
                      _buildDescriptionTF(),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Card(

                          elevation: 5,
                          child: ListTile(
                            tileColor: Theme.of(context).colorScheme.secondary,
                            title: Text('Select the type of your product'),
                            trailing: IconButton(
                              splashRadius: 20,
                              icon: Icon(Icons.arrow_forward_ios),
                              onPressed: () {
                                showCupertinoModalBottomSheet(context: context,
                                  builder: (context) => SelectBottomSheet(),
                                );
                              },

                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            ),
            SizedBox(
              height: 50,
              child: AnimatedBuilder(
                animation: _colorAnimationController,
                builder: (context, child) => AppBar(
                  backgroundColor: _colorTween?.value ?? kAppBarDefaultColor,
                  elevation: 0,
                  titleSpacing: 0.0,
                  title: Row(
                    children: [
                      IconButton(
                        splashRadius: 20,
                        icon: Icon(
                          CupertinoIcons.back,
                          color: _iconColorTween?.value,
                        ),
                        onPressed: () {

                        },
                      ),
                      Text(
                        "Create your new listing",
                        style: TextStyle(
                            color: _iconColorTween?.value,
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                        ),
                      )
                    ],
                  ),
                  actions: <Widget>[
                    IconButton(
                      splashRadius: 20,
                      icon: Icon(
                        Icons.local_grocery_store,
                        color: _iconColorTween?.value,
                      ),
                      onPressed: () {

                      },
                    ),
                    IconButton(
                      splashRadius: 20,
                      icon: Icon(
                        Icons.favorite,
                        color: _iconColorTween?.value,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      splashRadius: 20,
                      icon: Icon(
                        Icons.more_vert,
                        color: _iconColorTween?.value,
                      ),
                      onPressed: () {},
                    ),

                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

}
