import 'package:flutter/material.dart';
import 'package:my_finalapp1/user/LoginPage.dart';
import 'package:my_finalapp1/widget/custom_back_button.dart';

class MainPageUser extends StatefulWidget {
  @override
  _MainPageUserState createState() => _MainPageUserState();
}

class _MainPageUserState extends State<MainPageUser> {
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
          color: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onPressed: () {
            // Navigator.pushNamed(context, '/uloginpage');
            Navigator.pushNamed(context, '/uloginpage');
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
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            color: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/uregisterpage');
            },
          ),
        ));
  }
} // ! m class