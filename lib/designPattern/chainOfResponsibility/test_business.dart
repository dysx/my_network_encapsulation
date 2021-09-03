import 'package:my_network_encapsulation/base/base_insert.dart';
import 'package:my_network_encapsulation/designPattern/chainOfResponsibility/test_solve.dart';

abstract class BusinessChain {
  BusinessChain? nextDialog;

  void handleRequest(bool next) {
    if(passNext()){
      nextDialog?.handleRequest(next);
    }

    if (next) {
      // show();
      print('123456');
      nextDialog?.handleRequest(next);
    } else {
      // print('00000$next');
      // print(nextDialog.toString());
      // nextDialog?.handleRequest(next);
    }
  }

  bool passNext();

  void show();
}

class BusinessChainHandler {
  BusinessChain? _interceptFirst;

  void add(BusinessChain interceptChain) {
    if (_interceptFirst == null) {
      _interceptFirst = interceptChain;
      return;
    }

    BusinessChain node = _interceptFirst!;
    while (true) {
      if (node.nextDialog == null) {
        node.nextDialog = interceptChain;
        break;
      }
      node = node.nextDialog!;
    }
  }

  void handleRequest(int type, bool success) {
    _interceptFirst?.handleRequest(success);
  }
}

class ABusiness extends BusinessChain {

  @override
  void handleRequest(bool next) {
    // TODO: implement handleRequest
    if(next){
      show();
    }
    super.handleRequest(next);
  }

  @override
  void show() {
    // TODO: implement handleFail
    Alert.showAlert(confirm: 'aaa', cancel: '取消',onConfirm: (){
      handleRequest(true);
    });
  }

  @override
  bool passNext() {
    return true;
  }
}

class BusinessTest {

  static void test() {
    var intercepts = BusinessChainHandler();
    intercepts.add(ABusiness());
    // intercepts.add(BBusiness());
    // intercepts.add(CBusiness());
    intercepts.handleRequest(1, true);
  }

}