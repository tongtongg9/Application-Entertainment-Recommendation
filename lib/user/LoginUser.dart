import 'package:flutter/material.dart';
import 'package:my_finalapp1/user/bottom_nav_bar.dart';
import 'package:my_finalapp1/model/LoginModel.dart';
import 'package:my_finalapp1/widget/custom_back_button.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginUser extends StatefulWidget {
  // LoginUser({Key? key}) : super(key: key);

  @override
  _LoginUserState createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
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
      appBar: AppBar(
        leading: CustomBackButton(
            tapBack: () {
              Navigator.pop(context);
            },
          ),
          // title: Text("เข้าสู่ระบบ"),
          ),
      body: Container(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 0,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "เข้าสู่ระบบ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Form(
                  key: _formkey,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(90),
                          topRight: Radius.circular(0),
                        )),
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
                ),
              ),
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
        color: Theme.of(context).primaryColor,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Theme.of(context).scaffoldBackgroundColor,
        hintText: 'ชื่อผู้ใช้',
        focusColor: Theme.of(context).primaryColor,
        hintStyle: TextStyle(
          fontSize: 18,
          color: Theme.of(context).primaryColor,
        ),
        icon: ImageIcon(
          new AssetImage('assets/icons/user.png'),
          color: Theme.of(context).primaryColor,
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
        color: Theme.of(context).primaryColor,
        fontSize: 18,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Theme.of(context).scaffoldBackgroundColor,
        hintText: 'รหัสผ่าน',
        focusColor: Theme.of(context).primaryColor,
        hintStyle: TextStyle(
          fontSize: 18,
          color: Theme.of(context).primaryColor,
        ),
        icon: ImageIcon(
          new AssetImage('assets/icons/lock.png'),
          color: Theme.of(context).primaryColor,
          // size: 30,
        ),
      ),
    );
  }

  Widget btnLogin() {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        color: Theme.of(context).primaryColor,
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
