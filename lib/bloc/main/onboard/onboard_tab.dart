import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_instrument/bloc/main/onboard/onboard_data.dart';
import 'package:my_instrument/bloc/main/onboard/onboard_page.dart';

class OnBoardTab extends StatelessWidget {
  final OnBoardData onBoardData;

  OnBoardTab({
    required this.onBoardData
  });


  @override
  Widget build(BuildContext context) {
    return Container(
        color: onBoardData.backgroundColor,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    top: 100
                  ),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        onBoardData.imagePath,
                        height: 250,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          onBoardData.title,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 30.0,
                          left: 10.0,
                          right: 10.0
                        ),
                        child: Text(
                          onBoardData.description,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white
                          )
                        )
                      )
                    ],
                  )
                ),
              ],
            )
        )
    );
  }
  
}