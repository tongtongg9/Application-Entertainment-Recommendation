class ListPromotions {
  bool ok;
  List<Showpromotions> showpromotions;

  ListPromotions({this.ok, this.showpromotions});

  ListPromotions.fromJson(Map<String, dynamic> json) {
    ok = json['ok'];
    if (json['showpromotions'] != null) {
      showpromotions = new List<Showpromotions>();
      json['showpromotions'].forEach((v) {
        showpromotions.add(new Showpromotions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ok'] = this.ok;
    if (this.showpromotions != null) {
      data['showpromotions'] =
          this.showpromotions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Showpromotions {
  int proId;
  int npId;
  String proTopic;
  String proDetail;
  String proStart;
  String proEnd;
  String proTime;
  int idImgPro;
  String proImg;
  int owId;
  String npName;
  String npAbout;
  String npPhone;
  String npEmail;
  String npAdress;
  String npDistrict;
  String npProvince;
  double npLat;
  double npLong;
  String npBkStatus;

  Showpromotions(
      {this.proId,
      this.npId,
      this.proTopic,
      this.proDetail,
      this.proStart,
      this.proEnd,
      this.proTime,
      this.idImgPro,
      this.proImg,
      this.owId,
      this.npName,
      this.npAbout,
      this.npPhone,
      this.npEmail,
      this.npAdress,
      this.npDistrict,
      this.npProvince,
      this.npLat,
      this.npLong,
      this.npBkStatus});

  Showpromotions.fromJson(Map<String, dynamic> json) {
    proId = json['pro_id'];
    npId = json['np_id'];
    proTopic = json['pro_topic'];
    proDetail = json['pro_detail'];
    proStart = json['pro_start'];
    proEnd = json['pro_end'];
    proTime = json['pro_time'];
    idImgPro = json['id_img_pro'];
    proImg = json['pro_img'];
    owId = json['ow_id'];
    npName = json['np_name'];
    npAbout = json['np_about'];
    npPhone = json['np_phone'];
    npEmail = json['np_email'];
    npAdress = json['np_adress'];
    npDistrict = json['np_district'];
    npProvince = json['np_province'];
    npLat = json['np_lat'];
    npLong = json['np_long'];
    npBkStatus = json['np_bk_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pro_id'] = this.proId;
    data['np_id'] = this.npId;
    data['pro_topic'] = this.proTopic;
    data['pro_detail'] = this.proDetail;
    data['pro_start'] = this.proStart;
    data['pro_end'] = this.proEnd;
    data['pro_time'] = this.proTime;
    data['id_img_pro'] = this.idImgPro;
    data['pro_img'] = this.proImg;
    data['ow_id'] = this.owId;
    data['np_name'] = this.npName;
    data['np_about'] = this.npAbout;
    data['np_phone'] = this.npPhone;
    data['np_email'] = this.npEmail;
    data['np_adress'] = this.npAdress;
    data['np_district'] = this.npDistrict;
    data['np_province'] = this.npProvince;
    data['np_lat'] = this.npLat;
    data['np_long'] = this.npLong;
    data['np_bk_status'] = this.npBkStatus;
    return data;
  }
}
