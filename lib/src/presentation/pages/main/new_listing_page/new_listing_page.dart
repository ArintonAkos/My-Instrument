import 'dart:io';

import 'package:cupertino_radio_choice/cupertino_radio_choice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:my_instrument/src/presentation/widgets/image_gallery.dart';
import 'package:my_instrument/src/data/data_providers/change_notifiers/theme_manager.dart';
import 'package:my_instrument/src/data/models/view_models/select_bottom_sheet.dart';
import 'package:my_instrument/src/shared/theme/app_theme_data.dart';
import 'package:my_instrument/src/shared/translation/app_localizations.dart';
import 'package:provider/provider.dart';

final Color kAppBarDefaultColor = Colors.grey.withOpacity(0.4);

class NewListingPage extends StatefulWidget {
  const NewListingPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _NewListingPageState();
}

class _NewListingPageState extends State<NewListingPage>
    with TickerProviderStateMixin {


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
  int descriptionCharNumb = 5000;
  int size = 3;
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1558098329-a11cff621064?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=636&q=80',
    'https://images.unsplash.com/photo-1510915361894-db8b60106cb1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1100&q=80',
    'https://images.unsplash.com/photo-1564186763535-ebb21ef5277f?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8Z3VpdGFyfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1550291652-6ea9114a47b1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=634&q=80'
  ];
  final controller = PageController(viewportFraction: 1.0, keepPage: true);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String> selectedImages = [];

  Future<void> _imgPicker(ImageSource source) async {
    XFile? selectedImage = (await ImagePicker().pickImage(source: source));

    if (selectedImage != null && selectedImages.length < 5) {
      selectedImages.add(selectedImage.path);
      Navigator.pop(context);
      setState(() {

      });
    }

  }

  void removeImage(String _image) {
    selectedImages.remove(_image);
    setState(() {

    });
  }

  Widget _buildTF(String _formHint, AppThemeData? theme, String _title, {
    TextEditingController? inputController,
    TextInputType? textInputType,
    String? errorText,
    int? characterNumber,
    double? fSize,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RichText(
            text: TextSpan(
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 16.0
              ),
              children: [
                TextSpan(
                  text: _title,
                ),
              ]
            )
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          validator: (value) {
            if(value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          maxLines: 1000,
          minLines: 1,
          maxLength: characterNumber,
          keyboardType: textInputType,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.withOpacity(0.2),
            labelStyle: TextStyle(
              fontSize: fSize,
            ),
            hintText: _formHint,
            helperText: '',
            enabledBorder: const UnderlineInputBorder(),

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
        AppLocalizations.of(context)!.translate('NEW_LISTING.TITLE_INPUT.LABEL'),
      inputController: TextEditingController(),
      textInputType: TextInputType.name,
      characterNumber: titleCharNumb,
      fSize: titleFontSize,
    );
  }

  Widget _buildPriceTF() {
    return _buildTF(
      AppLocalizations.of(context)!.translate('NEW_LISTING.PRICE_INPUT.HINT'),
      Provider.of<ThemeNotifier>(context).getTheme(),
      AppLocalizations.of(context)!.translate('NEW_LISTING.PRICE_INPUT.LABEL'),
      inputController: TextEditingController(),
      textInputType: TextInputType.number,
      characterNumber: priceCharNumb,
      fSize: priceFontSize,
    );
  }

  Widget _buildDescriptionTF() {
    return _buildTF(
      AppLocalizations.of(context)!.translate('NEW_LISTING.DESCRIPTION_INPUT.HINT'),
      Provider.of<ThemeNotifier>(context).getTheme(),
      AppLocalizations.of(context)!.translate('NEW_LISTING.DESCRIPTION_INPUT.LABEL'),
      inputController: TextEditingController(),
      textInputType: TextInputType.multiline,
      characterNumber: descriptionCharNumb,
      fSize: titleFontSize,
    );
  }

  Widget _buildImageDropper() {
    return InkWell(
      onTap:() => showModalBottomSheet(
        barrierColor: Colors.black.withOpacity(0.8),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20))
        ),
          context: context,
          builder: (context) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(70)
            ),
            height: 100.0,
            child: Row(
              children: [
                const Spacer(),
                Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top:15),
                        child: IconButton(
                            iconSize: 30,
                            onPressed: () =>  _imgPicker(ImageSource.camera),
                            icon: const Icon(Icons.add_a_photo_outlined)),
                      ),
                      Text(
                        AppLocalizations.of(context)!.translate('NEW_LISTING.IMAGE_DROPPER.CAMERA'),
                      )
                    ],
                  ),
                const Spacer(),
                const VerticalDivider(
                  width: 20,
                  thickness: 1,
                  indent: 20,
                  endIndent: 10,
                  color: Colors.grey,
                ),
                const Spacer(),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: IconButton(
                          iconSize: 30,
                          onPressed: () =>  _imgPicker(ImageSource.gallery),
                          icon: const Icon(Icons.add_photo_alternate_outlined)),
                    ),
                    Text(
                      AppLocalizations.of(context)!.translate('NEW_LISTING.IMAGE_DROPPER.GALLERY')
                    )
                  ],
                ),
                const Spacer(),
              ],
            ),
          )
      ),
      child: Container(
        height: (selectedImages.isEmpty) ? 150 : null,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10)
        ),
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 250),
          child: (selectedImages.isEmpty)
            ? const Center(
              child: Text('Select your images about the product'),
            )
            : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.50,
                mainAxisSpacing: 15.0,
                crossAxisSpacing: 15.0,
              ),
              itemCount: 5,
              itemBuilder: (context,index) => _miniPicture(index),
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
              shrinkWrap: true,
          ),
        ),
      ),
    );
  }

  Widget _miniPicture(int index) {
    return InkWell(
      onTap: () => removeImage(selectedImages[index]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: (index < selectedImages.length)
            ? Image.file(
          File(selectedImages[index]),
          width: 200,
          height: 200,
          fit: BoxFit.cover,
        )
            : Container(
          color: Colors.grey.withOpacity(0.3),
        )
      ),
    );
  }

  Widget _labelText(String? _text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: RichText(
          text: TextSpan(
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 16.0
              ),
              children: <TextSpan> [
                TextSpan(
                  text: _text,
                ),
              ]
          )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              snap: false,
              floating: false,
              expandedHeight: 100.0,
              backgroundColor: Theme.of(context).backgroundColor,
              leading: IconButton(
                splashRadius: 15,
                onPressed: () {

                },
                icon: const Icon(CupertinoIcons.back),
                color: Theme.of(context).colorScheme.onSurface,
              ),
              actions: [
                IconButton(
                  splashRadius: 15,
                  onPressed: ()  {
                    if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing...'))
                        );
                    }
                  },
                  icon: Icon(
                  LineIcons.check,
                  color: Theme.of(context).colorScheme.onSurface,
                  )
                )
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: Theme.of(context).backgroundColor,
                ),
                title: Text(
                  AppLocalizations.of(context)!.translate('NEW_LISTING.TITLE'),
                  textScaleFactor: 1.0,
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.onSurface,
                    //fontSize: 20
                  ),
                ),
              ),
            ),
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20,top: 40),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _labelText(AppLocalizations.of(context)!.translate('NEW_LISTING.IMAGE_DROPPER.LABEL')),
                        const SizedBox(
                          height: 10,
                        ),
                        _buildImageDropper(),
                        const SizedBox(
                          height: 20,
                        ),
                        _buildTitleTF(),
                        _labelText(AppLocalizations.of(context)!.translate('NEW_LISTING.CATEGORY_SELECT.LABEL')),
                        ListTile(
                          tileColor: Theme.of(context).cardColor,
                          title: Text(
                            AppLocalizations.of(context)!.translate('NEW_LISTING.CATEGORY_SELECT.HINT'),
                            style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                            ),
                          ),
                          trailing: IconButton(
                            iconSize: 18,
                            splashRadius: 15,
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                            ),
                            onPressed: () {
                              showCupertinoModalBottomSheet(context: context,
                                builder: (context) => const SelectBottomSheet(),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                            height: 40
                        ),
                        _buildDescriptionTF(),
                        _labelText(AppLocalizations.of(context)!.translate('NEW_LISTING.PRIVATE_FIRM.LABEL')),
                        const SizedBox(
                          height: 5,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: CupertinoRadioChoice(
                              selectedColor: Theme.of(context).colorScheme.primary,
                              notSelectedColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                              choices: {
                              'private' : AppLocalizations.of(context)!.translate('NEW_LISTING.PRIVATE_FIRM.PRIVATE'),
                              'firm' : AppLocalizations.of(context)!.translate('NEW_LISTING.PRIVATE_FIRM.FIRM')},
                              onChange: (selectedGender) {},
                              initialKeyValue: 'private'
                          ),
                        ),
                        const SizedBox(
                            height: 40
                        ),
                        _buildPriceTF(),
                       _labelText(AppLocalizations.of(context)!.translate('NEW_LISTING.NEW_USED.LABEL')),
                        const SizedBox(
                          height: 5,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: CupertinoRadioChoice(
                            selectedColor: Theme.of(context).colorScheme.primary,
                            choices: {
                              'new' : AppLocalizations.of(context)!.translate('NEW_LISTING.NEW_USED.NEW'),
                              'used' : AppLocalizations.of(context)!.translate('NEW_LISTING.NEW_USED.USED')
                            },
                            onChange: (selectedGender) {},
                            initialKeyValue: 'new'),
                        ),
                        const SizedBox(
                            height: 40
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ]
                    ),
                  ),
                );
              },
              childCount: 1,
            )
          )
          ],
        ),
      );
    }

}