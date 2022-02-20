class CategoryConstants {
  static const _categoryURL = 'Category/';

  // Requires categoryId parameter
  static const categoryAllChildrenURL = _categoryURL + 'CategoryWithAllChildren';

  // Requires categoryId parameter
  static const categoryChildrenURL = _categoryURL + 'CategoryChildren';

  // Required for caching (key)
  static const categoryCacheKey = 'Category-CategoryWithAllChildren-0';

  static const categoryFilterCacheKey = 'Category-CategoryFilters';

  static const categoryFilters = _categoryURL + 'CategoryFilters';
}