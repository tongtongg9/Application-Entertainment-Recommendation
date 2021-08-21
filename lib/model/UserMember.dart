// class UserMember {
//   bool ok;
//   Info info;

//   UserMember({this.ok, this.info});

//   UserMember.fromJson(Map<String, dynamic> json) {
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
//   int userId;
//   String userUsername;
//   String userPassword;
//   String userName;
//   String userLastname;
//   String userPhone;
//   String userEmail;
//   String userGender;
//   String userBday;
//   String userImg;

//   Info(
//       {this.userId,
//       this.userUsername,
//       this.userPassword,
//       this.userName,
//       this.userLastname,
//       this.userPhone,
//       this.userEmail,
//       this.userGender,
//       this.userBday,
//       this.userImg});

//   Info.fromJson(Map<String, dynamic> json) {
//     userId = json['user_id'];
//     userUsername = json['user_username'];
//     userPassword = json['user_password'];
//     userName = json['user_name'];
//     userLastname = json['user_lastname'];
//     userPhone = json['user_phone'];
//     userEmail = json['user_email'];
//     userGender = json['user_gender'];
//     userBday = json['user_bday'];
//     userImg = json['user_img'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['user_id'] = this.userId;
//     data['user_username'] = this.userUsername;
//     data['user_password'] = this.userPassword;
//     data['user_name'] = this.userName;
//     data['user_lastname'] = this.userLastname;
//     data['user_phone'] = this.userPhone;
//     data['user_email'] = this.userEmail;
//     data['user_gender'] = this.userGender;
//     data['user_bday'] = this.userBday;
//     data['user_img'] = this.userImg;
//     return data;
//   }
// }