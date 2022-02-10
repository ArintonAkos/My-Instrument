import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_instrument/src/business_logic/blocs/listing_page/listing_page_bloc.dart';
import 'package:my_instrument/src/data/repositories/listing_repository.dart';
import 'package:my_instrument/src/presentation/widgets/hero_photo_view.dart';
import 'package:my_instrument/src/shared/theme/theme_methods.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'listing_page_header.dart';

class ListingPage extends StatefulWidget {
  final String id;

  const ListingPage({
    Key? key,
    @PathParam('listingId') required this.id
  }) : super(key: key);

  @override
  _ListingPageState createState() => _ListingPageState();
}

class _ListingPageState extends State<ListingPage> {
  final imageListController = PageController(
    viewportFraction: 1,
    keepPage: true,
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListingPageBloc(
        listingRepository: RepositoryProvider.of<ListingRepository>(context)
      )..add(LoadListingEvent(listingId: widget.id)),
      child: BlocBuilder<ListingPageBloc, ListingPageState>(
        builder: (context, state) => Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          extendBodyBehindAppBar: true,
          body: Stack(
            children: [
              Container(
                color: Theme.of(context).colorScheme.primary,
                height: 500,
                child: PageView.builder(
                  controller: imageListController,
                  itemCount: 3,
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HeroPhotoView(
                              imageProvider: NetworkImage(
                                'https://dyrdkqpaj50j2.cloudfront.net/media/catalog/product/cache/15/image/600x650/9df78eab33525d08d6e5fb8d27136e95/a/f/afx-9851-white-x_24.jpg',
                              ),
                              heroTag: '${widget.id}-file-$index'
                            )
                          )
                        );
                      },
                      child: Container(
                        child: Hero(
                          tag: 'file-$index',
                          child: Image.network(
                            'https://dyrdkqpaj50j2.cloudfront.net/media/catalog/product/cache/15/image/600x650/9df78eab33525d08d6e5fb8d27136e95/a/f/afx-9851-white-x_24.jpg',
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  }
                ),
              ),
              NotificationListener<DraggableScrollableNotification>(
                onNotification: (DraggableScrollableNotification draggableScrollableNotification) {
                  if (!shouldShowAppBar && draggableScrollableNotification.extent >= 0.9) {
                    setState(() {
                      shouldShowAppBar = true;
                    });
                  } else if (shouldShowAppBar && draggableScrollableNotification.extent < 0.9) {
                    setState(() {
                      shouldShowAppBar = false;
                    });
                  }

                  return true;
                },
                child: DraggableScrollableSheet(
                  minChildSize: 0.6,
                  initialChildSize: 0.6,
                  maxChildSize: 1.0,
                  builder: (BuildContext context, ScrollController scrollController)
                    => SingleChildScrollView(
                      controller: scrollController,
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: SmoothPageIndicator(
                              controller: imageListController,
                              count: 3,
                              effect: ExpandingDotsEffect(
                                activeDotColor: Theme.of(context).colorScheme.primary,
                                dotColor: Colors.grey.withOpacity(0.8),
                                dotHeight: 11,
                                dotWidth: 11,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                              color: Theme.of(context).backgroundColor,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).backgroundColor,
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(0),
                                      bottomRight: Radius.circular(0),
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 16),
                                  alignment: const AlignmentDirectional(0, 1),
                                  child: Align(
                                    alignment: const AlignmentDirectional(0, -0.15),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  'Emerald Sude Loafers',
                                                  style: TextStyle(
                                                    fontFamily: 'Lexend Deca',
                                                    color: Theme.of(context).colorScheme.onSurface,
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Expanded(
                                              child: Text(
                                                '\$50.00',
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  fontFamily: 'Lexend Deca',
                                                  color: Theme.of(context).colorScheme.primary,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5,),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            const Text(
                                              'Includes VAT',
                                              style: TextStyle(
                                                fontSize: 13
                                              )
                                            ),
                                            const SizedBox(width: 10,),
                                            Text(
                                              'Free Shipping',
                                              style: TextStyle(
                                                color: Theme.of(context).colorScheme.primary,
                                                fontSize: 13
                                              )
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 3.5),
                                        RichText(
                                          text: TextSpan(
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Theme.of(context).colorScheme.onSurface
                                            ),
                                            children: const <TextSpan>[
                                              TextSpan(
                                                text: 'Expected delivery: '
                                              ),
                                              TextSpan(
                                                text: 'Tomorrow',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold
                                                )
                                              )
                                            ]
                                          )
                                        ),
                                        const SizedBox(height: 3.5),
                                        Text(
                                          'In Stock',
                                          style: TextStyle(
                                            color: Colors.greenAccent[400],
                                            fontSize: 13
                                          )
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                // const SizedBox(height: 15),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            print('Button pressed ...');
                                          },
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(18),
                                            ),
                                            padding: const EdgeInsets.symmetric(vertical: 14),
                                            textStyle: const TextStyle(
                                                fontSize: 15.5,
                                                fontWeight: FontWeight.bold
                                            ),
                                            shadowColor: Theme.of(context).colorScheme.primary
                                          ),
                                          child: const Text('Add to Cart'),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Product Description',
                                    style: TextStyle(
                                      fontFamily: 'Lexend Deca',
                                      color: Theme.of(context).colorScheme.onSurface,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: const [
                                      Expanded(
                                        child: Text(
                                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt utLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam labore et dolore magna aliqua. Ut enim ad minim veniam',
                                          style: TextStyle(
                                            fontFamily: 'Lexend Deca',
                                            color: Color(0xFF8B97A2),
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Specifications',
                                    style: TextStyle(
                                      fontFamily: 'Lexend Deca',
                                      color: Theme.of(context).colorScheme.onSurface,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ),
                                ListView.builder(
                                  controller: scrollController,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Category',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          'Guitar',
                                          style: TextStyle(
                                            color: Theme.of(context).colorScheme.onSurface,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18
                                          ),
                                        ),
                                        const SizedBox(height: 5,),
                                        Container(
                                          height: 1,
                                          width: double.maxFinite,
                                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)
                                        )
                                      ]
                                    ),
                                  )
                                ),
                                const SizedBox(height: 20,),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Reviews',
                                    style: TextStyle(
                                      fontFamily: 'Lexend Deca',
                                      color: Theme.of(context).colorScheme.onSurface,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Container(
                                  height: 300,
                                  color: Colors.red,
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Similar products',
                                    style: TextStyle(
                                      fontFamily: 'Lexend Deca',
                                      color: Theme.of(context).colorScheme.onSurface,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15,),
                                Container(
                                  height: 550,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) => Padding(
                                      padding: const EdgeInsets.all(25),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colors.red,
                                        ),
                                        height: 500,
                                        width: 500,
                                      ),
                                    ),
                                    itemCount: 100,
                                    scrollDirection: Axis.horizontal,
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ]
                      ),
                    ),
                ),
              ),
              SizedBox(
                height: 80,
                child: ListingPageHeader(
                  shouldShowAppBar: shouldShowAppBar,
                  listingId: widget.id
                )
              )
            ]
          )
        )
      ),
    );
  }


  bool shouldShowAppBar = false;
}