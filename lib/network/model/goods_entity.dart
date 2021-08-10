class GoodsEntity {
  int? id;
  String? name;
  String? imageUrl;
  double? price;
  bool? collect;

  static GoodsEntity fromJson(Map<String, dynamic> json) {
    GoodsEntity goods = GoodsEntity();
    goods.id = json['_id'];
    goods.name = json['name'];
    goods.imageUrl = json['imageUrl'];
    goods.price = json['price'];
    goods.collect = json['collect'];
    return goods;
  }
}
