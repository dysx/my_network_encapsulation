
/// 将string强转num
extension ParseNumbers on String {
  int parseInt() => int.parse(this);

  double parseDouble() => double.parse(this);
}
