/// 默认实现抛异常,可提醒未实现方法被误用
abstract class DialogAction {
  ///确定
  void onConfirm() {
    throw 'DialogAction：not implement onConfirm()';
  }

  ///取消
  void onCancel() {
    throw 'DialogAction：not implement onCancel()';
  }

  ///同意
  void onAgree() {
    throw 'DialogAction：not implement onAgree()';
  }

  ///拒绝
  void onRefuse() {
    throw 'DialogAction：not implement onRefuse()';
  }

  ///查看详情
  void onDetail() {
    throw 'DialogAction：not implement onDetail()';
  }

  ///我知道了
  void onKnow() {
    throw 'DialogAction：not implement onKnow()';
  }

  ///提交
  void onSubmit() {
    throw 'DialogAction：not implement onSubmit()';
  }
}
