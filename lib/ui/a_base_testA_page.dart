import 'package:flutter/cupertino.dart';
import 'package:my_network_encapsulation/base/a_base_widget.dart';
import 'package:my_network_encapsulation/base/base_insert.dart';
import 'package:my_network_encapsulation/ui/a_base_testC_page.dart';

/// @describe: home
/// @author: qds
class ABaseTestAPage extends ABaseWidget {
  ABaseTestAPage() : super(pageName: 'BBB');

  @override
  ABaseWidgetState<ABaseWidget> getState() => _ABaseTestAPageState();
}

class _ABaseTestAPageState extends ABaseWidgetState<ABaseTestAPage> {
  @override
  void onCreate() {
    super.onCreate();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return GestureDetector(
        onTap: (){
          Navigator.push(
              context, CupertinoPageRoute(builder: (context) => ABaseTestCPage()));
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
  }
}
