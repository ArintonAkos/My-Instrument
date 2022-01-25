class FavoriteRequest {

  final String listingId;
  final int language;

  FavoriteRequest({
    required this.listingId,
    this.language = 0
  });

  @override
  String toString() => '$listingId?language=$language';
}