import 'package:flutter/material.dart';
import 'package:my_finalapp1/user/LoginPage.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
            gomainuser(),
            SizedBox(height: 20),
            gomainowner(),
          ],
        ),
      )),
    );
  }

  Widget gomainuser() {
    return Padding(
        padding: EdgeInsets.all(0),
        child: SizedBox(
          width: double.infinity,
          // height: 50,
          child: RaisedButton(
            child: Text(
              'ผู้ใช้',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700
              ),
            ),
            color: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onPressed: () {
              // Navigator.pushNamed(context, '/uloginpage');
              Navigator.pushNamed(context, '/mainpageuser');
            },
          ),
        ));
  }

  Widget gomainowner() {
    return Padding(
        padding: EdgeInsets.only(right: 0),
        child: SizedBox(
          width: double.infinity,
          // height: 50,
          child: RaisedButton(
            child: Text(
              'เจ้าของร้าน',
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
              Navigator.pushNamed(context, '/mainpageowner');
            },
          ),
        ));
  }
} // ! m class