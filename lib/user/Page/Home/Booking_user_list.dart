import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_finalapp1/model/Connectapi.dart';
import 'package:my_finalapp1/model/model_get_list_bookings_user.dart';
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

  var dateformate = DateFormat.yMd();
  var timeformate = DateFormat.jm();

  var _satatus0 = 'รอการยืนยันการสำรองที่นั่ง';
  var _satatus1 = 'ยืนยันการสำรองที่นั่งสำเร็จ';
  var _satatus2 = 'การสำรองที่นั่งถูกยกเลิก';

  Widget checkStatus(bkStatus) {
    Widget child;
    print(bkStatus);
    if (bkStatus == '1') {
      child =
          // Text(_satatus1, style: TextStyle(fontSize: 14, color: Colors.green));
          Card(
              elevation: 0,
              color: Colors.green,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(_satatus1,
                    style: TextStyle(fontSize: 14, color: tTextWColor)),
              ));
    } else if (bkStatus == '2') {
      child = Card(
          elevation: 0,
          color: tErrorColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(_satatus2,
                style: TextStyle(fontSize: 14, color: tTextWColor)),
          ));
    } else {
      child = Card(
          elevation: 0,
          color: Colors.orange,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(_satatus0,
                style: TextStyle(fontSize: 14, color: tTextWColor)),
          ));
      ;
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
        child: _reviewList(),
      ),
    );
  }

  Widget _reviewList() {
    return SingleChildScrollView(
      child: datamembers.length <= 0
          ? Container(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                    Icon(
                      Icons.error,
                      size: 100,
                      color: Colors.grey,
                    ),
                    Text(
                      'ไม่มีรายการ',
                      style: TextStyle(
                        color: tTextGColor,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: datamembers.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/showdetailbookinguser',
                          arguments: {
                            'bk_id': datamembers[index].bkId,
                            'bk_seat': datamembers[index].bkSeat,
                            'bk_detail': datamembers[index].bkDetail,
                            'bk_checkin_date': datamembers[index].bkCheckinDate,
                            'bk_status': datamembers[index].bkStatus,
                            //
                            'np_id': datamembers[index].npId,
                            'np_name': datamembers[index].npName,
                            'np_phone': datamembers[index].npPhone,
                            'np_email': datamembers[index].npEmail,
                            //
                            'user_id': datamembers[index].userId,
                            'user_name': datamembers[index].userName,
                            'user_lastname': datamembers[index].userLastname,
                            'user_phone': datamembers[index].userPhone,
                            'user_email': datamembers[index].userEmail,
                          });
                      print(datamembers[index].npName);
                    },
                    child: Card(
                      elevation: 5,
                      shadowColor: tBGDeepColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.white,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        // height: MediaQuery.of(context).size.height * 0.335,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${datamembers[index].npName}',
                                        style: TextStyle(
                                          color: tTextColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        '${datamembers[index].npPhone}',
                                        style: TextStyle(
                                          color: tTextColor,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16,
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
                              IntrinsicHeight(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                      width: 110,
                                      height: 110,
                                      child: Card(
                                        // color: Colors.black45,
                                        elevation: 0,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '${datamembers[index].bkSeat}',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            Text(
                                              'จำนวณที่สำรองนั่ง',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    VerticalDivider(
                                      indent: 20,
                                      endIndent: 20,
                                      thickness: 1,
                                      color: Colors.black26,
                                    ),
                                    SizedBox(
                                      width: 110,
                                      height: 110,
                                      child: Card(
                                        // color: Colors.black45,
                                        elevation: 0,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '${timeformate.format(DateTime.parse(datamembers[index].bkCheckinDate))}',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            Text(
                                              'เวลาเช็คอิน',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    VerticalDivider(
                                      indent: 20,
                                      endIndent: 20,
                                      thickness: 1,
                                      color: Colors.black26,
                                    ),
                                    SizedBox(
                                      width: 110,
                                      height: 110,
                                      child: Card(
                                        // color: Colors.black45,
                                        elevation: 0,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '${dateformate.format(DateTime.parse(datamembers[index].bkCheckinDate))}',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            Text(
                                              'วันที่เช็คอิน',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 1,
                                color: Colors.black12,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'รายละเอียดที่แจ้งไว้กับทางร้าน',
                                    style: TextStyle(
                                      color: tTextColor,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Text(
                                    '${datamembers[index].bkDetail}',
                                    style: TextStyle(
                                      color: tTextColor,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
