import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:my_finalapp1/widget/colors.dart';
import 'package:my_finalapp1/widget/custom_back_button.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:my_finalapp1/model/Connectapi.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingDetailuser extends StatefulWidget {
  // BookingDetailuser({Key? key}) : super(key: key);

  @override
  _BookingDetailuserState createState() => _BookingDetailuserState();
}

class _BookingDetailuserState extends State<BookingDetailuser> {
  Map<String, dynamic> _rec_member;
  var token;

  var _bkId;
  var _bkSeat;
  var _bkDetail;
  var _bkCheckinDate;
  var _bkStatus;
  //
  var _npId;
  var _npName;
  var _npPhone;
  var _npEmail;
  //
  var _userId;
  var _userName;
  var _userLastname;
  var _userPhone;
  var _userEmail;

  Future getData() {
    _rec_member = ModalRoute.of(context).settings.arguments;
    _bkId = _rec_member['bk_id'];
    _bkSeat = _rec_member['bk_seat'];
    _bkDetail = _rec_member['bk_detail'];
    _bkCheckinDate = _rec_member['bk_checkin_date'];
    _bkStatus = _rec_member['bk_status'];
    //
    _npId = _rec_member['np_id'];
    _npName = _rec_member['np_name'];
    _npPhone = _rec_member['np_phone'];
    _npEmail = _rec_member['np_email'];
    //
    _userId = _rec_member['user_id'];
    _userName = _rec_member['user_name'];
    _userLastname = _rec_member['user_lastname'];
    _userPhone = _rec_member['user_phone'];
    _userEmail = _rec_member['user_email'];

    print(_bkId);
    print(_npId);
    print(_npName);
    print(_userId);
    print(_userName);
  }

  Future getInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    _userId = prefs.getInt('id');
    print('uId = $_userId');
    print('token = $token');
  }

  Future<void> _update(Map<String, dynamic> values) async {
    var url = '${Connectapi().domain}/updatestatus/$_bkId';
    print(_bkId);
    var response = await http.put(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: convert.jsonEncode(values));
    print(values);
    if (response.statusCode == 200) {
      print('Update Success!');
      // Navigator.pop(context, true);
    } else {
      print('Update Fail!!');
    }
  }

  var _updatestatus1 = '1';
  var _updatestatus2 = '2';

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
    }
    return new Container(child: child);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInfo();
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      appBar: AppBar(
        title: Text('รายละเอียดการสำรองที่นั่ง'),
        leading: CustomBackButton(
          tapBack: () {
            Navigator.pop(context);
          },
        ),
        // actions: [
        //   TextButton(
        //     onPressed: () {},
        //     child: Text(
        //       'บันทึก',
        //       style: TextStyle(
        //         color: tPimaryColor,
        //       ),
        //     ),
        //   )
        // ],
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // floatingActionButton: FloatingActionButton.extended(
      // onPressed: () {
      // Map<String, dynamic> valuse = Map();
      // valuse['bk_id'] = _bkId;
      // valuse['bk_status'] = _updatestatus1;
      // print(_updatestatus1);
      // _update(valuse);
      // },
      // label: Text('เพิ่มร้านของคุณ'),
      // backgroundColor: tPimaryColor,
      // icon: Icon(
      // Icons.add,
      // color: Colors.white,
      // ),
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${_npName}',
                                  style: TextStyle(
                                    color: tTextColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  '${_npPhone}',
                                  style: TextStyle(
                                    color: tTextColor,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            checkStatus(_bkStatus)
                          ],
                        ),
                        Divider(
                          thickness: 1,
                          color: Colors.black12,
                        ),
                        IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: 110,
                                height: 110,
                                child: Card(
                                  // color: Colors.black45,
                                  elevation: 0,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${_bkSeat}',
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${timeformate.format(DateTime.parse(_bkCheckinDate))}',
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${dateformate.format(DateTime.parse(_bkCheckinDate))}',
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
                              '${_bkDetail}',
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
              Card(
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              child: ImageIcon(
                                new AssetImage('assets/icons/user.png'),
                                size: 30,
                                color: tPimaryColor,
                              ),
                            ),
                            SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ชื่อผู้จอง',
                                  style: TextStyle(
                                    color: tTextColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  '${_userName}  ${_userLastname}',
                                  style: TextStyle(
                                    color: tTextColor,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // SizedBox(height: 10),
                        Divider(
                          indent: 40,
                          thickness: 1,
                          color: Colors.black12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              child: ImageIcon(
                                new AssetImage('assets/icons/phone.png'),
                                size: 30,
                                color: tPimaryColor,
                              ),
                            ),
                            SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'เบอร์โทรติดต่อ',
                                  style: TextStyle(
                                    color: tTextColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  '${_userPhone}',
                                  style: TextStyle(
                                    color: tTextColor,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).scaffoldBackgroundColor,
        // color: Colors.transparent,
        // shape: CircularNotchedRectangle(),
        // notchMargin: 6,
        child: Container(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _bkStatus == '0'
                    ? SizedBox(
                        width: 210,
                        child: RaisedButton(
                          color: tErrorColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'ยกเลิกการจอง',
                              style: TextStyle(
                                color: tTextWColor,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          onPressed: () {
                            Map<String, dynamic> valuse = Map();
                            // valuse['bk_id'] = _bkId;
                            valuse['bk_status'] = _updatestatus2;
                            print(_updatestatus2);
                            _update(valuse);
                          },
                        ),
                      )
                    : SizedBox(
                        width: 210,
                        child: RaisedButton(
                          color: Colors.black26,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'ยกเลิกการจอง',
                              style: TextStyle(
                                color: tTextWColor,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          onPressed: () {
                            // Map<String, dynamic> valuse = Map();
                            // // valuse['bk_id'] = _bkId;
                            // valuse['bk_status'] = _updatestatus2;
                            // print(_updatestatus2);
                            // _update(valuse);
                          },
                        ),
                      )
                // btnR(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget btnL() {
    return SizedBox(
      width: 210,
      // width: MediaQuery.of(context).size.width,
      // height: 50,
      child: RaisedButton(
        color: tErrorColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            'ยกเลิกการจอง',
            style: TextStyle(
              color: tTextWColor,
              fontSize: 18,
            ),
          ),
        ),
        onPressed: () {
          Map<String, dynamic> valuse = Map();
          // valuse['bk_id'] = _bkId;
          valuse['bk_status'] = _updatestatus2;
          print(_updatestatus2);
          _update(valuse);
        },
      ),
    );
  }

  Widget btnR() {
    return SizedBox(
      width: 210,
      // width: MediaQuery.of(context).size.width,
      // height: 50,
      child: RaisedButton(
        color: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            'ยืนยันการสำรองที่นั่ง',
            style: TextStyle(
              color: tTextWColor,
              fontSize: 18,
            ),
          ),
        ),
        onPressed: () {
          // Map<String, dynamic> valuse = Map();
          // // valuse['bk_id'] = _bkId;
          // valuse['bk_status'] = _updatestatus1;
          // print(_updatestatus1);
          // _update(valuse);
        },
      ),
    );
  }
}
