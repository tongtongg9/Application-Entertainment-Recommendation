import 'package:flutter/material.dart';
import 'package:my_finalapp1/user/LoginPage.dart';
import 'package:my_finalapp1/widget/colors.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/logo_text.png',
              width: MediaQuery.of(context).size.width * 0.5,
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                gomainowner(),
                gomainuser(),
                // gomainowner(),
              ],
            ),
          ],
        ),
      )),
    );
  }

  Widget gomainuser() {
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
          'ผู้ใช้',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/mainpageuser');
        },
      ),
    );
  }

  Widget gomainowner() {
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
          'เจ้าของร้าน',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/mainpageowner');
        },
      ),
    );
  }
} // ! m class 