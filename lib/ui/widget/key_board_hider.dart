import 'package:flutter/services.dart';
import 'package:my_network_encapsulation/base/base_insert.dart';

abstract class KeyBoardHiderMixin {
  void hideKeyboard(
      {BuildContext? context,
      bool hideTextInput = true,
      bool requestFocusNode = true,
      VoidCallback? onTap}) {
    if (hideTextInput) {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    }
    if (context != null && requestFocusNode) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }
}

///@name: 键盘失去焦点
class KeyboardHider extends StatelessWidget with KeyBoardHiderMixin {
  final Widget child;
  final bool? hideTextInput;
  final bool? requestFocusNode;
  final VoidCallback? onTap;

  KeyboardHider(
      {Key? key,
      required this.child,
      this.requestFocusNode,
      this.hideTextInput,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          hideKeyboard(
              context: context,
              hideTextInput: hideTextInput ?? true,
              requestFocusNode: requestFocusNode ?? true);
          if(onTap != null) onTap!();
        },
        child: child);
  }
}
