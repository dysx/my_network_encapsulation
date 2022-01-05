import 'dart:math';

/// @describe: 合并排序
class MergeSort {
  /// 随机生成数组
  static List<int> generateIntegers() {
    List<int> li = [];
    for (int i = 0; i < 10; i++) {
      int x = Random().nextInt(10000);
      li.add(x);
    }
    return li;
  }

  static void merge(List<int> lst, int left, int mid, int right){
    int i=left, j=mid+1;
    List<int> temp= [];
    while(i<=mid && j<=right){
      if(lst[i]<lst[j]){
        temp.add(lst[i++]);
      }else{
        temp.add(lst[j++]);
      }
    }
    while(i<=mid){
      temp.add(lst[i++]);
    }
    while(j<=right){
      temp.add(lst[j++]);
    }
    for(int k=left;k<=right;k++)
      lst[k]=temp[k-left];
    print('排序后的数组：$temp');
  }

  static void sort(List<int> lst, int left, int right){
    if(left>=right)return;
    int mid=(left+right)~/2;
    print('mid: $mid');
    sort(lst, left, mid);
    sort(lst, mid+1, right);
    print('数组分割: $lst');
    merge(lst, left, mid, right);
  }
}
