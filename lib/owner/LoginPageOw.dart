import 'package:flutter/material.dart';
// import 'package:my_finalapp1/HomePage.dart';
import 'package:my_finalapp1/model/LoginOWModel.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'Dashboard.dart';

class LoginPageOw extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPageOw> {
  TextEditingController _fusername = TextEditingController();
  TextEditingController _fpassword = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  LoginOwModel login = LoginOwModel();

  //ดึง token เพื่อ Login
Future doLoginOw() async {
    if (_formkey.currentState.validate()) {
      try {
        var rs = await login.doLoginOw(_fusername.text, _fpassword.text);
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
            // Navigator.pushNamedAndRemoveUntil(context, '/owdashboard', (route) => false);
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Dashboard()));
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65),
        child: AppBar(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formkey,
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
        ),
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
            icon: Icon(
              Icons.person,
              size: 40,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(35.0),
            )),
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
            icon: Icon(
              Icons.lock,
              size: 40,
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
          color: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          onPressed: () {
            doLoginOw();
          },
        ),
      ),
    );
  }
} //class
