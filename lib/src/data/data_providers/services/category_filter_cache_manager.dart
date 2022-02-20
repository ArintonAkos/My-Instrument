import 'dart:convert';
import 'dart:typed_data';

import 'package:my_instrument/src/data/models/responses/main/category/filter_model.dart';

import '../../../shared/utils/list_parser.dart';
import '../constants/category_constants.dart';
import 'base_cache_manager.dart';

class CategoryFilterCacheManager extends BaseCacheManager {
  CategoryFilterCacheManager() : super(key: CategoryConstants.categoryFilterCacheKey,
    stalePeriod: const Duration(days: 7)
  );

  Future<List<FilterModel>?> getCategoryFiltersFromCache(int categoryId) async {
    var cache = await instance.getFileFromCache(_getFileName(categoryId));

    if (cache != null) {
      var cacheFile = cache.file;

      if (await cacheFile.exists()) {
        var encodedData = await cacheFile.readAsString();
        var decodedData = jsonDecode(encodedData);

        return ListParser.parse<FilterModel>(decodedData, FilterModel.fromJson);
      }
    }

    return null;
  }

  Future<void> saveCategoryFiltersToCache(List<FilterModel> filters, int categoryId) async {
    var jsonEncodedData = jsonEncode(filters);
    var utf8EncodedData = utf8.encode(jsonEncodedData);
    Uint8List uInt8list = Uint8List.fromList(utf8EncodedData);

    await instance.putFile(
      _getFileName(categoryId),
      uInt8list,
      fileExtension: 'json'
    );
  }

  Future<void> removeCache(int categoryId) async {
    await instance.removeFile(_getFileName(categoryId));
  }

  _getFileName(int categoryId) {
    return CategoryConstants.categoryFilterCacheKey + '-$categoryId';
  }
}