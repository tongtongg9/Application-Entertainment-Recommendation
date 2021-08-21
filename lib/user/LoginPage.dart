import 'package:flutter/material.dart';
import 'package:my_finalapp1/model/LoginModel.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'bottom_nav_bar.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => BottomNavBar()));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(65),
      //   child: AppBar(
      //     backgroundColor: Theme.of(context).primaryColorDark,
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
      //     ),
      //   ),
      // ),
      appBar: AppBar(
        title: Text("เข้าสู่ระบบ"),
      ),
      body: Center(
        // child: Center(
        child: Form(
          key: _formkey,
          child: Container(
            // padding: EdgeInsets.fromLTRB(0, 250, 0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _username(),
                SizedBox(height: 20),
                _password(),
                SizedBox(height: 20),
                _btnLogin(),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
        // ),
      ),
    );
  }

  Widget _username() {
    //username
    return Container(
      width: 370,
      child: TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return 'กรุณากรอก Username';
          }
        },
        controller: _fusername,
        decoration: InputDecoration(
            hintText: 'Username',
            hintStyle: TextStyle(color: Theme.of(context).primaryColor),
            icon: Icon(
              Icons.person,
              size: 40,
              color: Theme.of(context).primaryColor,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(35.0),
            )),
        cursorColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _password() {
    //username
    return Container(
      width: 370,
      child: TextFormField(
        //เช็คความถูกต้อง
        validator: (value) {
          if (value.isEmpty) {
            return 'กรุณากรอก Password';
          }
        },
        obscureText: true,
        controller: _fpassword,
        decoration: InputDecoration(
            hintText: 'Passwords',
            hintStyle: TextStyle(color: Theme.of(context).primaryColor),
            icon: Icon(
              Icons.lock,
              size: 40,
              color: Theme.of(context).primaryColor,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(35.0),
            )),
      ),
    );
  }

  Widget _btnLogin() {
    return Padding(
      padding: EdgeInsets.only(left: 180),
      child: SizedBox(
        width: 150,
        height: 50,
        child: RaisedButton(
          child: Text(
            'Login',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          color: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          onPressed: () {
            doLogin();
          },
        ),
      ),
    );
  }
} //class
