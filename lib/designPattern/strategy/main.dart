import 'package:my_network_encapsulation/designPattern/strategy/dialog.dart';
import 'package:my_network_encapsulation/designPattern/strategy/dialog_action.dart';

class Main {
  void main() {
    //根据接口获取
    var type = 1;
    late DialogAction strategy;
    switch (type) {
      case 1:
        strategy = OneStrategy();
        break;
      case 2:
        strategy = TwoStrategy();
        break;
    }

    //聚合弹窗按钮触发事件(不同弹窗的确定按钮，皆可聚合为一个onConfirm事件，其它同理)
    ShowStrategyDialog.show(
      //通过传入的type，显示对应类型的弹窗
      type: type,
      //确定按钮
      onConfirm: () {
        strategy.onConfirm();
      },
      //取消按钮
      onCancel: () {
        strategy.onCancel();
      },
      //同意按钮
      onAgree: () {
        strategy.onAgree();
      },
      //拒绝按钮
      onRefuse: () {
        strategy.onRefuse();
      },
      //查看详情按钮
      onDetail: () {
        strategy.onDetail();
      },
      //我知道了按钮
      onKnow: () {
        strategy.onKnow();
      },
      //提交按钮
      onSubmit: () {
        strategy.onSubmit();
      },
    );
  }
}

class OneStrategy extends DialogAction {
  @override
  void onConfirm() {
    print("确定");
  }

  @override
  void onCancel() {
    print("取消");
  }
}

class TwoStrategy extends DialogAction{
  @override
  void onAgree() {
    print("同意");
  }

  @override
  void onRefuse() {
    print("拒绝");
  }
}
