import 'dart:math';
import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:my_instrument/src/data/data_providers/services/listing_service.dart';
import 'package:my_instrument/src/data/data_providers/services/shared_preferences_service.dart';
import 'package:my_instrument/src/data/models/requests/main/listing/create_listing_request.dart';
import 'package:my_instrument/src/data/models/responses/main/listing/create_listing_response.dart';
import 'package:my_instrument/src/data/models/view_models/new_listing_local_data.dart';
import 'package:my_instrument/src/presentation/pages/main/new_listing_page/category_select.dart';
import 'package:my_instrument/src/presentation/pages/main/new_listing_page/exit_dialog.dart';
import 'package:my_instrument/src/presentation/pages/main/new_listing_page/image_dropper.dart';
import 'package:my_instrument/src/presentation/widgets/custom_input_field.dart';
import 'package:my_instrument/src/presentation/widgets/custom_choice_select/choice_select.dart';
import 'package:my_instrument/src/presentation/widgets/custom_choice_select/custom_choice_select.dart';
import 'package:my_instrument/src/data/data_providers/change_notifiers/theme_manager.dart';
import 'package:my_instrument/src/data/models/responses/main/category/category_model.dart';
import 'package:my_instrument/src/presentation/widgets/loading_dialog.dart';
import 'package:my_instrument/src/shared/translation/app_localizations.dart';
import 'package:my_instrument/structure/dependency_injection/injector_initializer.dart';
import 'package:my_instrument/structure/route/router.gr.dart';
import 'package:provider/provider.dart';

part 'new_listing_page_constants.dart';

class NewListingPage extends StatefulWidget {
  const NewListingPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _NewListingPageState();
}

class _NewListingPageState extends State<NewListingPage> {


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _countController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late CategoryModel _selectedCategory = CategoryModel.base();
  final ValueNotifier<double> _titlePaddingNotifier = ValueNotifier(_kBasePadding);
  final ListingService _listingService = appInjector.get<ListingService>();
  final SharedPreferencesService _sharedPreferencesService = appInjector.get<SharedPreferencesService>();

  Color selectedBorder = Colors.black;
  List<String> selectedImages = [];
  int condition = 0;
  NewListingLocalData? savedData;
  String selectErrorText = "";
  int indexImageId = 0;
  bool isLoading = false;
  bool opacity = false;

  double get _horizontalTitlePadding {
    const kCollapsedPadding = 40.0;

    if (_scrollController.hasClients) {
      return min(_kBasePadding + kCollapsedPadding,
          _kBasePadding + (kCollapsedPadding * _scrollController.offset)/(_kExpandedHeight - kToolbarHeight));
    }

    return _kBasePadding;
  }

  Future getData() async {
    savedData = _sharedPreferencesService.getData<NewListingLocalData>("newListingPage",
        NewListingLocalData.fromJson, NewListingLocalData.defaultState);
    for (int i = 0; i < savedData!.images.length; ++i) {
      selectedImages.add(savedData!.images[i]);
    }
    _titleController.value = _titleController.value.copyWith(
        text: savedData!.title
    );
    _descriptionController.text = savedData!.description;
    if (savedData!.price != 0) {
      _priceController.text = savedData!.price.toString();
    }
    if (savedData!.count != 0) {
      _countController.text = savedData!.count.toString();
    }
    condition = savedData!.condition;
    _selectedCategory = savedData!.category;
    indexImageId = savedData!.indexImageId;

    setState(() {});

  }

