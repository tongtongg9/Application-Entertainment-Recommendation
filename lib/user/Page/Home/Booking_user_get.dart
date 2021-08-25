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
          width: double.infinity,
          padding: EdgeInsets.only(bottom: 30),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: _reviewList(),
          ),
        ),
      ),
    );
  }

  Widget _reviewList() {
    var dateformate = DateFormat.yMMMEd();

    return SingleChildScrollView(
      child: datamembers.length <= 0
          ? Card(
              elevation: 0,
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
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Theme.of(context).scaffoldBackgroundColor,
                      // color: Theme.of(context).backgroundColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // SizedBox(
                                //   height: 40,
                                //   width: 40,
                                //   child: Stack(
                                //     overflow: Overflow.visible,
                                //     fit: StackFit.expand,
                                //     children: [
                                //       ClipRRect(
                                //         borderRadius: BorderRadius.circular(50),
                                //         child: imgsuser(
                                //             '${datamember[index].userImg}'),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "${datamembers[index].npName}",
                                          style: TextStyle(
                                            color: tTextColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'รีวิวให้ร้าน',
                                          style: TextStyle(
                                            color: tTextColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          "${datamembers[index].npName}",
                                          style: TextStyle(
                                            color: tPimaryColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      // "${datamember[index].revTime}",
                                      '${dateformate.format(DateTime.parse(datamembers[index].bkBookingTime))}',
                                      style: TextStyle(
                                        color: tTextColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${datamembers[index].bkSeat}",
                                  style: TextStyle(
                                    color: tTextColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${datamembers[index].bkDetail}",
                                  maxLines: 5,
                                  style: TextStyle(
                                    color: tTextColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.black12,
                            thickness: 2,
                          ),
                        ],
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
