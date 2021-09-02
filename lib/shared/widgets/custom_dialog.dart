import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum DialogType {
  Success,
  Failure,
  Warning,
  Info
}

extension on DialogType {
  String get title {
    return ['Success', 'Error', 'Warning', 'Info'][this.index];
  }
}

class CustomDialog extends StatelessWidget {
  final String description;
  final DialogType dialogType;
  final Function? onAccept;

  static const iconList = <Icon>[
    Icon(Icons.done,
      color: Colors.white,
      size: 66,
    ),
    Icon(Icons.error,
      color: Colors.white,
      size: 66
    ),
    Icon(Icons.warning,
      color: Colors.white,
      size: 66
    ),
    Icon(Icons.info,
      color: Colors.white,
      size: 66,
    )
  ];

  CustomDialog({
    required this.description,
    required this.dialogType,
    this.onAccept
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        cardPart(context),
        circularImage(context)
      ],
    );
  }

  cardPart(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 82.0,
        bottom: 16.0,
        left: 16.0,
        right: 16.0,
      ),
      margin: EdgeInsets.only(top: 66.0),
      decoration: new BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: const Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // To make the card compact
        children: <Widget>[
          Text(
            dialogType.title,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 24.0),
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();// To close the dialog
                if(onAccept != null) {
                  onAccept!();
                }
              },
              child: Text('Okay'),
            ),
          ),
        ],
      ),
    );
  }

  circularImage(BuildContext context) {
    return Positioned(
      left: 16.0,
      right: 16.0,
      child: CircleAvatar(
        backgroundColor: _circularImageColor(context),
        radius: 66.0,
        child: _circularImageIcon()
      ),
    );
  }

  _circularImageColor(BuildContext context) {
    var colorList = <Color>[
      Colors.greenAccent[400] ?? Colors.greenAccent,
      Theme.of(context).errorColor,
      Color(0xFFfd9800),
      Colors.blueAccent
    ];
    return colorList[this.dialogType.index];
  }

  _circularImageIcon() {
    return iconList[this.dialogType.index];
  }

}