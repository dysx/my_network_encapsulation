
import 'package:my_network_encapsulation/base/base_insert.dart';

/// 策略模式：适用于用不同行为去完成一件事情
/// 例如：弹窗类型很多：工单处理弹窗，流程审批弹窗，邀请类型弹窗，查看工单详情弹窗，提交信息弹窗。。。

class ShowStrategyDialog {
  static void show(
      {int? type,
      Function? onConfirm,
      Function? onCancel,
      Function? onAgree,
      Function? onRefuse,
      Function? onDetail,
      Function? onKnow,
      Function? onSubmit}) {
    Alert.showAlert(
      cancel: _cancel(type!),
      confirm: _confirm(type),
      onConfirm: () {
        switch (type) {
          case 1: return onConfirm!();
          case 2: return onAgree!();
          default: return onKnow!();
        }
      },
      onCancel: () {
        switch (type) {
          case 1: return onCancel!();
          case 2: return onRefuse!();
          default: return onCancel!();
        }
      }
    );
  }

  static String _cancel(int type) {
    switch (type) {
      case 1: return '取消';
      case 2: return '拒绝';
      default: return '取消';
    }
  }

  static String _confirm(int type) {
    switch (type) {
      case 1: return '确定';
      case 2: return '同意';
      default: return '确定';
    }
  }
}