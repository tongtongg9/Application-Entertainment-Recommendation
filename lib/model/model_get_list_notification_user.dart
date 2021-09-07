class BkNotificationforUser {
  bool ok;
  List<Rsnotibookbyuser> rsnotibookbyuser;

  BkNotificationforUser({this.ok, this.rsnotibookbyuser});

  BkNotificationforUser.fromJson(Map<String, dynamic> json) {
    ok = json['ok'];
    if (json['rsnotibookbyuser'] != null) {
      rsnotibookbyuser = new List<Rsnotibookbyuser>();
      json['rsnotibookbyuser'].forEach((v) {
        rsnotibookbyuser.add(new Rsnotibookbyuser.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ok'] = this.ok;
    if (this.rsnotibookbyuser != null) {
      data['rsnotibookbyuser'] =
          this.rsnotibookbyuser.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rsnotibookbyuser {
  int bkId;
  int npId;
  int userId;
  int bkSeat;
  String bkDetail;
  String bkCheckinDate;
  String bkStatus;
  String bkBookingTime;
  String userUsername;
  String userPassword;
  String userName;
  String userLastname;
  String userPhone;
  String userEmail;
  String userGender;
  String userBday;
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

  Rsnotibookbyuser(
      {this.bkId,
      this.npId,
      this.userId,
      this.bkSeat,
      this.bkDetail,
      this.bkCheckinDate,
      this.bkStatus,
      this.bkBookingTime,
      this.userUsername,
      this.userPassword,
      this.userName,
      this.userLastname,
      this.userPhone,
      this.userEmail,
      this.userGender,
      this.userBday,
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

  Rsnotibookbyuser.fromJson(Map<String, dynamic> json) {
    bkId = json['bk_id'];
    npId = json['np_id'];
    userId = json['user_id'];
    bkSeat = json['bk_seat'];
    bkDetail = json['bk_detail'];
    bkCheckinDate = json['bk_checkin_date'];
    bkStatus = json['bk_status'];
    bkBookingTime = json['bk_booking_time'];
    userUsername = json['user_username'];
    userPassword = json['user_password'];
    userName = json['user_name'];
    userLastname = json['user_lastname'];
    userPhone = json['user_phone'];
    userEmail = json['user_email'];
    userGender = json['user_gender'];
    userBday = json['user_bday'];
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
    data['bk_id'] = this.bkId;
    data['np_id'] = this.npId;
    data['user_id'] = this.userId;
    data['bk_seat'] = this.bkSeat;
    data['bk_detail'] = this.bkDetail;
    data['bk_checkin_date'] = this.bkCheckinDate;
    data['bk_status'] = this.bkStatus;
    data['bk_booking_time'] = this.bkBookingTime;
    data['user_username'] = this.userUsername;
    data['user_password'] = this.userPassword;
    data['user_name'] = this.userName;
    data['user_lastname'] = this.userLastname;
    data['user_phone'] = this.userPhone;
    data['user_email'] = this.userEmail;
    data['user_gender'] = this.userGender;
    data['user_bday'] = this.userBday;
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
