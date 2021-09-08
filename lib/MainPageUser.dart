import 'package:flutter/material.dart';
import 'package:my_finalapp1/widget/colors.dart';
import 'package:my_finalapp1/widget/custom_back_button.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'model/LoginModel.dart';
import 'user/bottom_nav_bar.dart';

class MainPageUser extends StatefulWidget {
  @override
  _MainPageUserState createState() => _MainPageUserState();
}

class _MainPageUserState extends State<MainPageUser> {
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
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        leading: CustomBackButton(
          tapBack: () {
            Navigator.pop(context);
          },
        ),
        // title: Text("เข้าสู่ระบบ"),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                'assets/images/pub.png',
                width: MediaQuery.of(context).size.width * 0.3,
              ),
              SizedBox(height: 50),
              loginfrom(),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _btnMRegis(),
                  _btnMLogin(),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }

  Widget loginfrom() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        children: [
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'กรุณากรอกชื่อผู้ใช้';
              }
            },
            controller: _fusername,
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
              hintText: 'ชื่อผู้ใช้',
              hintStyle: TextStyle(
                fontSize: 16,
                color: tGreyColor,
              ),
              icon: ImageIcon(
                new AssetImage('assets/icons/user.png'),
                color: tPimaryColor,
                // size: 30,
              ),
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'กรุณากรอกรหัสผ่าน';
              }
            },
            controller: _fpassword,
            obscureText: true,
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
              hintText: 'รหัสผ่าน',
              hintStyle: TextStyle(
                fontSize: 16,
                color: tGreyColor,
              ),
              icon: ImageIcon(
                new AssetImage('assets/icons/lock.png'),
                color: tPimaryColor,
                // size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget usernameField() {
  //   return TextFormField(
  //     validator: (value) {
  //       if (value.isEmpty) {
  //         return 'กรุณากรอกชื่อผู้ใช้';
  //       }
  //     },
  //     controller: _fusername,
  //     style: TextStyle(
  //       color: tTextColor,
  //       fontSize: 16,
  //     ),
  //     cursorColor: tPimaryColor,
  //     decoration: InputDecoration(
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(10),
  //         borderSide: BorderSide.none,
  //       ),
  //       filled: true,
  //       fillColor: tBGDeepColor,
  //       hintText: 'ชื่อผู้ใช้',
  //       hintStyle: TextStyle(
  //         fontSize: 16,
  //         color: tGreyColor,
  //       ),
  //       icon: ImageIcon(
  //         new AssetImage('assets/icons/user.png'),
  //         color: tPimaryColor,
  //         // size: 30,
  //       ),
  //     ),
  //   );
  // }

  // Widget passwordField() {
  //   return TextFormField(
  //     validator: (value) {
  //       if (value.isEmpty) {
  //         return 'กรุณากรอกรหัสผ่าน';
  //       }
  //     },
  //     controller: _fpassword,
  //     obscureText: true,
  //     style: TextStyle(
  //       color: tTextColor,
  //       fontSize: 16,
  //     ),
  //     cursorColor: tPimaryColor,
  //     decoration: InputDecoration(
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(10),
  //         borderSide: BorderSide.none,
  //       ),
  //       filled: true,
  //       fillColor: tBGDeepColor,
  //       hintText: 'รหัสผ่าน',
  //       hintStyle: TextStyle(
  //         fontSize: 16,
  //         color: tGreyColor,
  //       ),
  //       icon: ImageIcon(
  //         new AssetImage('assets/icons/lock.png'),
  //         color: tPimaryColor,
  //         // size: 30,
  //       ),
  //     ),
  //   );
  // }

  Widget _btnMLogin() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          primary: tPimaryColor,
        ),
        child: Text(
          'เข้าสู่ระบบ',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        onPressed: () {
          doLogin();
          // Navigator.pushNamed(context, '/uloginpage');
        },
      ),
    );
  }

  Widget _btnMRegis() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          primary: tPimaryColor,
        ),
        child: Text(
          'สมัครสมาชิก',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/uregisterpage');
        },
      ),
    );
  }
} // ! m class 