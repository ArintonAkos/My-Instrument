import 'dart:convert';

import 'package:my_instrument/services/models/requests/backend_request.dart';

class GetListingsRequest implements BackendRequest {

  final String search;
  final List<int> categories;
  final Map<int, List<int>> filters;
  final int page;

  GetListingsRequest({
    required this.search,
    required this.categories,
    required this.filters,
    required this.page
  });

  @override
  Map<String, dynamic> toJson() => {
    'search': search,
    'categories': categories,
    'filters': filters,
    'page': page
  };
}