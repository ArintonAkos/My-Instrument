import 'package:flutter/material.dart';


class ListingCard extends StatelessWidget {
  final String imgUrl;
  final String listingName;
  final String listingPrice;
  final String listingDescription;
  const ListingCard({Key? key,
    required this.imgUrl,
    required this.listingName,
    required this.listingPrice,
    required this.listingDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        child: Stack(
          children: [
            Positioned(
              left: 0.0,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                child:
                  Image.network(imgUrl, fit: BoxFit.cover, width: 250,height: 300,),
              ),
            ),
            Positioned(
              // bottom: 1.0,
              left: 0.0,
              bottom: 0.0,
              height: 140.0,
              width: 210.0,
              child: Container(
                //padding: EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  //color: Colors.white,
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.all(Radius.circular(18), )
                  ),
                  child: Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 20,top: 20,),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    '$listingName',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.onSurface,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20,top: 10,right: 10,bottom: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '$listingDescription',
                            style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20,bottom: 10,top: 20),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                              '$listingPrice',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ),
              ),
            ),
            Positioned(
              left: 190.0,
              bottom: 35.0,
              height: 35.0,
              width: 35.0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: IconButton(
                  onPressed: () {
                  },

                  icon: Icon(
                    Icons.arrow_forward,
                    color: Theme.of(context).colorScheme.onPrimary,
                    size: 18,
                  ),
                  splashRadius: 0.1,
                )
              ),
            ),
          ],
        ),

      ),
    );
  }
}
