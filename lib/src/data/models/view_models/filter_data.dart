class FilterData {
  final String search;
  final List<int> categories;
  final Map<int, List<int>> filters;
  final int page;

  const FilterData({
    required this.search,
    required this.categories,
    required this.filters,
    required this.page
  });

  FilterData copyWith({
    String? search,
    List<int>? categories,
    Map<int, List<int>>? filters,
    int? page
  }) {
    return FilterData(
      search: search ?? this.search,
      categories: categories ?? this.categories,
      filters: filters ?? this.filters,
      page: page ?? this.page
    );
  }

  factory FilterData.initial({
    String? search,
    List<int>? categories,
    Map<int, List<int>>? filters,
    int? page
  }) {
    return FilterData(
      search: search ?? '',
      categories: categories ?? [],
      filters: filters ?? <int, List<int>>{},
      page: page ?? 1
    );
  }
}