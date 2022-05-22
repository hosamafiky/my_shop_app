class FbData {
  String? name;
  String? email;
  String? id;
  PictureData? picture;

  FbData.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    email = json["email"];
    id = json["id"];
    picture =
        json["data"] != null ? PictureData.fromJson(json["picture"]) : null;
  }
}

class PictureData {
  Picture? data;

  PictureData.fromJson(Map<String, dynamic> json) {
    data = json["data"] != null ? Picture.fromJson(json[data]) : null;
  }
}

class Picture {
  double? width;
  double? height;
  bool? isSilhouette;
  String? url;

  Picture.fromJson(Map<String, dynamic> json) {
    width = json["width"];
    height = json["height"];
    isSilhouette = json["is_silhouette"];
    url = json["url"];
  }
}
