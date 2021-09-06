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
