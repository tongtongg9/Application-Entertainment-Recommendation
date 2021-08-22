import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_finalapp1/model/Connectapi.dart';
import 'package:my_finalapp1/widget/colors.dart';
import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';

class EditPageOw extends StatefulWidget {
  @override
  _EditPageOwState createState() => _EditPageOwState();
}

class _EditPageOwState extends State<EditPageOw> {
  final _owid = GlobalKey<FormState>();
  TextEditingController ow_username;
  TextEditingController ow_password;
  TextEditingController ow_name;
  TextEditingController ow_lname;
  TextEditingController ow_phone;
  TextEditingController ow_email;
  TextEditingController ow_gender;
  TextEditingController ow_bday;

  Map<String, dynamic> _rec_member;

  var owId;
  var token;

  Future getUpdate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    owId = prefs.getInt('id');
    print('owId = $owId');
    print('token = $token');
  }

  Future<void> _updateMember(Map<String, dynamic> values) async {
    var url = '${Connectapi().domain}/updateowner/$owId';
    print(owId);
    var response = await http.put(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: convert.jsonEncode(values));
    print(values);
    if (response.statusCode == 200) {
      print('Update Success!');
      // Navigator.pop(context, true);
    } else {
      print('Update Fail!!');
    }
  }

  Future getInfo() {
    _rec_member = ModalRoute.of(context).settings.arguments;
    owId = _rec_member['id'];
    ow_username = TextEditingController(text: _rec_member['ow_username']);
    ow_password = TextEditingController(text: _rec_member['ow_password']);
    ow_name = TextEditingController(text: _rec_member['ow_name']);
    ow_lname = TextEditingController(text: _rec_member['ow_lastname']);
    ow_phone = TextEditingController(text: _rec_member['ow_phone']);
    ow_email = TextEditingController(text: _rec_member['ow_email']);
    ow_gender = TextEditingController(text: _rec_member['ow_gender']);
    ow_bday = TextEditingController(text: _rec_member['ow_bday']);
  }

  bool isObscurePassword = true;

  @override
  Widget build(BuildContext context) {
    getInfo();
    getUpdate();
    return Scaffold(
      appBar: AppBar(
        title: Text('แก้ไขข้อมูล'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.check,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: save,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _owid,
          child: Container(
            padding:
                EdgeInsets.fromLTRB(20, 0, 20, 20), // todo ระยะห่างจากขอบจอ !!
            child: Column(
              children: [
                SizedBox(height: 15),
                // test(true, false),
                frmUsername(true),
                SizedBox(height: 10),
                frmPassword(true, true),
                SizedBox(height: 10),
                frmName(false),
                SizedBox(height: 10),
                frmLastname(false),
                SizedBox(height: 10),
                frmPhone(false),
                SizedBox(height: 10),
                frmEmail(false),
                SizedBox(height: 10),
                frmGender(true),
                SizedBox(height: 10),
                frmBday(true),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget frmUsername(bool readOnly) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'ชื่อผู้ใช้',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        TextField(
          readOnly: readOnly ? readOnly : false,
          style: TextStyle(color: Colors.white, fontSize: 16),
          controller: ow_username, //? << ดึงข้อมูลมาแก้ไข
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: tBGDeepColor,
            focusColor: tGreyColor,
            hintStyle: TextStyle(
              fontSize: 16,
              color: Colors.white54,
            ),
          ),
        ),
      ],
    );
  }

  Widget frmPassword(bool readOnly, bool isPasswordTextField) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'รหัสผ่าน',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        TextField(
          readOnly: readOnly ? readOnly : false,
          style: TextStyle(color: Colors.white, fontSize: 16),
          controller: ow_password, //? << ดึงข้อมูลมาแก้ไข
          obscureText: isPasswordTextField ? isObscurePassword : false,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: tBGDeepColor,
            focusColor: tGreyColor,
            hintStyle: TextStyle(
              fontSize: 16,
              color: Colors.white54,
            ),
          ),
        ),
      ],
    );
  }

  Widget frmName(bool readOnly) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'ชื่อ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        TextField(
          readOnly: readOnly ? readOnly : false,
          style: TextStyle(color: Colors.white, fontSize: 16),
          controller: ow_name, //? << ดึงข้อมูลมาแก้ไข
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: tBGDeepColor,
            focusColor: tGreyColor,
            hintStyle: TextStyle(
              fontSize: 16,
              color: Colors.white54,
            ),
          ),
        ),
      ],
    );
  }

  Widget frmLastname(bool readOnly) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'นามสกุล',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        TextField(
          readOnly: readOnly ? readOnly : false,
          style: TextStyle(color: Colors.white, fontSize: 16),
          controller: ow_lname, //? << ดึงข้อมูลมาแก้ไข
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: tBGDeepColor,
            focusColor: tGreyColor,
            hintStyle: TextStyle(
              fontSize: 16,
              color: Colors.white54,
            ),
          ),
        ),
      ],
    );
  }

  Widget frmPhone(bool readOnly) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'เบอร์โทรศัพท์',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        TextField(
          readOnly: readOnly ? readOnly : false,
          style: TextStyle(color: Colors.white, fontSize: 16),
          controller: ow_phone, //? << ดึงข้อมูลมาแก้ไข
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: tBGDeepColor,
            focusColor: tGreyColor,
            hintStyle: TextStyle(
              fontSize: 16,
              color: Colors.white54,
            ),
          ),
        ),
      ],
    );
  }

  Widget frmEmail(bool readOnly) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Email',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        TextField(
          readOnly: readOnly ? readOnly : false,
          style: TextStyle(color: Colors.white, fontSize: 16),
          controller: ow_email, //? << ดึงข้อมูลมาแก้ไข
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: tBGDeepColor,
            focusColor: tGreyColor,
            hintStyle: TextStyle(
              fontSize: 16,
              color: Colors.white54,
            ),
          ),
        ),
      ],
    );
  }

  Widget frmGender(bool readOnly) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'เพศ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        TextField(
          readOnly: readOnly ? readOnly : false,
          style: TextStyle(color: Colors.white, fontSize: 16),
          controller: ow_gender, //? << ดึงข้อมูลมาแก้ไข
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: tBGDeepColor,
            focusColor: tGreyColor,
            hintStyle: TextStyle(
              fontSize: 16,
              color: Colors.white54,
            ),
          ),
        ),
      ],
    );
  }

  Widget frmBday(bool readOnly) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'วันเกิด',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        TextField(
          readOnly: readOnly ? readOnly : false,
          style: TextStyle(color: Colors.white, fontSize: 16),
          controller: ow_bday, //? << ดึงข้อมูลมาแก้ไข
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: tBGDeepColor,
            focusColor: tGreyColor,
            hintStyle: TextStyle(
              fontSize: 16,
              color: Colors.white54,
            ),
          ),
        ),
      ],
    );
  }

// ? Fn save bottom
  void save() {
    Map<String, dynamic> valuse = Map();
    valuse['ow_id'] = owId;
    //valuse['u_ow'] = _ow.text;
    //valuse['u_pass'] = _password.text;
    valuse['ow_name'] = ow_name.text;
    valuse['ow_lastname'] = ow_lname.text;
    valuse['ow_phone'] = ow_phone.text;
    valuse['ow_email'] = ow_email.text;

    print(ow_name.text);
    print(ow_lname.text);
    print(ow_phone.text);
    print(ow_email.text);

    _updateMember(valuse);
    Navigator.pop(context, '/oweditdata');
    // Navigator.pushReplacement(context,
    //     MaterialPageRoute(builder: (BuildContext context) => EditPageUser()));
  }
}
