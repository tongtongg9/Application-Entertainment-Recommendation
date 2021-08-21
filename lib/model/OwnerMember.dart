// class OwnerMember {
//   bool ok;
//   Info info;

//   OwnerMember({this.ok, this.info});

//   OwnerMember.fromJson(Map<String, dynamic> json) {
//     ok = json['ok'];
//     info = json['info'] != null ? new Info.fromJson(json['info']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['ok'] = this.ok;
//     if (this.info != null) {
//       data['info'] = this.info.toJson();
//     }
//     return data;
//   }
// }

// class Info {
//   int owId;
//   String owUsername;
//   String owPassword;
//   String owName;
//   String owLastname;
//   String owPhone;
//   String owEmail;
//   String owGender;
//   int owAge;

//   Info(
//       {this.owId,
//       this.owUsername,
//       this.owPassword,
//       this.owName,
//       this.owLastname,
//       this.owPhone,
//       this.owEmail,
//       this.owGender,
//       this.owAge});

//   Info.fromJson(Map<String, dynamic> json) {
//     owId = json['ow_id'];
//     owUsername = json['ow_username'];
//     owPassword = json['ow_password'];
//     owName = json['ow_name'];
//     owLastname = json['ow_lastname'];
//     owPhone = json['ow_phone'];
//     owEmail = json['ow_email'];
//     owGender = json['ow_gender'];
//     owAge = json['ow_age'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['ow_id'] = this.owId;
//     data['ow_username'] = this.owUsername;
//     data['ow_password'] = this.owPassword;
//     data['ow_name'] = this.owName;
//     data['ow_lastname'] = this.owLastname;
//     data['ow_phone'] = this.owPhone;
//     data['ow_email'] = this.owEmail;
//     data['ow_gender'] = this.owGender;
//     data['ow_age'] = this.owAge;
//     return data;
//   }
// }

// class Np_by_Owner {
//   bool ok;
//   List<Rows> rows;

//   Np_by_Owner({this.ok, this.rows});

//   Np_by_Owner.fromJson(Map<String, dynamic> json) {
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
//   String npPhone;
//   String npEmail;
//   String npAdress;
//   String npDistrict;
//   String npProvince;
//   int npLat;
//   int npLong;
//   int owId;

//   Rows(
//       {this.npId,
//       this.npName,
//       this.npPhone,
//       this.npEmail,
//       this.npAdress,
//       this.npDistrict,
//       this.npProvince,
//       this.npLat,
//       this.npLong,
//       this.owId});

//   Rows.fromJson(Map<String, dynamic> json) {
//     npId = json['np_id'];
//     npName = json['np_name'];
//     npPhone = json['np_phone'];
//     npEmail = json['np_email'];
//     npAdress = json['np_adress'];
//     npDistrict = json['np_district'];
//     npProvince = json['np_province'];
//     npLat = json['np_lat'];
//     npLong = json['np_long'];
//     owId = json['ow_id'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['np_id'] = this.npId;
//     data['np_name'] = this.npName;
//     data['np_phone'] = this.npPhone;
//     data['np_email'] = this.npEmail;
//     data['np_adress'] = this.npAdress;
//     data['np_district'] = this.npDistrict;
//     data['np_province'] = this.npProvince;
//     data['np_lat'] = this.npLat;
//     data['np_long'] = this.npLong;
//     data['ow_id'] = this.owId;
//     return data;
//   }
// }