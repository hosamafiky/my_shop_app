import 'package:shop_app/models/home_model.dart';

class CartModel {
  bool? status;
  CartDataModel? data;

  CartModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    data = json["data"] != null ? CartDataModel.fromJson(json["data"]) : null;
  }
}

class CartDataModel {
  List<InCartModel> cartItems = [];
  dynamic subTotal;
  dynamic total;
  CartDataModel.fromJson(Map<String, dynamic> json) {
    json["cart_items"].forEach((element) {
      cartItems.add(InCartModel.fromJson(element));
    });
    subTotal = json["sub_total"];
    total = json["total"];
  }
}

class InCartModel {
  int? id;
  int? quantity;
  ProductModel? product;

  InCartModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    quantity = json["quantity"];
    product = ProductModel.fromJson(json["product"]);
  }
}

class CartChange {
  bool? status;
  String? message;
  InCartModel? data;

  CartChange.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json["data"] != null ? InCartModel.fromJson(json["data"]) : null;
  }
}
