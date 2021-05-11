
import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// @name：
/// @author qds
/// @date 2020/10/23
class WebViewTest extends StatefulWidget {

  WebViewTest({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new WebViewTestState();
}

class WebViewTestState extends State<WebViewTest> {

  String _html = '''<html>
 <head></head>
 <body>
  <video style="width: 100%; height: 204px;" autoplay="true" controls="" playsinline="" webkit-playsinline="" name="media"> 
   <source src="http://94.191.56.133:9000/article/9bcf270c-a7e4-11eb-b868-e86f38485a7e.mp4" type="video/mp4"></source> 
  </video>
  <a href="http://www.baidu.com">百度</a>
 </body>
</html>''';

  final Completer<WebViewController> _controller =
  Completer<WebViewController>();
  WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('webView测试'),
      ),
      body: _webView(),
    );
  }

  Widget _webView() {
    return WebView(
      onWebViewCreated: (WebViewController webViewController){
        _webViewController = webViewController;
        _onNavigationDelegateExample(webViewController);
        _controller.complete(_webViewController);
      },
      onPageStarted: (content){
        // print("onPageStarted222:$content");
      },
      navigationDelegate: (NavigationRequest request){
        print('navigationDelegate:$request');
        print("webView的<a>标签");
        return NavigationDecision.prevent;
      },
      gestureNavigationEnabled: true,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // _webViewController.;
    super.dispose();
  }

  void _onNavigationDelegateExample(
      WebViewController controller) async {
    final String contentBase64 =
    base64Encode(const Utf8Encoder().convert(_html));
    await controller.loadUrl('data:text/html;base64,$contentBase64');
  }

}