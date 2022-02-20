import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:my_instrument/src/presentation/pages/main/product_list_page/product_list_app_bar.dart';
import 'package:my_instrument/src/presentation/widgets/image_gallery.dart';
import 'package:my_instrument/src/presentation/widgets/long_press_item.dart';
import 'package:my_instrument/src/presentation/widgets/modal_inside_modal.dart';
import 'package:my_instrument/src/presentation/widgets/popup_action.dart';
import 'package:my_instrument/src/shared/translation/app_localizations.dart';

class ImageDropper extends StatefulWidget {

  final List<String> selectedImages;
  final Function(int id) onNewIndexImage;
  final Function(String _image, int index) onRemoveImage;
  final int indexImageId;

  const ImageDropper({
    Key? key,
    required this.selectedImages,
    required this.onNewIndexImage,
    required this.onRemoveImage,
    required this.indexImageId
  }) : super(key: key);

  @override
  _ImageDropperState createState() => _ImageDropperState();
}

class _ImageDropperState extends State<ImageDropper> {

  final List<OrderByModel> orderByModels = <OrderByModel>[
    OrderByModel(text: 'NEW_LISTING.IMAGE_DROPPER.CAMERA', value: 0),
    OrderByModel(text: 'NEW_LISTING.IMAGE_DROPPER.GALLERY', value: 1),
  ];

  _imgPicker(ImageSource source) async {
    if (source == ImageSource.camera) {
      XFile? selectedImage = (await ImagePicker().pickImage(source: source));

      if (selectedImage != null && widget.selectedImages.length < 5) {
        widget.selectedImages.add(selectedImage.path);
        Navigator.pop(context);
        setState(() {});
      }

    } else {
      List<XFile>? images = await ImagePicker().pickMultiImage();

      if(images != null) {
        int length = images.length;
        if (images.length + widget.selectedImages.length > 5) {
          length = 5 - widget.selectedImages.length;
        }
        for (int i = 0; i <length; ++i) {
          int bytes = await images[i].length();
          if (bytes < 5000000) {
            widget.selectedImages.add(images[i].path);
          }
        }
      }

      Navigator.pop(context);
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  void imageGallery() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => GalleryImg(
        urlImages: widget.selectedImages
      )
    ));
  }

  Widget selectedIndexCheckMark() {
    return Align(
      alignment: Alignment.topCenter,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 70,
          color: Colors.grey.withOpacity(0.8),
          child: const Icon(
            Icons.check,
            color: Colors.white,
            size: 25,
          ),
        ),
      )
    );
  }

  Widget _miniPicture(int index) {
    if (index < widget.selectedImages.length) {
      return LongPressItem(
        actions: [
          PopupAction(
            index: 1,
            count: 3,
            iconData: LineIcons.boxOpen,
            text: AppLocalizations.of(context)!.translate('NEW_LISTING.POPUP.OPEN'),
            onTap: imageGallery
          ),
          PopupAction(
            index: 2,
            count: 3,
            iconData: LineIcons.alternateShare,
            text: AppLocalizations.of(context)!.translate('NEW_LISTING.POPUP.INDEX_IMAGE'),
            onTap: () {
              widget.onNewIndexImage(index);
              Navigator.pop(context);
            },
          ),
          PopupAction(
            index: 3,
            count: 3,
            iconData: LineIcons.alternateTrashAlt,
            text: AppLocalizations.of(context)!.translate('NEW_LISTING.POPUP.DELETE'),
            isDanger: true,
            onTap: () {
              widget.onRemoveImage(widget.selectedImages[index], index);
            },
          )
        ],
        previewBuilder: (BuildContext context) =>
          SizedBox(
              height: 100,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Stack(
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: imageGallery,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          color: Colors.grey.withOpacity(0.3),
                          child: Image.file(
                            File(widget.selectedImages[index]),
                            height: 100,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      child: (index == widget.indexImageId)
                      ? Padding(
                        child: selectedIndexCheckMark(),
                        padding: const EdgeInsets.only(top: 5),
                      )
                      : null,
                    ),
                  ]
                ),
              ),
            ),
        popupBuilder: (BuildContext context) => ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: Colors.grey.shade400,
            child: Image.file(
              File(widget.selectedImages[index]),
              width: 400,
              height: 300,
              fit: BoxFit.cover,
            ),
          ),
        ),
        index: index,
      );
    }

    return InkWell(
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
            title: AppLocalizations.of(context)!.translate('NEW_LISTING.IMAGE_DROPPER.HINT'),
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

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: (widget.selectedImages.isEmpty)
      ? () => showCupertinoModalBottomSheet(
        topRadius: const Radius.circular(20),
        barrierColor: Colors.black.withOpacity(0.8),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20)
          )
        ),
        context: context,
        builder: (context) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(70),
          ),
          height: 210,
          child: ModalInsideModal(
            title: AppLocalizations.of(context)!.translate('NEW_LISTING.IMAGE_DROPPER.HINT'),
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
        height: (widget.selectedImages.isEmpty) ? 150 : null,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10)
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: (widget.selectedImages.isEmpty)
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
            //scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
            shrinkWrap: true,
          ),
        ),
      ),
    );
  }
}
