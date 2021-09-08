import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_finalapp1/model/Connectapi.dart';
import 'dart:convert' as convert;

import 'package:my_finalapp1/widget/colors.dart';
import 'package:my_finalapp1/widget/custom_back_button.dart';

class RegisterPageOw extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPageOw> {
  final _oid = GlobalKey<FormState>();
  final _ouser = TextEditingController();
  final _opass = TextEditingController();
  final _oname = TextEditingController();
  final _olname = TextEditingController();
  final _opho = TextEditingController();
  final _oemail = TextEditingController();

  String _choseGender;
  DateTime _date;

  void register(Map<String, dynamic> values) async {
    // var url = 'http://192.168.0.8:8888/register';
    String url = '${Connectapi().domain}/registerow';
    var response = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: convert.jsonEncode(values));

    if (response.statusCode == 200) {
      print('Register Success');

      // Navigator.pop(context, true);
    } else {
      print('Register not Success!!');
      print(response.body);
    }
  }

  bool isObscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(
          tapBack: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _oid,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "สมัครสมาชิก",
                    style: TextStyle(
                      color: tTextColor,
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20),
                  regisForm(
                    _ouser,
                    'ชื่อผู้ใช้',
                    'ชื่อผู้ใช้',
                    'กรุณากรอกชื่อผู้ใช้',
                    'assets/icons/user.png',
                    false,
                  ),
                  SizedBox(height: 10),
                  regisForm(
                    _opass,
                    'รหัสผ่าน',
                    'รหัสผ่าน',
                    'กรุณากรอกรหัสผ่าน',
                    'assets/icons/user.png',
                    true,
                  ),
                  SizedBox(height: 10),
                  regisForm(
                    _oname,
                    'ชื่อ',
                    'ชื่อ',
                    'กรุณากรอกชื่อ',
                    'assets/icons/user.png',
                    false,
                  ),
                  SizedBox(height: 10),
                  regisForm(
                    _olname,
                    'นามสกุล',
                    'นามสกุล',
                    'กรุณากรอกนามสกุล',
                    'assets/icons/user.png',
                    false,
                  ),
                  SizedBox(height: 10),
                  regisForm(
                    _opho,
                    'เบอร์โทรศัพท์',
                    'เบอร์โทรศัพท์',
                    'กรุณากรอกเบอร์โทรศัพท์',
                    'assets/icons/user.png',
                    false,
                  ),
                  SizedBox(height: 10),
                  regisForm(
                    _oemail,
                    'E-mail',
                    'E-mail',
                    'กรุณากรอก E-mail',
                    'assets/icons/user.png',
                    false,
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      genderForm(),
                      dateForm(),
                    ],
                  ),
                  SizedBox(height: 50),
                  btnSubmit(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget regisForm(
    final TextEditingController _controller,
    final String _hText,
    final String _hintText,
    final String _validator,
    final String _icon,
    final bool isPasswordTextField,
  ) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              _hText,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: tTextColor,
              ),
            ),
            Text(
              '*',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: tErrorColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        TextFormField(
          controller: _controller,
          obscureText: isPasswordTextField ? isObscurePassword : false,
          validator: (values) {
            if (values.isEmpty) {
              return _validator;
            }
          },
          style: TextStyle(
            color: tTextColor,
            fontSize: 16,
          ),
          cursorColor: tPimaryColor,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: tBGDeepColor,
            hintText: _hintText,
            hintStyle: TextStyle(
              fontSize: 16,
              color: tGreyColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget genderForm() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 120),
          child: Row(
            children: [
              Text(
                'เพศ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: tTextColor,
                ),
              ),
              Text(
                '*',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: tErrorColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
        DropdownButtonHideUnderline(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.35,
            height: 65,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: tBGDeepColor,
              border: Border.all(
                color: tBGDeepColor,
              ),
            ),
            child: DropdownButton<String>(
              value: _choseGender,
              items: <String>[
                'ชาย',
                'หญิง',
                'อื่นๆ',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              style: TextStyle(
                fontFamily: 'IBMPlexSansThai',
                color: tTextColor,
                fontSize: 16,
              ),
              hint: Text(
                "เลือกเพศ",
                style: TextStyle(
                  fontSize: 16,
                  color: tTextGColor,
                ),
              ),
              // dropdownColor: Theme.of(context).backgroundColor,
              onChanged: (String value) {
                setState(() {
                  _choseGender = value;
                  print(value);
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget dateForm() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 165),
          child: Row(
            children: [
              Text(
                'วันเกิด',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: tTextColor,
                ),
              ),
              Text(
                '*',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: tErrorColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
        Container(
          width: MediaQuery.of(context).size.width * 0.52,
          height: 65,
          child: DateTimeFormField(
            onDateSelected: (DateTime value) {
              setState(() {
                _date = value;
              });
              print(value);
            },
            dateTextStyle: TextStyle(
              color: tGreyColor,
              fontSize: 16,
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: tBGDeepColor,
              hintText: 'เลือกวันเกิด',
              hintStyle: TextStyle(
                fontSize: 16,
                color: tTextGColor,
              ),
            ),
            mode: DateTimeFieldPickerMode.date,
          ),
        ),
      ],
    );
  }

  Widget btnSubmit() {
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
          'ยืนยัน',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        onPressed: () {
          if (_oid.currentState.validate()) {
            Map<String, dynamic> valuse = Map();

            valuse['ow_username'] = _ouser.text;
            valuse['ow_password'] = _opass.text;
            valuse['ow_name'] = _oname.text;
            valuse['ow_lastname'] = _olname.text;
            valuse['ow_phone'] = _opho.text;
            valuse['ow_email'] = _oemail.text;
            valuse['ow_gender'] = _choseGender.toString();
            valuse['ow_bday'] = _date.toString();

            print(valuse);

            register(valuse);

            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
