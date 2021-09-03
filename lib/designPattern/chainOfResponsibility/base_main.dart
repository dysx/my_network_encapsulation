

import 'package:my_network_encapsulation/designPattern/chainOfResponsibility/intercept_chain.dart';

class Chain {

  static void use() {
    var intercepts = InterceptChainHandler<String>();
    intercepts.add(AIntercept());
    intercepts.add(BIntercept());
    intercepts.add(CIntercept());
    intercepts.add(DIntercept());
    intercepts.intercept("测试拦截器");
  }

}

class AIntercept extends InterceptChain<String> {
  @override
  void intercept(String data) {
    data = "$data：AIntercept";
    print(data);
    super.intercept(data);
  }
}

class BIntercept extends InterceptChain<String> {
  @override
  void intercept(String data) {
    data = "$data：BIntercept";
    print(data);
    super.intercept(data);
  }
}

class CIntercept extends InterceptChain<String> {
  @override
  void intercept(String data) {
    data = "$data：CIntercept";
    print(data);
    super.intercept(data);
  }
}

class DIntercept extends InterceptChain<String> {
  @override
  void intercept(String data) {
    data = "$data：DIntercept";
    print(data);
    super.intercept(data);
  }
}
