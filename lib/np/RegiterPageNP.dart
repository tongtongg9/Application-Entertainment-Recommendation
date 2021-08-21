import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_finalapp1/model/Connectapi.dart';
import 'dart:convert' as convert;

class RegisterPageNP extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPageNP> {
  final _npid = GlobalKey<FormState>();
  final _npname = TextEditingController();
  final _npphone = TextEditingController();
  final _npemail = TextEditingController();
  final _npadr = TextEditingController();
  final _npdist = TextEditingController();
  final _npprov = TextEditingController();
  final _nplat = TextEditingController();
  final _nplong = TextEditingController();
  // final _uimg = TextEditingController();

  void register(Map<String, dynamic> values) async {
    // var url = 'http://192.168.0.8:8888/register';
    String url = '${Connectapi().domain}/registernip';
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
            key: _npid,
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
      controller: _npname,
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
      controller: _npphone,
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
      controller: _npemail,
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
      controller: _npadr,
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
      controller: _npdist,
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
      controller: _npprov,
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
      controller: _nplat,
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
      controller: _nplong,
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

          if (_npid.currentState.validate()) {
            Map<String, dynamic> valuse = Map();
            valuse['np_name'] = _npname.text;
            valuse['np_phone'] = _npphone.text;
            valuse['np_email'] = _npemail.text;
            valuse['np_adress'] = _npadr.text;
            valuse['np_district'] = _npdist.text;
            valuse['np_province'] = _npprov.text;
            valuse['np_lat'] = _nplat.text;
            valuse['np_long'] = _nplong.text;

            print(_npname.text);
            print(_npphone.text);
            print( _npemail.text);
            print(_npadr.text);
            print(_npdist.text);
            print(_npprov.text);
            print(_nplat.text);
            print(_nplong.text);

            register(valuse);
          }
        },
      ),
    );
  }
}