import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UploadedImagePreview extends StatelessWidget {
  const UploadedImagePreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: CupertinoContextMenu(
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('asdsd'),
          )
        ],
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.red
          ),
        ),
      ),
    );
  }
}
