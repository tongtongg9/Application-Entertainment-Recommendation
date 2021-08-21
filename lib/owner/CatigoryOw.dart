import 'package:flutter/material.dart';

class CatigoryOw extends StatelessWidget {
  // String image;
  String text;
  Color color;

  // CatigoryW({this.image, this.text, this.color});
  CatigoryOw({this.text,this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 177,
        width: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(0x9F3D416E),
        ),
        child: Column(
          children: [
            // Image.asset(
            //   image,
            //   width: 120,
            //   height: 120,
            // ),
            SizedBox(
              height: 10,
            ),
            Text(
              text,
              style: TextStyle(color: color, fontSize: 18),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.pop(context, '/LoginPage');
      },
    );
  }
}