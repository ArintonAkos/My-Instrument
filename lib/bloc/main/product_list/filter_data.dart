class FilterData {
  String search;
  List<int> categories;
  Map<int, List<int>> filters;

  FilterData({
    required this.search,
    required this.categories,
    required this.filters
  });
}