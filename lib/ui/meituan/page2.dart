import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/ui/meituan/shop_scroll_controller.dart';
import 'package:my_network_encapsulation/ui/meituan/shop_scroll_coordinator.dart';


class Page2 extends StatefulWidget {
  final ShopScrollCoordinator shopCoordinator;

  const Page2({@required this.shopCoordinator, Key key}) : super(key: key);

  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> with AutomaticKeepAliveClientMixin {
  ShopScrollCoordinator _shopCoordinator;
  ShopScrollController _listScrollController;

  @override
  void initState() {
    _shopCoordinator = widget.shopCoordinator;
    _listScrollController = _shopCoordinator.newChildScrollController();
    _listScrollController.addListener((){
      if(_listScrollController.position.pixels == _listScrollController.position.maxScrollExtent){
        print('滑到底部');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(0),
      physics: ClampingScrollPhysics(),
      controller: _listScrollController,
      itemCount: 50,
      itemExtent: 150,
      itemBuilder: (context, index) => Container(
        child: Material(
          elevation: 4.0,
          borderRadius: BorderRadius.circular(5.0),
          color: index % 2 == 0 ? Colors.cyan : Colors.deepOrange,
          child: Center(child: Text(index.toString())),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _listScrollController?.dispose();
    _listScrollController = null;
    super.dispose();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}
