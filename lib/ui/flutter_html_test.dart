import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:my_network_encapsulation/base/my_base_widget.dart';

/// @name：
/// @author qds
/// @date 2020/10/23
class FlutterHtmlTest extends MyBaseWidget {
  @override
  MyBaseWidgetState<MyBaseWidget> getState() => new FlutterHtmlTestState();
}

class FlutterHtmlTestState extends MyBaseWidgetState<FlutterHtmlTest> {
  String _html = '''<video controls>
  <source src="http://94.191.56.133:9000/article/9bcf270c-a7e4-11eb-b868-e86f38485a7e.mp4" />
  </video>

''';

  String _str = '''<!DOCTYPE html>
  <html>
 <head>
  <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
 </head> 
 <body> 
  <form id="pay_form" name="pay_form" action="https://cashier.sandpay.com.cn/gateway/api/order/jumpQuickH5" method="post" accept-charset="UTF-8"> 
   <input type="hidden" name="sid" id="sid" value="SMP2104301356598918929727" /> 
   <input type="hidden" name="mid" id="mid" value="6888806015958" /> 
   <input type="hidden" name="orderCode" id="orderCode" value="H520210430135846" /> 
   <input type="hidden" name="totalAmount" id="totalAmount" value="000000000001" /> 
  </form>  
  <script type="text/javascript">document.pay_form.submit() </script> 
 </body>
</html>''';

  @override
  Widget buildWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Html(
        data: _html,
        customRender: {"video": (RenderContext context, Widget parsedChild, attributes, element) {
          // String videoUrl = attributes["source"];
          parsedChild = Container(
            height: 200,
            color: Colors.red,
          );
          print("标签的内容:$attributes");
          print(element.children[0].attributes['src']);
              return parsedChild;
              return Container(height: 200,color: Colors.red);
            },
          },
        blacklistedElements: [Platform.isAndroid ? "iframe" : "video"],
      ),
    );
  }

  @override
  void onCreate() {
    // TODO: implement onCreate
    setAppBarTitle('');
  }

  @override
  void onPause() {
    // TODO: implement onPause
  }

  @override
  void onResume() {
    // TODO: implement onResume
  }
}
