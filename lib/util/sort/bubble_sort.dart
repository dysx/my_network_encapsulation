
/// @describe: 冒泡排序
class BuBBleSort {
  static bubbleSort(List<int>? list) {
    print('冒泡排序前的数组: $list');
    // 判断边界条件
    if (list == null || list.length < 2) return;

    DateTime start = DateTime.now();
    // 需要进行list.length趟比较
    for (int i = 0; i < list.length; i++) {
      // 第i趟比较
      for (int j = 0; j < list.length - i - 1; j++) {
        // 开始进行比较，如果list[j]比list[j+1]的值大，那就交换位置
        if (list[j] > list[j + 1]) {
          int temp = list[j];
          list[j] = list[j + 1];
          list[j + 1] = temp;
        }
      }
    }
    DateTime end = DateTime.now();
    print('冒泡排序耗时为: ${end.difference(start)}');
    print('冒泡排序后的数组: $list');
  }
}
