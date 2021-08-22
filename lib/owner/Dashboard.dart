import 'dart:ffi';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:my_finalapp1/MainPage.dart';
import 'package:my_finalapp1/model/Connectapi.dart';
import 'package:my_finalapp1/model/Member.dart';
import 'package:my_finalapp1/widget/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  // Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String owId;
  OwnerInfo odata;
  //connect server api
  Future<Void> _getInfoOw() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var owId = prefs.getInt('id');
    print('uId = $owId');
    print('token = $token');
    var url = '${Connectapi().domain}/getprofileowner/$owId';
    //conect
    var response = await http.get(Uri.parse(url), headers: {
      'Connect-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    //check response
    if (response.statusCode == 200) {
      //แปลงjson ให้อยู่ในรูปแบบ model members
      OwnerMember members =
          OwnerMember.fromJson(convert.jsonDecode(response.body));
      //รับค่า ข้อมูลทั้งหมดไว้ในตัวแปร
      setState(() {
        odata = members.info;
      });
    }
  }

  Future _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => MainPage()),
        (Route<dynamic> route) => false);
    // _showbar();
  }

  @override
  void initState() {
    // TODO implement initState
    super.initState();
    //call _getAPI
    _getInfoOw();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 75),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "สวัสดี คุณ,",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Text(
                          '${odata.owName}',
                          style: TextStyle(
                            // color: Colors.white,
                            color: tPimaryColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "ขอต้อนรับสู่ร้านของคุณ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Divider(
            height: 5,
            thickness: 2,
          ),
          Flexible(
            //? << Grid Dashboard
            child: GridView.count(
              // scrollDirection: Axis.vertical,
              // shrinkWrap: true,
              childAspectRatio: 1.0,
              padding: EdgeInsets.all(10),
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              primary: true,
              children: [
                GridMenu(
                  press: () {
                    print('ข้อมูลส่วนตัว');
                    Navigator.pushNamed(context, '/owshowdata');
                  },
                  img: "assets/images/person.png",
                  title: "ข้อมูลส่วนตัว",
                  // subtitle: "subtitle",
                ),
                GridMenu(
                  press: () {
                    Navigator.pushNamed(context, '/owmypub');
                    print('ร้านของฉัน');
                  },
                  img: "assets/images/pub.png",
                  title: "ร้านของฉัน",
                  // subtitle: "subtitle",
                ),
                GridMenu(
                  press: () {
                    print('การแจ้งเตือน');
                  },
                  img: "assets/images/bell.png",
                  title: "การแจ้งเตือน",
                  // subtitle: "subtitle",
                ),
                GridMenu(
                  press: () {
                    print('รายการสำรองที่นั่ง');
                  },
                  img: "assets/images/checklist.png",
                  title: "รายการสำรองที่นั่ง",
                  // subtitle: "subtitle",
                ),
                GridMenu(
                  press: () {
                    print('โปรโมชั่น');
                  },
                  img: "assets/images/megaphone.png",
                  title: "โปรโมชั่น",
                  // subtitle: "subtitle",
                ),
                GridMenu(
                  press: () {
                    _logout();
                    print('ตั้งค่า');
                  },
                  img: "assets/images/settings.png",
                  title: "ตั้งค่า",
                  // subtitle: "subtitle",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//?  Grid Menu Dashboard
class GridMenu extends StatelessWidget {
  const GridMenu({
    Key key,
    @required this.press,
    @required this.img,
    @required this.title,
    // @required this.subtitle,
  }) : super(key: key);

  final VoidCallback press;
  final String img;
  final String title;
  // final String subtitle;

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: press,
      child: Card(
        elevation: 5,
        color: tBGDeepColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              img,
              width: 50,
            ),
            SizedBox(height: 3),
            Text(
              title,
              style: TextStyle(
                color: tTextColor,
                fontSize: 16,
              ),
            ),
            // SizedBox(height: 8),
            // Text(
            //   subtitle,
            //   style: TextStyle(
            //     color: Theme.of(context).primaryColor,
            //     fontSize: 18,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
