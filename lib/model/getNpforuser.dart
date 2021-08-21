// class GetNpforuser {
//   bool ok;
//   List<Rows> rows;

//   GetNpforuser({this.ok, this.rows});

//   GetNpforuser.fromJson(Map<String, dynamic> json) {
//     ok = json['ok'];
//     if (json['rows'] != null) {
//       rows = new List<Rows>();
//       json['rows'].forEach((v) {
//         rows.add(new Rows.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['ok'] = this.ok;
//     if (this.rows != null) {
//       data['rows'] = this.rows.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Rows {
//   int npId;
//   String npName;
//   String npAbout;
//   String npPhone;
//   String npEmail;
//   String npAdress;
//   String npDistrict;
//   String npProvince;
//   String npImgs;
//   Null npLat;
//   Null npLong;
//   int owId;

//   Rows(
//       {this.npId,
//       this.npName,
//       this.npAbout,
//       this.npPhone,
//       this.npEmail,
//       this.npAdress,
//       this.npDistrict,
//       this.npProvince,
//       this.npImgs,
//       this.npLat,
//       this.npLong,
//       this.owId});

//   Rows.fromJson(Map<String, dynamic> json) {
//     npId = json['np_id'];
//     npName = json['np_name'];
//     npAbout = json['np_about'];
//     npPhone = json['np_phone'];
//     npEmail = json['np_email'];
//     npAdress = json['np_adress'];
//     npDistrict = json['np_district'];
//     npProvince = json['np_province'];
//     npImgs = json['np_imgs'];
//     npLat = json['np_lat'];
//     npLong = json['np_long'];
//     owId = json['ow_id'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['np_id'] = this.npId;
//     data['np_name'] = this.npName;
//     data['np_about'] = this.npAbout;
//     data['np_phone'] = this.npPhone;
//     data['np_email'] = this.npEmail;
//     data['np_adress'] = this.npAdress;
//     data['np_district'] = this.npDistrict;
//     data['np_province'] = this.npProvince;
//     data['np_imgs']= this.npImgs;
//     data['np_lat'] = this.npLat;
//     data['np_long'] = this.npLong;
//     data['ow_id'] = this.owId;
//     return data;
//   }
// }

class GetNpforuser {
  bool ok;
  List<Rows> rows;

  GetNpforuser({this.ok, this.rows});

  GetNpforuser.fromJson(Map<String, dynamic> json) {
    ok = json['ok'];
    if (json['rows'] != null) {
      rows = new List<Rows>();
      json['rows'].forEach((v) {
        rows.add(new Rows.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ok'] = this.ok;
    if (this.rows != null) {
      data['rows'] = this.rows.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rows {
  int imgsproId;
  int npId;
  String npImgspro;
  int owId;
  String npName;
  String npAbout;
  String npPhone;
  String npEmail;
  String npAdress;
  String npDistrict;
  String npProvince;
  Null npLat;
  Null npLong;

  Rows(
      {this.imgsproId,
      this.npId,
      this.npImgspro,
      this.owId,
      this.npName,
      this.npAbout,
      this.npPhone,
      this.npEmail,
      this.npAdress,
      this.npDistrict,
      this.npProvince,
      this.npLat,
      this.npLong});

  Rows.fromJson(Map<String, dynamic> json) {
    imgsproId = json['imgspro_id'];
    npId = json['np_id'];
    npImgspro = json['np_imgspro'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imgspro_id'] = this.imgsproId;
    data['np_id'] = this.npId;
    data['np_imgspro'] = this.npImgspro;
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
    return data;
  }
}
