import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_finalapp1/model/Connectapi.dart';
import 'package:my_finalapp1/model/Member.dart';
import 'package:my_finalapp1/user/Page/Home/components/app_bar.dart';
import 'package:my_finalapp1/user/Page/Home/components/grid_np.dart';
import 'package:my_finalapp1/user/Page/Home/components/show_promotions.dart';
import 'package:my_finalapp1/widget/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class NewwHome extends StatefulWidget {
  // NewwHome({Key? key}) : super(key: key);

  @override
  _NewwHomeState createState() => _NewwHomeState();
}

class _NewwHomeState extends State<NewwHome> {
  // Future onGoBack(dynamic value) {
  //   setState(() {
  //     _getInfoUser();
  //   });
  // }

  @override
  void initState() {
    // TODO implement initState
    super.initState();
    //call _getAPI
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        // backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        title: Text(
          'หน้าหลัก',
          style: TextStyle(
            color: tTextColor,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: ShowPromotions(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: btnPromotions(),
              ),
              ShowGridNP(),
            ],
          ),
        ),
      ),
    );
  }

  Widget btnPromotions() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: tBGColor,
        border: Border.all(
          width: 1,
          color: tPimaryColor,
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            SizedBox(width: 8),
            IconButton(
              icon: Image.asset('assets/icons/coupon.png'),
              onPressed: () {
                Navigator.pushNamed(context, '/showpromotionslist');
              },
            ),
            VerticalDivider(
              indent: 5,
              endIndent: 5,
              thickness: 1,
              color: Colors.black26,
            ),
            SizedBox(width: 8),
            TextButton(
              child: Text(
                'โปรโมรชั่นจากทางร้าน',
                style: TextStyle(
                  color: tPimaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/showpromotionslist');
              },
            ),
          ],
        ),
      ),
    );
  }
}
