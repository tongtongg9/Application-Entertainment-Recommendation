class DataUser {
  bool ok;
  Infouser infouser;

  DataUser({this.ok, this.infouser});

  DataUser.fromJson(Map<String, dynamic> json) {
    ok = json['ok'];
    infouser = json['infouser'] != null
        ? new Infouser.fromJson(json['infouser'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ok'] = this.ok;
    if (this.infouser != null) {
      data['infouser'] = this.infouser.toJson();
    }
    return data;
  }
}

class Infouser {
  int userId;
  String userUsername;
  String userPassword;
  String userName;
  String userLastname;
  String userPhone;
  String userEmail;
  String userGender;
  String userBday;
  int idImgUser;
  String userImg;

  Infouser(
      {this.userId,
      this.userUsername,
      this.userPassword,
      this.userName,
      this.userLastname,
      this.userPhone,
      this.userEmail,
      this.userGender,
      this.userBday,
      this.idImgUser,
      this.userImg});

  Infouser.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userUsername = json['user_username'];
    userPassword = json['user_password'];
    userName = json['user_name'];
    userLastname = json['user_lastname'];
    userPhone = json['user_phone'];
    userEmail = json['user_email'];
    userGender = json['user_gender'];
    userBday = json['user_bday'];
    idImgUser = json['id_img_user'];
    userImg = json['user_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['user_username'] = this.userUsername;
    data['user_password'] = this.userPassword;
    data['user_name'] = this.userName;
    data['user_lastname'] = this.userLastname;
    data['user_phone'] = this.userPhone;
    data['user_email'] = this.userEmail;
    data['user_gender'] = this.userGender;
    data['user_bday'] = this.userBday;
    data['id_img_user'] = this.idImgUser;
    data['user_img'] = this.userImg;
    return data;
  }
}
