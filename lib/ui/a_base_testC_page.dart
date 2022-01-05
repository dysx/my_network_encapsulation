import 'package:flutter/cupertino.dart';
import 'package:my_network_encapsulation/base/a_base_widget.dart';
import 'package:my_network_encapsulation/base/base_insert.dart';

/// @describe: home
/// @author: qds
class ABaseTestCPage extends ABaseWidget {
  ABaseTestCPage() : super(pageName: 'CCC');

  @override
  ABaseWidgetState<ABaseWidget> getState() => _ABaseTestCPageState();
}

class _ABaseTestCPageState extends ABaseWidgetState<ABaseTestCPage> {
  @override
  void onCreate() {
    super.onCreate();
  }

  @override
  Widget buildWidget(BuildContext context) {
    print('74444444');
    return Container(
      height: 200,
      width: 200,
      color: Colors.red,
    );
  }

  @override
  void onResume() {
    super.onResume();
  }
}
