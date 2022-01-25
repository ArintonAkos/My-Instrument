import 'package:flutter/cupertino.dart';
import 'package:my_instrument/src/presentation/widgets/listing_card.dart';

class DiscoverSlider extends StatelessWidget {
  final controller = PageController(viewportFraction: 0.8);
  final List<String> imgList;

  DiscoverSlider({Key? key,
    required this.imgList
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 350,
              child: PageView(
                controller: controller,
                children: List.generate(
                  6,
                  (index) => ListingCard(
                    imgUrl: imgList[index],
                    listingName: 'Shecter Guitar',
                    listingPrice: '420.69',
                    listingDescription: 'Description',
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}