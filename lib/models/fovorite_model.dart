import 'package:shop_app/models/home_model.dart';

class FavoritesModel {
  bool? status;
  FavoritesDataModel? data;

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    data =
        json["data"] != null ? FavoritesDataModel.fromJson(json["data"]) : null;
  }
}

class FavoritesDataModel {
  List<FavoriteModel> favorites = [];

  FavoritesDataModel.fromJson(Map<String, dynamic> json) {
    json["data"].forEach((element) {
      favorites.add(FavoriteModel.fromJson(element));
    });
  }
}

class FavoriteModel {
  int? id;
  ProductModel? product;

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    product = ProductModel.fromJson(json["product"]);
  }
}

class AddFavorite {
  bool? status;
  String? message;
  FavoriteModel? data;

  AddFavorite.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json["data"] != null ? FavoriteModel.fromJson(json["data"]) : null;
  }
}
