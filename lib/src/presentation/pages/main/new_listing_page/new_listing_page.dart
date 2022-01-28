import 'dart:io';
import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:cupertino_radio_choice/cupertino_radio_choice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:my_instrument/shared/widgets/image_gallery.dart';
import 'package:my_instrument/src/data/data_providers/change_notifiers/theme_manager.dart';
import 'package:my_instrument/src/data/data_providers/services/category_service.dart';
import 'package:my_instrument/src/data/models/responses/main/category/category_model.dart';
import 'package:my_instrument/src/presentation/pages/main/product_list_page/product_list_app_bar.dart';
import 'package:my_instrument/src/presentation/widgets/category_select_modal.dart';
import 'package:my_instrument/src/presentation/widgets/long_press_item.dart';
import 'package:my_instrument/src/presentation/widgets/modal_inside_modal.dart';
import 'package:my_instrument/src/presentation/widgets/popup_action.dart';
import 'package:my_instrument/src/shared/theme/app_theme_data.dart';
import 'package:my_instrument/src/shared/translation/app_localizations.dart';
import 'package:my_instrument/structure/dependency_injection/injector_initializer.dart';
import 'package:provider/provider.dart';

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

  final List<OrderByModel> orderByModels = <OrderByModel>[
    OrderByModel(text: "Camera", value: 0),
    OrderByModel(text: "Gallery", value: 1),
  ];

  String selectErrorText = "";
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
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();

  CategoryModel? selectedCategory;

  Color selectedBorder = Colors.black;

  List<String> selectedImages = [];

  final CategoryModel baseCategory = CategoryModel.base();

  _imgPicker(ImageSource source) async {
    if (source == ImageSource.camera) {
      XFile? selectedImage = (await ImagePicker().pickImage(source: source));
      if (selectedImage != null && selectedImages.length < 5) {
        selectedImages.add(selectedImage.path);
        Navigator.pop(context);
        setState(() {});
      }
    } else {
     List<XFile?> images = await ImagePicker().pickMultiImage() as List<XFile?>;
     if (selectedImages.length + images.length <= 5) {
       for (int i = 0; i < images.length; ++i) {
         if(images[i] != null) {
           selectedImages.add(images[i]!.path);
         }
       }
       Navigator.pop(context);
       setState(() {});
     }

    }
  }

  void removeImage(String _image) {
    selectedImages.remove(_image);
    setState(() {});
  }

  final CategoryService categoryService = appInjector.get<CategoryService>();


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
          controller: inputController,
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
      inputController: _titleController,
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
      inputController: _priceController,
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
      inputController: _descriptionController,
      textInputType: TextInputType.multiline,
      characterNumber: descriptionCharNumb,
      fSize: titleFontSize,
    );
  }

  Widget _buildImageDropper() {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: (selectedImages.isEmpty)
       ? () => showCupertinoModalBottomSheet(
        topRadius: const Radius.circular(20),
        barrierColor: Colors.black.withOpacity(0.8),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20))
        ),
          context: context,
          builder: (context) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(70)
            ),
            height: 170.0,
            child: ModalInsideModal(
              title: 'Select uploading method',
              orderByModels: orderByModels,
              onTap: (value) {
                ImageSource source = value == 0 ? ImageSource.camera : ImageSource.gallery;
                _imgPicker(source);
              },
            )
          )
      )
      : null,
      child: Container(
        height: (selectedImages.isEmpty) ? 150 : null,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10)
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: (selectedImages.isEmpty)
            ? Center(
              child: Text(
                AppLocalizations.of(context)!.translate('NEW_LISTING.IMAGE_DROPPER.HELP'),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)
                ),
              ),
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

  void updateSelectedCategory(CategoryModel selectedCategory) {
    setState(() {
      this.selectedCategory = selectedCategory;
    });
  }

  Widget _miniPicture(int index) {
    return (index < selectedImages.length) ? LongPressItem(
        actions: [
          const PopupAction(
            index: 1,
            count: 3,
            iconData: LineIcons.boxOpen,
            text: 'Open',
          ),
          const PopupAction(
            index: 2,
            count: 3,
            iconData: LineIcons.alternateShare,
            text: 'Share',
          ),
          PopupAction(
            index: 3,
            count: 3,
            iconData: LineIcons.alternateTrashAlt,
            text: 'Delete',
            isDanger: true,
            onTap: () {
              removeImage(selectedImages[index]);
            },
          )
        ],
        previewBuilder: (BuildContext context) => ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.file(
            File(selectedImages[index]),
            height: 100,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        popupBuilder: (BuildContext context) => ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.file(
            File(selectedImages[index]),
            width: 400,
            height: 300,
            fit: BoxFit.cover,
          ),
        )
    )
    : InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => showCupertinoModalBottomSheet(
          topRadius: const Radius.circular(20),
          barrierColor: Colors.black.withOpacity(0.8),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20))
          ),
          context: context,
          builder: (context) => Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(70)
              ),
              height: 170.0,
              child: ModalInsideModal(
                title: 'Select uploading method',
                orderByModels: orderByModels,
                onTap: (value) {
                  ImageSource source = value == 0 ? ImageSource.camera : ImageSource.gallery;
                  _imgPicker(source);
                },
              )
          )
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey.withOpacity(0.3),
        ),
        width: double.infinity,

      ),
    );
  }
  Widget _labelText(String? _text, Color color, double fontSize) {
    return Align(
      alignment: Alignment.centerLeft,
      child: RichText(
          text: TextSpan(
              style: TextStyle(
                  color: color,
                  fontSize: fontSize
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
  Widget build(BuildContext rootContext) {
      return Scaffold(
        backgroundColor: Theme.of(rootContext).backgroundColor,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              snap: false,
              floating: false,
              expandedHeight: 100.0,
              backgroundColor: Theme.of(rootContext).colorScheme.surface,
              leading: IconButton(
                splashRadius: 15,
                onPressed: () => {
                  ( selectedCategory != null || _descriptionController.text.isNotEmpty || _priceController.text.isNotEmpty || _titleController.text.isNotEmpty)
                 ? showDialog(context: rootContext, builder: (BuildContext context) {
                   return BackdropFilter(
                      filter: ImageFilter.blur(sigmaY: 2.3,sigmaX: 2.3),
                      child: AlertDialog(
                        contentPadding: const EdgeInsets.only(left: 20,top: 35, bottom: 35),
                        backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(0.8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        title: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Are you sure you want to exit?",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            ),
                          )
                        ),
                        content: const Align(
                          alignment: Alignment.centerLeft,
                          heightFactor: 0,
                          child: Text(
                            " You have unsaved data",
                            style: TextStyle(
                              fontSize: 18
                            ),
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(rootContext);
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Exit",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {AutoRouter.of(context).pop();},
                            child: const Text(
                              "Cancel",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),

                          ),
                        ],
                      ),
                    );
                  })
                    : Navigator.pop(context)

                },
                icon: const Icon(CupertinoIcons.back),
                color: Theme.of(rootContext).colorScheme.onSurface,
              ),
              actions: [
                IconButton(
                  splashRadius: 15,
                  onPressed: ()  {
                    if(selectedCategory == null) {
                      setState(() {
                        selectedBorder = Theme.of(context).errorColor;
                        selectErrorText = "Please select a category";
                      });
                    } else {
                      selectedBorder = Colors.black;
                      selectErrorText = "";
                      setState(() {

                      });
                    }
                    if (_formKey.currentState!.validate()) {

                        ScaffoldMessenger.of(rootContext).showSnackBar(
                            const SnackBar(
                              content: Text('Processing...'),
                              backgroundColor: Colors.green,
                            )
                        );
                    }
                  },
                  icon: Icon(
                  LineIcons.check,
                  color: Theme.of(rootContext).colorScheme.onSurface,
                  )
                )
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: Theme.of(rootContext).backgroundColor,
                ),
                title: Text(
                  AppLocalizations.of(rootContext)!.translate('NEW_LISTING.TITLE'),
                  textScaleFactor: 1.0,
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(rootContext).colorScheme.onSurface,
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
                        _labelText(AppLocalizations.of(context)!.translate('NEW_LISTING.IMAGE_DROPPER.LABEL'), Theme.of(context).colorScheme.onSurface, 16.0),
                        const SizedBox(
                          height: 10,
                        ),
                        _buildImageDropper(),
                        const SizedBox(
                          height: 20,
                        ),
                        _buildTitleTF(),
                        _labelText(AppLocalizations.of(context)!.translate('NEW_LISTING.CATEGORY_SELECT.LABEL'), Theme.of(context).colorScheme.onSurface, 16.0),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: selectedBorder,
                              )
                            )
                          ),
                          child: ListTile(
                            tileColor: Colors.grey.withOpacity(0.2),
                            title: Text(
                              selectedCategory?.getCategoryName(context) ?? AppLocalizations.of(context)!.translate('NEW_LISTING.CATEGORY_SELECT.HINT'),
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
                                  builder: (context) => CategorySelectModal(
                                    category: baseCategory,
                                    newListingContext: context,
                                    selectedName: baseCategory.getCategoryName(context),
                                    updateSelectedCategory: updateSelectedCategory,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 7),
                          child: _labelText(selectErrorText, Theme.of(context).errorColor, 11.5)
                        ),
                        const SizedBox(
                            height: 15
                        ),
                        _buildDescriptionTF(),
                        _labelText(AppLocalizations.of(context)!.translate('NEW_LISTING.PRIVATE_FIRM.LABEL'), Theme.of(context).colorScheme.onSurface, 16.0),
                        const SizedBox(
                          height: 5,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: CupertinoRadioChoice(
                              selectedColor: Theme.of(context).colorScheme.primary.withOpacity(0.8),
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
                       _labelText(AppLocalizations.of(context)!.translate('NEW_LISTING.NEW_USED.LABEL'), Theme.of(context).colorScheme.onSurface, 16.0),
                        const SizedBox(
                          height: 5,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: CupertinoRadioChoice(
                              selectedColor: Theme.of(context).colorScheme.primary.withOpacity(0.8),
                              notSelectedColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
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