import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_instrument/src/business_logic/blocs/listing_page/listing_page_bloc.dart';
import 'package:my_instrument/src/data/repositories/listing_repository.dart';
import 'package:my_instrument/src/presentation/widgets/hero_photo_view.dart';
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
          appBar: listingPageHeader(context, state),
          extendBodyBehindAppBar: true,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Stack(
                        alignment: const AlignmentDirectional(0, -1),
                        children: [
                          SizedBox(
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
                                              'https://online.berklee.edu/takenote/wp-content/uploads/2021/01/acoustic_guitar_techniques_article_image_2021.jpg',
                                            ),
                                            heroTag: 'file-$index'
                                          )
                                        )
                                      );
                                    },
                                    child: Container(
                                      child: Hero(
                                        tag: 'file-$index',
                                        child: Image.network(
                                          'https://online.berklee.edu/takenote/wp-content/uploads/2021/01/acoustic_guitar_techniques_article_image_2021.jpg',
                                          width: MediaQuery.of(context).size.width,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                            ),
                          ),
                          Positioned(
                            bottom: 65,
                            child: SmoothPageIndicator(
                              controller: imageListController,
                              count: 3,
                              effect: WormEffect(
                                  activeDotColor: Theme.of(context).colorScheme.primary,
                                  dotColor: Colors.white.withOpacity(0.8),
                                  dotHeight: 11,
                                  dotWidth: 11
                              ),
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(0, 0.85),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 470, 0, 0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).backgroundColor,
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(0),
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                alignment: const AlignmentDirectional(0, 1),
                                child: Align(
                                  alignment: const AlignmentDirectional(0, -0.15),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(20, 16, 20, 12),
                                        child: Row(
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
                                            const Expanded(
                                              child: Text(
                                                '\$50.00',
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  fontFamily: 'Lexend Deca',
                                                  color: Color(0xFF4B39EF),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                          style: TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Expanded(
                        child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                            child: Text('asdasdasd')
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(12, 16, 12, 0),
                  child: Row(
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
                            /*text: 'Add to Cart [\$179.00]',
                            options: FFButtonOptions(
                              width: 300,
                              height: 54,
                              color: Color(0xFF4B39EF),
                              textStyle: FlutterFlowTheme.subtitle2.override(
                                fontFamily: 'Lexend Deca',
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              elevation: 3,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: 8,
                            ),*/
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 12, 20, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Product Description',
                        style: TextStyle(
                          fontFamily: 'Lexend Deca',
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 8, 20, 30),
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
                const SizedBox(
                  height: 5000,
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}