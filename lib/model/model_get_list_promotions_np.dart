class ListPromotionsNp {
  bool ok;
  List<Rsprobynp> rsprobynp;

  ListPromotionsNp({this.ok, this.rsprobynp});

  ListPromotionsNp.fromJson(Map<String, dynamic> json) {
    ok = json['ok'];
    if (json['rsprobynp'] != null) {
      rsprobynp = new List<Rsprobynp>();
      json['rsprobynp'].forEach((v) {
        rsprobynp.add(new Rsprobynp.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ok'] = this.ok;
    if (this.rsprobynp != null) {
      data['rsprobynp'] = this.rsprobynp.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rsprobynp {
  int proId;
  int npId;
  String proTopic;
  String proDetail;
  String proStart;
  String proEnd;
  String proTime;
  int idImgPro;
  String proImg;

  Rsprobynp(
      {this.proId,
      this.npId,
      this.proTopic,
      this.proDetail,
      this.proStart,
      this.proEnd,
      this.proTime,
      this.idImgPro,
      this.proImg});

  Rsprobynp.fromJson(Map<String, dynamic> json) {
    proId = json['pro_id'];
    npId = json['np_id'];
    proTopic = json['pro_topic'];
    proDetail = json['pro_detail'];
    proStart = json['pro_start'];
    proEnd = json['pro_end'];
    proTime = json['pro_time'];
    idImgPro = json['id_img_pro'];
    proImg = json['pro_img'];
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
    return data;
  }
}
