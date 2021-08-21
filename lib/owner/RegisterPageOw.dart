import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_finalapp1/model/Connectapi.dart';
import 'dart:convert' as convert;

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
  final _ogender = TextEditingController();
  final _oage = TextEditingController();
  // final _uimg = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('สมัครสมาชิก'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _oid,
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
      controller: _ouser,
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
      controller: _opass,
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
      controller: _oname,
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
      controller: _olname,
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
      controller: _opho,
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
      controller: _oemail,
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
      controller: _ogender,
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
      controller: _oage,
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

          if (_oid.currentState.validate()) {
            Map<String, dynamic> valuse = Map();
            valuse['ow_username'] = _ouser.text;
            valuse['ow_password'] = _opass.text;
            valuse['ow_name'] = _oname.text;
            valuse['ow_lastname'] = _olname.text;
            valuse['ow_phone'] = _opho .text;
            valuse['ow_email'] = _oemail.text;
            valuse['ow_gender'] = _ogender.text;
            valuse['ow_bday'] = _oage.text;

            print(_ouser.text);
            print(_opass.text);
            print(_oname.text);
            print(_olname.text);
            print(_opho.text);
            print(_oemail.text);
            print(_ogender.text);
            print(_oage.text);

            register(valuse);
          }
        },
      ),
    );
  }
}