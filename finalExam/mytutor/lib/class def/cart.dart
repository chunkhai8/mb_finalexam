class Cart {
  String? cartid;
  String? subjectid;
  String? cartqty;
  String? subjectname;
  String? price;
  String? pricetotal;

  Cart(
      {this.cartid,
      this.subjectid,
      this.cartqty,
      this.subjectname,
      this.price,
      this.pricetotal});

  Cart.fromJson(Map<String, dynamic> json) {
    cartid = json['cartid'];
    subjectid = json['subjectid'];
    cartqty = json['cartqty'];
    subjectname = json['subjectname'];
    price = json['price'];
    pricetotal = json['pricetotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cartid'] = cartid;
    data['subjectid'] = subjectid;
    data['cartqty'] = cartqty;
    data['subjectname'] = subjectname;
    data['price'] = price;
    data['pricetotal'] = pricetotal;
    return data;
  }
}