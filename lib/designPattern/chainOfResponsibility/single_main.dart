

import 'package:my_network_encapsulation/designPattern/chainOfResponsibility/intercept_chain.dart';
import 'package:my_network_encapsulation/designPattern/chainOfResponsibility/single.dart';

class SingleMain {

  // static void use() {
  //   var intercepts = InterceptChainHandler<String>();
  //   intercepts.add(AIntercept());
  //   intercepts.add(BIntercept());
  //   intercepts.add(CIntercept());
  //   intercepts.add(DIntercept());
  //   intercepts.intercept("测试拦截器");
  // }

  static void test() {
    var intercepts = InterceptSingleHandler<String>();
    intercepts.add(AIntercept());
    intercepts.add(BIntercept());
    intercepts.add(CIntercept());
    intercepts.intercept("抽象单方法");
  }

}

class AIntercept extends InterceptSingle<String> {
  @override
  void intercept(String data, SingleHandler handler) {
    data = "$data：AIntercept";
    print(data);
    // TODO: implement intercept
    super.intercept(data, handler);
  }
}

class BIntercept extends InterceptSingle<String> {
  @override
  void intercept(String data, SingleHandler handler) {
    data = "$data：BIntercept";
    print(data);
    // TODO: implement intercept
    super.intercept(data, handler);
  }
}

class CIntercept extends InterceptSingle<String> {
  @override
  void intercept(String data, SingleHandler handler) {
    data = "$data：CIntercept";
    print(data);
    // TODO: implement intercept
    super.intercept(data, handler);
  }
}
