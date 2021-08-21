//? User
class UserMember {
  bool ok;
  UserInfo info;

  UserMember({this.ok, this.info});

  UserMember.fromJson(Map<String, dynamic> json) {
    ok = json['ok'];
    info = json['info'] != null ? new UserInfo.fromJson(json['info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ok'] = this.ok;
    if (this.info != null) {
      data['info'] = this.info.toJson();
    }
    return data;
  }
}

class UserInfo {
  int userId;
  String userUsername;
  String userPassword;
  String userName;
  String userLastname;
  String userPhone;
  String userEmail;
  String userGender;
  String userBday;
  String userImg;

  UserInfo(
      {this.userId,
      this.userUsername,
      this.userPassword,
      this.userName,
      this.userLastname,
      this.userPhone,
      this.userEmail,
      this.userGender,
      this.userBday,
      this.userImg});

  UserInfo.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userUsername = json['user_username'];
    userPassword = json['user_password'];
    userName = json['user_name'];
    userLastname = json['user_lastname'];
    userPhone = json['user_phone'];
    userEmail = json['user_email'];
    userGender = json['user_gender'];
    userBday = json['user_bday'];
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
    data['user_img'] = this.userImg;
    return data;
  }
}

//?-------------------
//? Owner
class OwnerMember {
  bool ok;
  OwnerInfo info;

  OwnerMember({this.ok, this.info});

  OwnerMember.fromJson(Map<String, dynamic> json) {
    ok = json['ok'];
    info = json['info'] != null ? new OwnerInfo.fromJson(json['info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ok'] = this.ok;
    if (this.info != null) {
      data['info'] = this.info.toJson();
    }
    return data;
  }
}

class OwnerInfo {
  int owId;
  String owUsername;
  String owPassword;
  String owName;
  String owLastname;
  String owPhone;
  String owEmail;
  String owGender;
  String owBday;

  OwnerInfo(
      {this.owId,
      this.owUsername,
      this.owPassword,
      this.owName,
      this.owLastname,
      this.owPhone,
      this.owEmail,
      this.owGender,
      this.owBday});

  OwnerInfo.fromJson(Map<String, dynamic> json) {
    owId = json['ow_id'];
    owUsername = json['ow_username'];
    owPassword = json['ow_password'];
    owName = json['ow_name'];
    owLastname = json['ow_lastname'];
    owPhone = json['ow_phone'];
    owEmail = json['ow_email'];
    owGender = json['ow_gender'];
    owBday = json['ow_bday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ow_id'] = this.owId;
    data['ow_username'] = this.owUsername;
    data['ow_password'] = this.owPassword;
    data['ow_name'] = this.owName;
    data['ow_lastname'] = this.owLastname;
    data['ow_phone'] = this.owPhone;
    data['ow_email'] = this.owEmail;
    data['ow_gender'] = this.owGender;
    data['ow_bday'] = this.owBday;
    return data;
  }
}

//?-------------------
//? np forOwner
class Np_by_Owner {
  bool ok;
  List<Rows> rows;

  Np_by_Owner({this.ok, this.rows});

  Np_by_Owner.fromJson(Map<String, dynamic> json) {
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

//?-------------------
//? ReviewList
class ReviewListmodel {
  bool ok;
  List<Rowsrev> rowsrev;

  ReviewListmodel({this.ok, this.rowsrev});

  ReviewListmodel.fromJson(Map<String, dynamic> json) {
    ok = json['ok'];
    if (json['rowsrev'] != null) {
      rowsrev = new List<Rowsrev>();
      json['rowsrev'].forEach((v) {
        rowsrev.add(new Rowsrev.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ok'] = this.ok;
    if (this.rowsrev != null) {
      data['rowsrev'] = this.rowsrev.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rowsrev {
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
  String userImg;

  Rowsrev(
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
      this.userImg});

  Rowsrev.fromJson(Map<String, dynamic> json) {
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
    data['user_img'] = this.userImg;
    return data;
  }
}

//?-------------------
//? ReviewList limit 3
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
    data['user_img'] = this.userImg;
    return data;
  }
}

//?-------------------
//? Feed Reviews
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
  String userImg;
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
      this.npLong});

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
    return data;
  }
}
