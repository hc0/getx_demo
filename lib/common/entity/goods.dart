class Goods {
  int? id;
  String? title;
  int price;

  Goods({this.id, this.title, this.price = 0});

  factory Goods.fromJson(Map<String, dynamic> json) => Goods(
        id: json["id"],
        title: json["title"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
      };
}
