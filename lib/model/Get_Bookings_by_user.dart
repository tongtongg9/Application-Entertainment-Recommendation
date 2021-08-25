//?-------------------
//? get Bookings by user
class Get_Bookings_by_user {
  bool ok;
  List<Rsbookbyuser> rsbookbyuser;

  Get_Bookings_by_user({this.ok, this.rsbookbyuser});

  Get_Bookings_by_user.fromJson(Map<String, dynamic> json) {
    ok = json['ok'];
    if (json['rsbookbyuser'] != null) {
      rsbookbyuser = new List<Rsbookbyuser>();
      json['rsbookbyuser'].forEach((v) {
        rsbookbyuser.add(new Rsbookbyuser.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ok'] = this.ok;
    if (this.rsbookbyuser != null) {
      data['rsbookbyuser'] = this.rsbookbyuser.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rsbookbyuser {
  int bkId;
  int npId;
  int userId;
  int bkSeat;
  String bkDetail;
  String bkStatus;
  String bkBookingTime;
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

  Rsbookbyuser(
      {this.bkId,
      this.npId,
      this.userId,
      this.bkSeat,
      this.bkDetail,
      this.bkStatus,
      this.bkBookingTime,
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

  Rsbookbyuser.fromJson(Map<String, dynamic> json) {
    bkId = json['bk_id'];
    npId = json['np_id'];
    userId = json['user_id'];
    bkSeat = json['bk_seat'];
    bkDetail = json['bk_detail'];
    bkStatus = json['bk_status'];
    bkBookingTime = json['bk_booking_time'];
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
    data['bk_id'] = this.bkId;
    data['np_id'] = this.npId;
    data['user_id'] = this.userId;
    data['bk_seat'] = this.bkSeat;
    data['bk_detail'] = this.bkDetail;
    data['bk_status'] = this.bkStatus;
    data['bk_booking_time'] = this.bkBookingTime;
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