  Future<void> exitAndSave() async {
    await _sharedPreferencesService.saveData("newListingPage", NewListingLocalData(
        title: (_titleController.text.isNotEmpty )
            ? _titleController.text
            : "",
        price: (_priceController.text.isNotEmpty)
            ? double.parse(_priceController.text)
            : 0,
        description: (_descriptionController.text.isNotEmpty)
            ?_descriptionController.text
            :"",
        images: (selectedImages.isNotEmpty)
            ? selectedImages
            : [],
        condition: condition,
        category: _selectedCategory,
        count: (_countController.text.isNotEmpty)
            ? int.parse(_countController.text)
            : 0,
        indexImageId: indexImageId

    )
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

  Future submitNewListing() async {

    if(_selectedCategory.id == 0) {
      setState(() {
        selectedBorder = Theme.of(context).errorColor;
        selectErrorText = AppLocalizations.of(context)!.translate('NEW_LISTING.ERROR_MESSAGE.SELECT');
      });
    } else {
      selectedBorder = Colors.black;
      selectErrorText = "";
      setState(() {});
    }
    if (_formKey.currentState!.validate() && _selectedCategory.id != 0) {

      setState(() {
        isLoading = true;
        opacity = true;
      });

      var res = await _listingService.createListing(CreateListingRequest(
        //imagePaths: selectedImages,
        indexImageId: indexImageId,
        description: _descriptionController.text,
        price: double.parse(_priceController.text),
        count: int.parse(_countController.text),
        categoryId: 224,//_selectedCategory.id,
        title: _titleController.text,
        condition: condition,
      ));

      if (res.ok) {
        Navigator.pop(context);
        setState(() {
          isLoading = false;
        });
        deleteData();
        var response = (res as CreateListingResponse);
        AutoRouter.of(context).popAndPush(ListingRoute(id: response.listingId));
      } else {
        //Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                AppLocalizations.of(context)!.translate('NEW_LISTING.ERROR_MESSAGE.UPLOAD'),
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface
                ),
              ),
              backgroundColor: Theme.of(context).backgroundColor.withOpacity(0.8),
            )
        );
        isLoading = false;
        Navigator.pop(context);
        setState(() {});
      }
    }
  }

  void onCategorySelect(CategoryModel selectedCategory) {
    setState(() {
      _selectedCategory = selectedCategory;
    });
  }

  void deleteData() async {
    await _sharedPreferencesService.deleteData("newListingPage");

    _titleController.text = "";
    _descriptionController.text = "";
    _priceController.text = "";
    _countController.text = "";
    selectedImages = [];
    _selectedCategory = CategoryModel.base();
    condition = 0;
    indexImageId = 0;

    setState(() {});
  }

  void setIndexPicture(int index) {
    FocusScope.of(context).requestFocus(FocusNode());
    indexImageId = index;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData().then((value) {
      if (savedData != NewListingLocalData.defaultState()) {
        Future.delayed(Duration.zero, () {
          showDialog(context: context, builder: (BuildContext context) {
            return BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 2.3,sigmaX: 2.3),
              child: AlertDialog(
                contentPadding: const EdgeInsets.only(left: 20,top: 35, bottom: 35),
                backgroundColor: Theme.of(context).colorScheme.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                title: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppLocalizations.of(context)!.translate('NEW_LISTING.ENTER_DIALOG.TITLE'),
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),
                    )
                ),
                content: Align(
                  alignment: Alignment.centerLeft,
                  heightFactor: 0,
                  child: Text(
                    AppLocalizations.of(context)!.translate('NEW_LISTING.ENTER_DIALOG.CONTENT'),
                    style: const TextStyle(
                        fontSize: 16
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      deleteData();
                      AutoRouter.of(context).pop();
                    },
                    child: Text(
                      AppLocalizations.of(context)!.translate('NEW_LISTING.ENTER_DIALOG.NO'),
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),

                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.translate('NEW_LISTING.ENTER_DIALOG.YES'),
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
        });
      }
    });
  }

  void _openCustomDialog() {
    showGeneralDialog(barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
              opacity: a1.value,
              child: const LoadingDialog()
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
      barrierDismissible: true,
      barrierLabel: '',
      context: context, pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation) { return const LoadingDialog(); },);
  }

  void removeImage(String _image, int index) {
    FocusScope.of(context).requestFocus(FocusNode());
    selectedImages.remove(_image);

    if (index == indexImageId) {
      indexImageId = 0;
    } else if(index < indexImageId) {
      indexImageId--;
    }
    setState(() {});
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _countController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext rootContext) {

    _scrollController.addListener(() {
      _titlePaddingNotifier.value = _horizontalTitlePadding;
    });

    return Scaffold(
      backgroundColor: Theme.of(rootContext).backgroundColor,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: _kExpandedHeight,
            backgroundColor: Theme.of(rootContext).colorScheme.surface,
            leading: IconButton(
              splashRadius: 15,
              onPressed: () {
                (_selectedCategory.id != 0 || _descriptionController.text != "" || _priceController.text.isNotEmpty || _titleController.text != "" || selectedImages.isNotEmpty || condition != 0 || _countController.text.isNotEmpty || indexImageId != 0)
                    ? showDialog(context: rootContext, builder: (BuildContext context) {
                  return ExitDialog(
                    rootContext: rootContext,
                    dataManager: exitAndSave,
                  );
                })
                    : Navigator.pop(context);

              },
              icon: const Icon(CupertinoIcons.back),
              color: Theme.of(rootContext).colorScheme.onSurface,
            ),
            actions: [
              IconButton(
                  splashRadius: 15,
                  onPressed: () {
                    submitNewListing();

                    if (isLoading) {
                      return _openCustomDialog();
                    }
                  },
                  icon: Icon(
                    LineIcons.check,
                    color: Theme.of(rootContext).colorScheme.onSurface,
                  )
              )
            ],
            flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                centerTitle: false,
                titlePadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                title: ValueListenableBuilder(
                  valueListenable: _titlePaddingNotifier,
                  builder: (context, value, child) {
                    return Padding(
                        padding: EdgeInsets.symmetric(horizontal: value as double),
                        child: Text(
                          AppLocalizations.of(context)!.translate('NEW_LISTING.TITLE'),
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface
                          ),
                        )
                    );
                  },
                ),
                background: Container(color: Theme.of(context).backgroundColor)
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
                          ImageDropper(
                            selectedImages: selectedImages,
                            onNewIndexImage: setIndexPicture,
                            onRemoveImage: removeImage,
                            indexImageId: indexImageId,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomInputField(
                            formHint: AppLocalizations.of(context)!.translate('NEW_LISTING.TITLE_INPUT.HINT'),
                            theme: Provider.of<ThemeNotifier>(context).getTheme(),
                            title: AppLocalizations.of(context)!.translate('NEW_LISTING.TITLE_INPUT.LABEL'),
                            inputController: _titleController,
                            textInputType: TextInputType.text,
                            errorText: '',
                            characterNumber: 128,
                            fSize: 20
                          ),
                          _labelText(AppLocalizations.of(context)!.translate('NEW_LISTING.CATEGORY_SELECT.LABEL'), Theme.of(context).colorScheme.onSurface, 16.0),
                          const SizedBox(
                            height: 10,
                          ),
                          CategorySelect(
                            selectedCategory: _selectedCategory,
                            selectedBorder: selectedBorder,
                            onCategorySelect: onCategorySelect,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, top: 7),
                            child: _labelText(selectErrorText, Theme.of(context).errorColor, 11.5)
                          ),
                          const SizedBox(
                              height: 15
                          ),
                          CustomInputField(
                            formHint: AppLocalizations.of(context)!.translate('NEW_LISTING.DESCRIPTION_INPUT.HINT'),
                            theme: Provider.of<ThemeNotifier>(context).getTheme(),
                            title: AppLocalizations.of(context)!.translate('NEW_LISTING.DESCRIPTION_INPUT.LABEL'),
                            inputController: _descriptionController,
                            textInputType: TextInputType.multiline,
                            errorText: '',
                            characterNumber: 5000,
                            fSize: 20
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomInputField(
                            formHint: AppLocalizations.of(context)!.translate('NEW_LISTING.PRICE_INPUT.HINT'),
                            theme: Provider.of<ThemeNotifier>(context).getTheme(),
                            title: AppLocalizations.of(context)!.translate('NEW_LISTING.PRICE_INPUT.LABEL'),
                            inputController: _priceController,
                            textInputType: TextInputType.number,
                            errorText: '',
                            characterNumber: 10,
                            fSize: 20
                          ),
                          _labelText(AppLocalizations.of(context)!.translate('NEW_LISTING.CONDITION.LABEL'), Theme.of(context).colorScheme.onSurface, 16.0),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomChoiceSelect(
                            onTap: (int id) {
                              setState(() {
                                condition = id;
                              });
                            },
                            selectedChoiceId: condition,
                            choices: conditions,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          CustomInputField(
                            formHint: AppLocalizations.of(context)!.translate('NEW_LISTING.COUNT.HINT'),
                            theme: Provider.of<ThemeNotifier>(context).getTheme(),
                            title: AppLocalizations.of(context)!.translate('NEW_LISTING.COUNT.LABEL'),
                            inputController: _countController,
                            textInputType: TextInputType.number,
                            errorText: '',
                            characterNumber: 10,
                            fSize: 20
                          ),
                          const SizedBox(
                            height: 40
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