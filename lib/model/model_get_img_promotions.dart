class ImgPromotions {
  bool ok;
  List<Imgpro> imgpro;

  ImgPromotions({this.ok, this.imgpro});

  ImgPromotions.fromJson(Map<String, dynamic> json) {
    ok = json['ok'];
    if (json['imgpro'] != null) {
      imgpro = new List<Imgpro>();
      json['imgpro'].forEach((v) {
        imgpro.add(new Imgpro.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ok'] = this.ok;
    if (this.imgpro != null) {
      data['imgpro'] = this.imgpro.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Imgpro {
  int idImgPro;
  int proId;
  String proImg;

  Imgpro({this.idImgPro, this.proId, this.proImg});

  Imgpro.fromJson(Map<String, dynamic> json) {
    idImgPro = json['id_img_pro'];
    proId = json['pro_id'];
    proImg = json['pro_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_img_pro'] = this.idImgPro;
    data['pro_id'] = this.proId;
    data['pro_img'] = this.proImg;
    return data;
  }
}
