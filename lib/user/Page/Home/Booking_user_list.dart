import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_finalapp1/model/Connectapi.dart';
import 'package:my_finalapp1/model/Get_Bookings_by_user.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:my_finalapp1/widget/colors.dart';
import 'package:my_finalapp1/widget/custom_back_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowBookingUser extends StatefulWidget {
  // ShowBookingUser({Key? key}) : super(key: key);

  @override
  _ShowBookingUserState createState() => _ShowBookingUserState();
}

class _ShowBookingUserState extends State<ShowBookingUser> {
  List<Rsbookbyuser> datamembers = [];
  var token;
  var userID;

  Future getNP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    userID = prefs.getInt('id');
    print('userID = $userID');
    print('token = $token');
  }

  Future<Void> showbookings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    userID = prefs.getInt('id');
    print('id = $userID');
    print('token = $token');
    var url = '${Connectapi().domain}/getbookingsbyuser/$userID';
    //conect
    var response = await http.get(Uri.parse(url), headers: {
      'Connect-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    //check response
    if (response.statusCode == 200) {
      //แปลงjson ให้อยู่ในรูปแบบ model members
      Get_Bookings_by_user members =
          Get_Bookings_by_user.fromJson(convert.jsonDecode(response.body));
      //รับค่า ข้อมูลทั้งหมดไว้ในตัวแปร
      setState(() {
        datamembers = members.rsbookbyuser;
        // load = false;
      });
    }
  }

  var dateformate = DateFormat.yMMMEd();

  var _satatus0 = 'รอการยืนยันการสำรองที่นั่ง';
  var _satatus1 = 'ยืนยันการสำรองที่นั่งสำเร็จ';
  var _satatus2 = 'การสำรองที่นั่งถูกยกเลิก';

  Widget checkStatus(bkStatus) {
    Widget child;
    print(bkStatus);
    if (bkStatus == '1') {
      child =
          Text(_satatus1, style: TextStyle(fontSize: 14, color: Colors.green));
    } else if (bkStatus == '2') {
      child =
          Text(_satatus2, style: TextStyle(fontSize: 14, color: tErrorColor));
    } else {
      child =
          Text(_satatus0, style: TextStyle(fontSize: 14, color: Colors.orange));
    }
    return new Container(child: child);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //call _getAPI
    showbookings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายการสำรองที่นั่ง'),
        leading: CustomBackButton(
          tapBack: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 0,
              right: 0,
            ),
            child: _reviewList(),
          ),
        ),
      ),
    );
  }

  Widget _reviewList() {
    return SingleChildScrollView(
      child: datamembers.length <= 0
          ? Card(
              elevation: 2,
              color: tBGDeepColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: SizedBox(
                height: 100,
                child: Center(
                  child: Text(
                    'ไม่มีรีวิวจากผู้ใช้อื่น',
                    style: TextStyle(
                      color: tTextColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            )
          : ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: datamembers.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Card(
                    elevation: 5,
                    shadowColor: tBGDeepColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: tBGColor,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      // height: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${datamembers[index].npName}',
                                      style: TextStyle(
                                        color: tTextColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '${datamembers[index].npPhone}',
                                      style: TextStyle(
                                        color: tTextColor,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                                checkStatus(datamembers[index].bkStatus)
                              ],
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.black12,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
                // ],
              },
            ),
    );
  }
}
