import 'package:flutter/cupertino.dart';
import 'package:my_network_encapsulation/base/a_base_widget.dart';
import 'package:my_network_encapsulation/base/base_insert.dart';
import 'package:my_network_encapsulation/ui/a_base_testA_page.dart';

/// @describe: home
/// @author: qds
class ABaseTestPage extends ABaseWidget {
  ABaseTestPage() : super(pageName: 'AAA');

  @override
  ABaseWidgetState<ABaseWidget> getState() => _ABaseTestPageState();
}

class _ABaseTestPageState extends ABaseWidgetState<ABaseTestPage> {
  @override
  void onCreate() {
    super.onCreate();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
            context, CupertinoPageRoute(builder: (context) => ABaseTestAPage()));
      },
      child: Container(
        height: 200,
        width: 200,
        color: Colors.red,
      )
    );
  }

  @override
  void onResume() {
    super.onResume();
    print('123456789');
  }
}
