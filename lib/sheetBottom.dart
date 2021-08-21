// import 'package:js/js.dart';
import 'package:path/path.dart' as Path;
import 'package:flutter/material.dart';
import 'package:my_finalapp1/user/bottom_nav_bar.dart';
import 'package:my_finalapp1/model/LoginModel.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SheetBottom extends StatefulWidget {
  // SheetBottom({Key? key}) : super(key: key);

  @override
  _SheetBottomState createState() => _SheetBottomState();
}

TextEditingController _fusername = TextEditingController();
TextEditingController _fpassword = TextEditingController();
final _formkey = GlobalKey<FormState>();

LoginModel login = LoginModel();

// ? ดึง token เพื่อ Login
Future doLogin() async {
  if (_formkey.currentState.validate()) {
    try {
      var rs = await login.doLogin(_fusername.text, _fpassword.text);
      print(_fusername.text);
      print(_fpassword.text);
      if (rs.statusCode == 200) {
        print(rs.body);
        var jsonRes = json.decode(rs.body);

        if (jsonRes['ok']) {
          String token = jsonRes['token'];
          var id = jsonRes['id'];
          print(token);
          print(id);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);
          await prefs.setInt('id', id);

          //re
          // Navigator.of(context).pushReplacement(
          //     MaterialPageRoute(builder: (context) => HomePage()));
        } else {
          print(jsonRes['error']);
        }
      } else {
        print('connect error');
      }
    } catch (error) {
      print(error);
    }
  }
}

class _SheetBottomState extends State<SheetBottom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _btnMLogin(),
            SizedBox(height: 20),
            _btnMRegis(),
          ],
        ),
      )),
    );
  }

  Widget _btnMLogin() {
    return Padding(
      padding: EdgeInsets.all(0),
      child: SizedBox(
        width: double.infinity,
        // height: 50,
        child: RaisedButton(
          child: Text(
            'เข้าสู่ระบบ',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
          ),
          color: Theme.of(this.context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onPressed: () {
            // Navigator.pushNamed(context, '/uloginpage');
            showModalBottomSheet(
              context: this.context,
              isScrollControlled: true,
              builder: (context) => SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: _newLoginUser(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _btnMRegis() {
    return Padding(
      padding: EdgeInsets.only(right: 0),
      child: SizedBox(
        width: double.infinity,
        // height: 50,
        child: RaisedButton(
          child: Text(
            'สมัครสมาชิก',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          color: Theme.of(this.context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onPressed: () {
            Navigator.pushNamed(this.context, '/uregisterpage');
          },
        ),
      ),
    );
  }

  Widget _newLoginUser() {
    return Form(
      key: _formkey,
      child: Container(
        width: double.infinity,
        height: 700,
        decoration: BoxDecoration(
          color: Theme.of(this.context).backgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              usernameField(),
              SizedBox(height: 20),
              passwordField(),
              SizedBox(height: 50),
              btnLogin(),
            ],
          ),
        ),
      ),
    );
  }

  Widget usernameField() {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return 'กรุณากรอกชื่อผู้ใช้';
        }
      },
      controller: _fusername,
      style: TextStyle(
        color: Theme.of(this.context).primaryColor,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Theme.of(this.context).scaffoldBackgroundColor,
        hintText: 'ชื่อผู้ใช้',
        focusColor: Theme.of(this.context).primaryColor,
        hintStyle: TextStyle(
          fontSize: 18,
          color: Theme.of(this.context).primaryColor,
        ),
        icon: ImageIcon(
          new AssetImage('assets/icons/user.png'),
          color: Theme.of(this.context).primaryColor,
          // size: 30,
        ),
      ),
    );
  }

  Widget passwordField() {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return 'กรุณากรอกรหัสผ่าน';
        }
      },
      controller: _fpassword,
      obscureText: true,
      style: TextStyle(
        color: Theme.of(this.context).primaryColor,
        fontSize: 18,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Theme.of(this.context).scaffoldBackgroundColor,
        hintText: 'รหัสผ่าน',
        focusColor: Theme.of(this.context).primaryColor,
        hintStyle: TextStyle(
          fontSize: 18,
          color: Theme.of(this.context).primaryColor,
        ),
        icon: ImageIcon(
          new AssetImage('assets/icons/lock.png'),
          color: Theme.of(this.context).primaryColor,
          // size: 30,
        ),
      ),
    );
  }

  Widget btnLogin() {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        color: Theme.of(this.context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            'เข้าสู่ระบบ',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        onPressed: () {
          doLogin();
        },
      ),
    );
  }
}
