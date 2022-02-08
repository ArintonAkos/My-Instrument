import 'dart:convert';
import 'dart:typed_data';

import 'package:my_instrument/src/data/data_providers/constants/category_constants.dart';
import 'package:my_instrument/src/data/models/responses/main/category/category_model.dart';

import 'base_cache_manager.dart';

class CategoryCacheManager extends BaseCacheManager {

  CategoryCacheManager() : super(key: CategoryConstants.categoryCacheKey);

  Future<CategoryModel?> getCategoryFromCache() async {
    var cache = await instance.getFileFromCache(CategoryConstants.categoryCacheKey);

    if (cache != null) {
      var cacheFile = cache.file;

      if (await cacheFile.exists()) {
        var encodedData = await cacheFile.readAsString();
        var decodedData = jsonDecode(encodedData);

        return CategoryModel(json: decodedData);
      }
    }

    return null;
  }

  Future<void> saveCategoryToCache(CategoryModel category) async {
    var jsonEncodedData = jsonEncode(category);
    var utf8EncodedData = utf8.encode(jsonEncodedData);
    Uint8List uInt8list = Uint8List.fromList(utf8EncodedData);

    await instance.putFile(
      key,
      uInt8list,
      fileExtension: 'json'
    );
  }

  Future<void> removeCache() async {
    await instance.removeFile(key);
  }
}