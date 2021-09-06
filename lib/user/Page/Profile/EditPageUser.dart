import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_finalapp1/model/Connectapi.dart';
import 'package:my_finalapp1/widget/colors.dart';
import 'package:my_finalapp1/widget/custom_back_button.dart';
import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';

class EditPageUser extends StatefulWidget {
  @override
  _EditPageUserState createState() => _EditPageUserState();
}

class _EditPageUserState extends State<EditPageUser> {
  final _userid = GlobalKey<FormState>();
  TextEditingController user_username;
  TextEditingController user_password;
  TextEditingController user_name;
  TextEditingController user_lname;
  TextEditingController user_phone;
  TextEditingController user_email;
  TextEditingController user_gender;
  TextEditingController user_bday;

  Map<String, dynamic> _rec_member;

  var uId;
  var token;

  Future getUpdate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    uId = prefs.getInt('id');
    print('uId = $uId');
    print('token = $token');
  }

  Future<void> _updateMember(Map<String, dynamic> values) async {
    var url = '${Connectapi().domain}/updateuser/$uId';
    print(uId);
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
    uId = _rec_member['id'];
    user_username = TextEditingController(text: _rec_member['user_username']);
    user_password = TextEditingController(text: _rec_member['user_password']);
    user_name = TextEditingController(text: _rec_member['user_name']);
    user_lname = TextEditingController(text: _rec_member['user_lastname']);
    user_phone = TextEditingController(text: _rec_member['user_phone']);
    user_email = TextEditingController(text: _rec_member['user_email']);
    user_gender = TextEditingController(text: _rec_member['user_gender']);
    user_bday = TextEditingController(text: _rec_member['user_bday']);
  }

  bool isObscurePassword = true;

  @override
  Widget build(BuildContext context) {
    getInfo();
    getUpdate();
    return Scaffold(
      appBar: AppBar(
        title: Text('แก้ไขข้อมูล'),
        leading: CustomBackButton(
          tapBack: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _userid,
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
                SizedBox(height: 50),
                btnSummit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget test(bool readOnly, bool isPasswordTextField) {
    return TextFormField(
      readOnly: readOnly ? readOnly : false,
      style: TextStyle(color: Colors.white, fontSize: 16),
      controller: user_password, //? << ดึงข้อมูลมาแก้ไข
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
                color: tTextColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        TextField(
          readOnly: readOnly ? readOnly : false,
          style: TextStyle(
            color: tTextGColor,
            fontSize: 16,
          ),
          controller: user_username, //? << ดึงข้อมูลมาแก้ไข
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
              color: tTextGColor,
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
                color: tTextColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        TextField(
          readOnly: readOnly ? readOnly : false,
          style: TextStyle(
            color: tTextGColor,
            fontSize: 16,
          ),
          controller: user_password, //? << ดึงข้อมูลมาแก้ไข
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
              color: tTextGColor,
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
                color: tTextColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        TextField(
          readOnly: readOnly ? readOnly : false,
          style: TextStyle(
            color: tTextColor,
            fontSize: 16,
          ),
          controller: user_name, //? << ดึงข้อมูลมาแก้ไข
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
              color: tTextGColor,
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
                color: tTextColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        TextField(
          readOnly: readOnly ? readOnly : false,
          style: TextStyle(
            color: tTextColor,
            fontSize: 16,
          ),
          controller: user_lname, //? << ดึงข้อมูลมาแก้ไข
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
              color: tTextGColor,
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
                color: tTextColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        TextField(
          readOnly: readOnly ? readOnly : false,
          style: TextStyle(
            color: tTextColor,
            fontSize: 16,
          ),
          controller: user_phone, //? << ดึงข้อมูลมาแก้ไข
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
              color: tTextGColor,
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
                color: tTextColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        TextField(
          readOnly: readOnly ? readOnly : false,
          style: TextStyle(
            color: tTextColor,
            fontSize: 16,
          ),
          controller: user_email, //? << ดึงข้อมูลมาแก้ไข
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
              color: tTextGColor,
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
                color: tTextColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        TextField(
          readOnly: readOnly ? readOnly : false,
          style: TextStyle(
            color: tTextGColor,
            fontSize: 16,
          ),
          controller: user_gender, //? << ดึงข้อมูลมาแก้ไข
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
              color: tTextGColor,
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
                color: tTextColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        TextField(
          readOnly: readOnly ? readOnly : false,
          style: TextStyle(
            color: tTextGColor,
            fontSize: 16,
          ),
          controller: user_bday, //? << ดึงข้อมูลมาแก้ไข
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
              color: tTextGColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget btnSummit() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          primary: tPimaryColor,
        ),
        child: Text(
          'บันทึก',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        onPressed: () {
          Map<String, dynamic> valuse = Map();
          valuse['user_id'] = uId;
          //valuse['u_user'] = _user.text;
          //valuse['u_pass'] = _password.text;
          valuse['user_name'] = user_name.text;
          valuse['user_lastname'] = user_lname.text;
          valuse['user_phone'] = user_phone.text;
          valuse['user_email'] = user_email.text;

          print(user_name.text);
          print(user_lname.text);
          print(user_phone.text);
          print(user_email.text);

          _updateMember(valuse);
          Navigator.pop(context, '/editdataUser');
          // Navigator.pushReplacement(context,
          //     MaterialPageRoute(builder: (BuildContext context) => EditPageUser()));
        },
      ),
    );
  }
}
