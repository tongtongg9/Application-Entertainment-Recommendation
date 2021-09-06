class ShowFeedUser {
  bool ok;
  List<Showfeed> showfeed;

  ShowFeedUser({this.ok, this.showfeed});

  ShowFeedUser.fromJson(Map<String, dynamic> json) {
    ok = json['ok'];
    if (json['showfeed'] != null) {
      showfeed = new List<Showfeed>();
      json['showfeed'].forEach((v) {
        showfeed.add(new Showfeed.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ok'] = this.ok;
    if (this.showfeed != null) {
      data['showfeed'] = this.showfeed.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Showfeed {
  int revId;
  int userId;
  int npId;
  String revTopic;
  String revDetail;
  String revTime;
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

  Showfeed(
      {this.revId,
      this.userId,
      this.npId,
      this.revTopic,
      this.revDetail,
      this.revTime,
      this.userUsername,
      this.userPassword,
      this.userName,
      this.userLastname,
      this.userPhone,
      this.userEmail,
      this.userGender,
      this.userBday,
      this.idImgUser,
      this.userImg,
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

  Showfeed.fromJson(Map<String, dynamic> json) {
    revId = json['rev_id'];
    userId = json['user_id'];
    npId = json['np_id'];
    revTopic = json['rev_topic'];
    revDetail = json['rev_detail'];
    revTime = json['rev_time'];
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
    data['rev_id'] = this.revId;
    data['user_id'] = this.userId;
    data['np_id'] = this.npId;
    data['rev_topic'] = this.revTopic;
    data['rev_detail'] = this.revDetail;
    data['rev_time'] = this.revTime;
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
