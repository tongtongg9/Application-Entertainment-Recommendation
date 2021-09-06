class ShowImgnpforUser {
  bool ok;
  List<Imgsrows> imgsrows;

  ShowImgnpforUser({this.ok, this.imgsrows});

  ShowImgnpforUser.fromJson(Map<String, dynamic> json) {
    ok = json['ok'];
    if (json['imgsrows'] != null) {
      imgsrows = new List<Imgsrows>();
      json['imgsrows'].forEach((v) {
        imgsrows.add(new Imgsrows.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ok'] = this.ok;
    if (this.imgsrows != null) {
      data['imgsrows'] = this.imgsrows.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Imgsrows {
  int npImgId;
  String npImg;
  int npId;

  Imgsrows({this.npImgId, this.npImg, this.npId});

  Imgsrows.fromJson(Map<String, dynamic> json) {
    npImgId = json['np_img_id'];
    npImg = json['np_img'];
    npId = json['np_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['np_img_id'] = this.npImgId;
    data['np_img'] = this.npImg;
    data['np_id'] = this.npId;
    return data;
  }
}

// class ShowImgNp {
//   bool ok;
//   List<Imgnp> imgnp;

//   ShowImgNp({this.ok, this.imgnp});

//   ShowImgNp.fromJson(Map<String, dynamic> json) {
//     ok = json['ok'];
//     if (json['imgnp'] != null) {
//       imgnp = new List<Imgnp>();
//       json['imgnp'].forEach((v) {
//         imgnp.add(new Imgnp.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['ok'] = this.ok;
//     if (this.imgnp != null) {
//       data['imgnp'] = this.imgnp.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Imgnp {
//   int npImgId;
//   int npId;
//   String npImg;
//   int owId;
//   String npName;
//   String npAbout;
//   String npPhone;
//   String npEmail;
//   String npAdress;
//   String npDistrict;
//   String npProvince;
//   Null npLat;
//   Null npLong;

//   Imgnp(
//       {this.npImgId,
//       this.npId,
//       this.npImg,
//       this.owId,
//       this.npName,
//       this.npAbout,
//       this.npPhone,
//       this.npEmail,
//       this.npAdress,
//       this.npDistrict,
//       this.npProvince,
//       this.npLat,
//       this.npLong});

//   Imgnp.fromJson(Map<String, dynamic> json) {
//     npImgId = json['np_img_id'];
//     npId = json['np_id'];
//     npImg = json['np_img'];
//     owId = json['ow_id'];
//     npName = json['np_name'];
//     npAbout = json['np_about'];
//     npPhone = json['np_phone'];
//     npEmail = json['np_email'];
//     npAdress = json['np_adress'];
//     npDistrict = json['np_district'];
//     npProvince = json['np_province'];
//     npLat = json['np_lat'];
//     npLong = json['np_long'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['np_img_id'] = this.npImgId;
//     data['np_id'] = this.npId;
//     data['np_img'] = this.npImg;
//     data['ow_id'] = this.owId;
//     data['np_name'] = this.npName;
//     data['np_about'] = this.npAbout;
//     data['np_phone'] = this.npPhone;
//     data['np_email'] = this.npEmail;
//     data['np_adress'] = this.npAdress;
//     data['np_district'] = this.npDistrict;
//     data['np_province'] = this.npProvince;
//     data['np_lat'] = this.npLat;
//     data['np_long'] = this.npLong;
//     return data;
//   }
// }