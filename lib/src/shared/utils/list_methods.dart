extension Replacing<E> on List<E> {
  /// Returns a new List after replacing the searched item
  List<E> findAndReplace(E newEntity, { required bool Function(E) searchCondition }) {
    /// Example for condition:
    /// ((element) => element.Id == userId)
    final List<E> tempList = this;

    final index = tempList.indexWhere(searchCondition);
    if (index != -1) {
      tempList.removeAt(index);
      tempList.insert(index, newEntity);
    }

    return tempList;
  }

  /// Return the initial List after replacing the searched item
  void findAndReplaceInList(E newEntity, { required bool Function(E) searchCondition }) {
    final index = indexWhere(searchCondition);
    if (index != -1) {
      removeAt(index);
      insert(index, newEntity);
    }
  }
}