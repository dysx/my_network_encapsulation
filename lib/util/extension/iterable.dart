/// Iterable操作
extension IterableExtension<E> on Iterable<E> {
  /// 返回第一个元素。如果内容为空，返回null
  E? get firstOrNUll => isEmpty ? null : first;

  /// 返回第一个符合条件的元素。如果不存在则返回null.
  E firstOrNullWhere(bool Function(E element) test) {
    return firstWhere(test);
  }

  /// 过滤掉所有的 null
  Iterable<E> get excludingNulls => where((e) => e != null);
}
