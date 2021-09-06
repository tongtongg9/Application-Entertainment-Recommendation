class ReviewListLimitmodel {
  bool ok;
  List<Revlimit> revlimit;

  ReviewListLimitmodel({this.ok, this.revlimit});

  ReviewListLimitmodel.fromJson(Map<String, dynamic> json) {
    ok = json['ok'];
    if (json['revlimit'] != null) {
      revlimit = new List<Revlimit>();
      json['revlimit'].forEach((v) {
        revlimit.add(new Revlimit.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ok'] = this.ok;
    if (this.revlimit != null) {
      data['revlimit'] = this.revlimit.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Revlimit {
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

  Revlimit(
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
      this.userImg});

  Revlimit.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
