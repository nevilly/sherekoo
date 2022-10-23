class BundleOrderModel {
  String id;

  String cardType;
  String cardImage;
  String font;
  String middle;
  String back;
  String msg;
  String price;
  String quantity;
  String createdDate;

  BundleOrderModel(
      {required this.id,
      required this.cardType,
      required this.font,
      required this.middle,
      required this.back,
      required this.msg,
      required this.price,
      required this.quantity,
      required this.createdDate,
      required this.cardImage});

  factory BundleOrderModel.fromJson(Map<String, dynamic> json) {
    return BundleOrderModel(
        id: json['id'] ?? '',
        cardType: json['cardType'] ?? "",
        cardImage: json['cardImage'] ?? "",
        font: json['font'] ?? "",
        middle: json['middle'] ?? "",
        back: json['back'] ?? "",
        msg: json['msg'] ?? "",
        price: json['price'] ?? "",
        quantity: json['quantity'] ?? "",
        createdDate: json['createdDate'] ?? "");
  }
}
