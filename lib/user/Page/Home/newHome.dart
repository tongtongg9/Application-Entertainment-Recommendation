import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:my_finalapp1/model/Connectapi.dart';
import 'package:my_finalapp1/model/Member.dart';
import 'package:my_finalapp1/user/Page/Home/components/app_bar.dart';
import 'package:my_finalapp1/user/Page/Home/components/grid_np.dart';
import 'package:my_finalapp1/user/Page/Home/components/places_categories.dart';
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
  String userId;
  UserInfo udata;
  //connect server api
  Future<Void> _getInfoUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var userId = prefs.getInt('id');
    print('uId = $userId');
    print('token = $token');
    var url = '${Connectapi().domain}/getprofileuser/$userId';
    //conect
    var response = await http.get(Uri.parse(url), headers: {
      'Connect-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    //check response
    if (response.statusCode == 200) {
      //แปลงjson ให้อยู่ในรูปแบบ model members
      UserMember members =
          UserMember.fromJson(convert.jsonDecode(response.body));
      //รับค่า ข้อมูลทั้งหมดไว้ในตัวแปร
      setState(() {
        udata = members.info;
      });
    }
  }

  Future onGoBack(dynamic value) {
    setState(() {
      _getInfoUser();
    });
  }

  @override
  void initState() {
    // TODO implement initState
    super.initState();
    //call _getAPI
    _getInfoUser();
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
              showWelcome(),
              // PlacesCategories(),
              ShowGridNP(),
            ],
          ),
        ),
      ),
    );
  }

  Padding showWelcome() {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 20),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Text(
                    "สวัสดี คุณ,",
                    style: TextStyle(
                      color: tTextColor,
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    '${udata.userName}',
                    style: TextStyle(
                      // color: Colors.white,
                      color: tPimaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Text(
                    "เลือกร้านที่คุณชอบแล้วออกไปสนุกเลย!!",
                    style: TextStyle(
                      color: tTextColor,
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
    );
  }
}
