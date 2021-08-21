import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_finalapp1/model/Connectapi.dart';
import 'dart:convert' as convert;

import 'package:my_finalapp1/widget/custom_back_button.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}
 
class _RegisterPageState extends State<RegisterPage> {
  final _uid = GlobalKey<FormState>();
  final _uuser = TextEditingController();
  final _upass = TextEditingController();
  final _uname = TextEditingController();
  final _ulname = TextEditingController();
  final _upho = TextEditingController();
  final _uemail = TextEditingController();
  final _ugender = TextEditingController();
  final _uage = TextEditingController();
  // final _uimg = TextEditingController();

  void register(Map<String, dynamic> values) async {
    // var url = 'http://192.168.0.8:8888/register';
    String url = '${Connectapi().domain}/register';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65),
        child: AppBar(
          leading: CustomBackButton(
            tapBack: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Theme.of(context).primaryColorDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _uid,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'สมัครสมาชิก',
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(height: 15),
                  frmp1(),
                  SizedBox(height: 10),
                  frmp2(),
                  SizedBox(height: 10),
                  frmp3(),
                  SizedBox(height: 10),
                  frmp4(),
                  SizedBox(height: 10),
                  frmp5(),
                  SizedBox(height: 10),
                  frmp6(),
                  SizedBox(height: 10),
                  frmp7(),
                  SizedBox(height: 10),
                  frmp8(),
                  SizedBox(height: 15),
                  btnSubmit(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget frmp1() {
    return TextFormField(
      controller: _uuser,
      decoration: InputDecoration(
        labelText: 'ชื่อผู้ใช้',
        hintText: 'กรอกชื่อผู้ใช้',
        icon: Icon(Icons.person_search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: (values) {
        if (values.isEmpty) {
          return 'กรุณากรอกชื่อผู้ใช้';
        }
      },
    );
  }

  Widget frmp2() {
    return TextFormField(
      controller: _upass,
      decoration: InputDecoration(
        labelText: 'รหัสผ่าน',
        hintText: 'กรอกรหัสผ่าน',
        icon: Icon(Icons.person_search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: (values) {
        if (values.isEmpty) {
          return 'กรุณากรอกรหัสผ่าน';
        }
      },
    );
  }

  Widget frmp3() {
    return TextFormField(
      controller: _uname,
      decoration: InputDecoration(
        labelText: 'ชื่อ',
        hintText: 'กรอกชื่อ',
        icon: Icon(Icons.person),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: (values) {
        if (values.isEmpty) {
          return 'กรุณากรอกชื่อ';
        }
      },
    );
  }

  Widget frmp4() {
    return TextFormField(
      controller: _ulname,
      decoration: InputDecoration(
        labelText: 'นามสกุล',
        hintText: 'กรอกนามสกุล',
        icon: Icon(Icons.person),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: (values) {
        if (values.isEmpty) {
          return 'กรุณากรอกนามสกุล';
        }
      },
    );
  }

  Widget frmp5() {
    return TextFormField(
      controller: _upho,
      decoration: InputDecoration(
        labelText: 'เบอร์โทรศัพท์',
        hintText: 'กรอกเบอร์โทรศัพท์',
        icon: Icon(Icons.outlet_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: (values) {
        if (values.isEmpty) {
          return 'กรุณาเบอร์โทรศัพท์';
        }
      },
    );
  }

  Widget frmp6() {
    return TextFormField(
      controller: _uemail,
      decoration: InputDecoration(
        labelText: 'อีเมลล์',
        hintText: 'กรอกอีเมลล์',
        icon: Icon(Icons.email_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: (values) {
        if (values.isEmpty) {
          return 'กรุณากรอกอีเมลล์';
        }
      },
    );
  }

  Widget frmp7() {
    return TextFormField(
      controller: _ugender,
      decoration: InputDecoration(
        labelText: 'เพศ',
        hintText: 'กรอกเพศ',
        icon: Icon(Icons.call),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: (values) {
        if (values.isEmpty) {
          return 'กรุณากรอกเพศ';
        }
      },
    );
  }

  Widget frmp8() {
    return TextFormField(
      controller: _uage,
      decoration: InputDecoration(
        labelText: 'อายุ',
        hintText: 'กรอกอายุ',
        icon: Icon(Icons.call),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: (values) {
        if (values.isEmpty) {
          return 'กรุณากรอกอายุ';
        }
      },
    );
  }

  //  Widget frmp8() {
  //   return TextFormField(
  //     controller: _uimg,
  //     decoration: InputDecoration(
  //       labelText: 'รูปภาพ',
  //       hintText: 'รูปภาพ',
  //       icon: Icon(Icons.message_rounded),
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(10.0),
  //       ),
  //     ),
  //     validator: (values) {
  //       if (values.isEmpty) {
  //         return 'รูปภาพ';
  //       }
  //     },
  //   );
  // }

  Widget btnSubmit() {
    return SizedBox(
      width: 100,
      height: 50,
      child: RaisedButton(
        child: Text('Submit'),
        color: Colors.cyanAccent,
        onPressed: () {
          // Navigator.pop(context, '/LoginPage');

          if (_uid.currentState.validate()) {
            Map<String, dynamic> valuse = Map();
            valuse['user_username'] = _uuser.text;
            valuse['user_password'] = _upass.text;
            valuse['user_name'] = _uname.text;
            valuse['user_lastname'] = _ulname.text;
            valuse['user_phone'] = _upho .text;
            valuse['user_email'] = _uemail.text;
            valuse['user_gender'] = _ugender.text;
            valuse['user_age'] = _uage.text;

            print(_uuser.text);
            print(_upass.text);
            print(_uname.text);
            print(_ulname.text);
            print(_upho.text);
            print(_uemail.text);
            print(_ugender.text);
            print(_uage.text);

            register(valuse);
          }
        },
      ),
    );
  }
}