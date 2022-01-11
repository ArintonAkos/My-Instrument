import 'package:my_instrument/bloc/main/product_list/filter_data.dart';

import '../../backend_request.dart';

class GetListingsRequest implements BackendRequest {

  final FilterData filterData;

  GetListingsRequest({
    required this.filterData,
  });

  @override
  Map<String, dynamic> toJson() => {
    'search': filterData.search,
    'categories': filterData.categories,
    'filters': filterData.filters,
    'page': filterData.page
  };
}