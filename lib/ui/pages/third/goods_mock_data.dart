import 'package:my_network_encapsulation/network/model/goods_entity.dart';

/// @describe: 虚拟收藏数据
/// @author: qds
/// @date:
class GoodsMockData {
  static List<GoodsEntity> list(int page, int size) {
    if (page > 2) {
      size = 15;
    }
    return List<GoodsEntity>.generate(size, (index) {
      int id = index + (page - 1) * size + 1;
      GoodsEntity goodsEntity = GoodsEntity();
      goodsEntity.id = id;
      goodsEntity.name = '商品$id';
      if (id == 1 || id == 2 || id == 39) {
        goodsEntity.collect = true;
      } else {
        goodsEntity.collect = false;
      }
      // goodsEntity.collect = false;
      goodsEntity.price = id * 10.5;
      goodsEntity.imageUrl = id % 2 == 0
          ? 'https://img10.360buyimg.com/ddimg/jfs/t1/196622/32/15344/79769/61012148E85f8e012/13a997ee2e6d36ba.jpg'
          : 'https://img14.360buyimg.com/ddimg/jfs/t1/195166/7/16561/1704049/610a59b1Ec82b0584/67839b2e5bd118ba.png';
      return goodsEntity;
    });
  }
}
