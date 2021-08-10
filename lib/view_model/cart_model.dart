import 'package:flutter/material.dart';
import 'package:my_network_encapsulation/network/model/goods_entity.dart';

class CartModel extends ChangeNotifier {
  List<GoodsEntity> _items = [];

  double get totalPrice {
    double totalPrice = 0.0;
    _items.forEach((goods) {
      totalPrice += goods.price!;
    });

    return totalPrice;
  }

  List<GoodsEntity> get items => _items;

  void add(GoodsEntity goods) {
    if (!isInCart(goods)) {
      _items.add(goods);
      notifyListeners();
    }
  }

  void remove(GoodsEntity goods) {
    if (isInCart(goods)) {
      _items.removeAt(getGoodIndex(goods));
      notifyListeners();
    }
  }

  bool isInCart(GoodsEntity goods) {
    return _items.any((element) => element.id == goods.id);
  }

  int getGoodIndex(GoodsEntity goods) {
    int goodIndex = -1;
    for (int i = 0; i < _items.length; i++) {
      if(_items[i].id == goods.id){
        goodIndex = i;
        break;
      }
    }
    return goodIndex;
  }

  void removeAll() {
    if (_items.length > 0) {
      _items.clear();
      notifyListeners();
    }
  }
}
