
import 'dart:io';

extension FileExtension on File {

  /// 返回文件名
  String get fileName => path.split('/').last;

  /// 返回不含阔扎名的文件名
  String get fileNameWithoutExtension => fileName.split('.').first;

  /// 检查文件是否在目录
  /// param: Directory 目录
  bool isWithin(Directory dir) {
    return isWithin(dir);
  }

}
