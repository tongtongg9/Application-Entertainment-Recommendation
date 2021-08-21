import 'package:flutter/material.dart';
import 'package:my_finalapp1/widget/colors.dart';

class Nontification extends StatefulWidget {
  // Nontification({Key? key}) : super(key: key);

  @override
  _NontificationState createState() => _NontificationState();
}

class _NontificationState extends State<Nontification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        // backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        title: Text(
          'แจ้งเตือน',
          style: TextStyle(
            color: tWhiteColor,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}