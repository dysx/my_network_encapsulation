import 'dart:io';

import 'package:my_network_encapsulation/base/base_insert.dart';
import 'package:my_network_encapsulation/config/appConfig.dart';
import 'package:permission_handler/permission_handler.dart';

///@describe: 权限管理
class PermissionManager {
  static List<Permission> listPermission = [];

  /// 申请读取文件权限(安卓：相册、文件，ios：相册)
  static Future applyStoragePermission(Function successOnTap) async {
    if(AppConfig.isAndroid){
      // 安卓平台
      PermissionStatus permission = await Permission.storage.status;
      if(permission != PermissionStatus.granted){
        // 权限没允许
        if(permission.isPermanentlyDenied){
          // 该权限被永久拒绝 => 弹框告知是否跳转设置权限
          _showDialog("读写文件");
        }else{
          // 重新请求权限
          await Permission.storage.request();
          if(await Permission.storage.isGranted){
            // 二次权限允许
            await successOnTap();
          }else {
            // 二次权限拒绝 => 弹框告知是否跳转设置权限
            _showDialog("读写文件");
          }
        }
      }else{
        // 权限允许
        await successOnTap();
      }
    }else{
      // ios平台，只能访问相册
      PermissionStatus permission = await Permission.photos.status;
      if(permission != PermissionStatus.granted){
        // 权限没允许
        if(permission.isPermanentlyDenied){
          // 该权限被永久拒绝 => 弹框告知是否跳转设置权限
          _showDialog("读写文件");
        }else{
          // 重新请求权限
          await Permission.photos.request();
          if(await Permission.photos.isGranted){
            // 二次权限允许
            await successOnTap();
          }else {
            // 二次权限拒绝 => 弹框告知是否跳转设置权限
            _showDialog("读写文件");
          }
        }
      }else{
        // 权限允许
        await successOnTap();
      }
    }
  }

  /// 申请相机权限
  static Future applyCameraPermission(Function successOnTap) async {
    PermissionStatus permission = await Permission.camera.status;
    if(permission != PermissionStatus.granted){
      // 权限没允许
      if(permission.isPermanentlyDenied){
        // 该权限被永久拒绝 => 弹框告知是否跳转设置权限
        _showDialog("相机");
      }else{
        // 重新请求权限
        await Permission.camera.request();
        if(await Permission.camera.isGranted){
          // 二次权限允许
          await successOnTap();
        }else {
          // 二次权限拒绝 => 弹框告知是否跳转设置权限
          _showDialog("相机");
        }
      }
    }else{
      // 权限允许
      await successOnTap();
    }
  }

  /// 申请电话权限
  static Future applyPhonePermission(Function successOnTap) async {
    PermissionStatus permission = await Permission.phone.status;
    if(permission != PermissionStatus.granted){
      // 权限没允许
      if(permission.isPermanentlyDenied){
        // 该权限被永久拒绝 => 弹框告知是否跳转设置权限
        _showDialog("电话");
      }else{
        // 重新请求权限
        await Permission.phone.request();
        if(await Permission.phone.isGranted){
          // 二次权限允许
          await successOnTap();
        }else {
          // 二次权限拒绝 => 弹框告知是否跳转设置权限
          _showDialog("电话");
        }
      }
    }else{
      // 权限允许
      await successOnTap();
    }
  }

  /// 申请语音权限
  static Future applyMicrophonePermission(Function successOnTap) async {
    PermissionStatus permission = await Permission.microphone.status;
    if(permission != PermissionStatus.granted){
      // 权限没允许
      if(permission.isPermanentlyDenied){
        // 该权限被永久拒绝 => 弹框告知是否跳转设置权限
        _showDialog("麦克风");
      }else{
        // 重新请求权限
        await Permission.microphone.request();
        if(await Permission.microphone.isGranted){
          // 二次权限允许
          await successOnTap();
        }else {
          // 二次权限拒绝 => 弹框告知是否跳转设置权限
          _showDialog("麦克风");
        }
      }
    }else{
      // 权限允许
      await successOnTap();
    }
  }

  /// 请求权限
  static Future request() async {
//     /// 检查权限
//     if (await Permission.storage.isUndetermined) {
//       /// 添加权限
//       listPermission.add(Permission.storage);
//     }
//     if (await Permission.camera.isUndetermined) {
//       listPermission.add(Permission.camera);
//     }
// //    if (await Permission.location.isUndetermined){
// //      listPermission.add(Permission.location);
// //    }
//     if (await Permission.phone.isUndetermined) {
//       listPermission.add(Permission.phone);
//     }
//     if (listPermission.isNotEmpty) {
//       Map<Permission, PermissionStatus> statuses =
//       await listPermission.request();
//
//       /// 请求结果
//       print(statuses);
//     }
  }

  /// 权限弹框
  static void _showDialog(String permissionName) {
    Alert.showAlert(
      title: '温馨提示',
      message: '获取$permissionName权限失败，请前往系统设置允许...app使用$permissionName',
      cancel: '取消',
      confirm: '去设置',
      showCancel: true,
      onConfirm: (){
        openAppSettings();
      }
    );
    // showDialog(
    //     context: context,
    //     barrierDismissible: true,
    //     builder: (BuildContext context) {
    //       return Material(
    //           color: Colors.transparent,
    //           child: PermissionDialog(
    //             title: permissionName,
    //             setting: () {
    //               Navigator.pop(context);
    //               openAppSettings();
    //             },
    //           ));
    //     });
  }
}
