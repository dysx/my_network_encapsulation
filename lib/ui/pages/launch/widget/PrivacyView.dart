import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

typedef OnTapCallback = void Function(String key);

/// @describe: 自动从data中查找keys，例《用户协议》和《隐私政策》
/// @author: qds
/// @date:
class PrivacyView extends StatefulWidget {
  final String data;
  final List<String> keys;
  final TextStyle? style;
  final TextStyle? keyStyle;
  final OnTapCallback? onTapCallback;

  const PrivacyView({
    Key? key,
    required this.data,
    required this.keys,
    this.style,
    this.keyStyle,
    this.onTapCallback,
  }) : super(key: key);

  @override
  _PrivacyViewState createState() => _PrivacyViewState();
}

class _PrivacyViewState extends State<PrivacyView> {
  List<String> _list = [];

  @override
  void initState() {
    _split();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: <InlineSpan>[
            ..._list.map((e) {
              if (widget.keys.contains(e)) {
                return TextSpan(
                  text: '$e',
                  style: widget.keyStyle ??
                      TextStyle(color: Theme.of(context).primaryColor),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      widget.onTapCallback?.call(e);
                    },
                );
              } else {
                return TextSpan(text: '$e', style: widget.style);
              }
            }).toList()
          ]),
    );
  }

  void _split() {
    int startIndex = 0;
    Map<String, dynamic>? _index;
    while ((_index = _nextIndex(startIndex)) != null) {
      int i = _index?['index'];
      String sub = widget.data.substring(startIndex, i);
      if (sub != '') {
        _list.add(sub);
      }
      _list.add(_index?['key']);
      startIndex = i + (_index?['key'] as String).length;
    }
    //为了将最后一个keys后面的内容展示出来
    if((_index = _nextIndex(startIndex)) == null){
      String sub = widget.data.substring(startIndex, widget.data.length);
      _list.add(sub);
    }
  }

  Map<String, dynamic>? _nextIndex(int startIndex) {
    int currentIndex = widget.data.length;
    String? key;
    widget.keys.forEach((element) {
      int index = widget.data.indexOf(element, startIndex);
      if (index != -1 && index < currentIndex) {
        currentIndex = index;
        key = element;
      }
    });
    if (key == null) {
      return null;
    }
    return {'key': '$key', 'index': currentIndex};
  }
}