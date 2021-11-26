/// @describe: 快速排序
class QuickSort {
  /*
   * 快速排序
   *
   * 参数说明：
   *     a -- 待排序的数组
   *     l -- 数组的左边界(例如，从起始位置开始排序，则l=0)
   *     r -- 数组的右边界(例如，排序截至到数组末尾，则r=a.length-1)
   */
  static void quickSort(List<int> a, int low, int high,DateTime start) {
    if (low < high) {
      int i, j, tmp;

      i = low;
      j = high;
      tmp = a[i];
      while (i < j) {
        // 直到 队尾的元素大于等于基准数据时,向前挪动high指针 结束
        while (i < j && a[j] > tmp) j--;

        // 如果队尾元素小于tmp了,需要将其赋值给low
        if (i < j) a[i++] = a[j];

        // 直到 当队首元素小于等于tmp时,向后挪动low指针 结束
        while (i < j && a[i] < tmp) i++;

        if (i < j) a[j--] = a[i];
      }
      // 跳出循环时low和high相等,此时的low或high就是tmp的正确索引位置
      // 由原理部分可以很清楚的知道low位置的值并不是tmp,所以需要将tmp赋值给arr[low]
      a[i] = tmp;
      quickSort(a, low, i - 1,start); /* 递归调用 */
      quickSort(a, i + 1, high,start); /* 递归调用 */
    }
    if(low == high){
      DateTime end = DateTime.now();
      print('快速排序消耗时间：${end.difference(start)}');
      print('快速排序后的数组：$a');
    }
  }
}
