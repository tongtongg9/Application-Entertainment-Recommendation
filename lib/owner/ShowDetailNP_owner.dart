import 'dart:ffi';

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_finalapp1/model/Connectapi.dart';
import 'package:my_finalapp1/model/Member.dart';
import 'package:my_finalapp1/model/ShowImgnpforUser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class ShowDetailNPowner extends StatefulWidget {
  // ShowDetailNPowner({Key? key}) : super(key: key);

  @override
  _ShowDetailNPownerState createState() => _ShowDetailNPownerState();
}

class _ShowDetailNPownerState extends State<ShowDetailNPowner> {
  Map<String, dynamic> _rec_member;
  var _npId;
  var token;
  var _npName;
  var _npAbout;
  var _npPhone;
  var _npEmail;
  var _npAdress;
  var _npDistrict;
  var _npProvince;

  Future getDataNp() {
    _rec_member = ModalRoute.of(context).settings.arguments;
    _npId = _rec_member['np_id'];
    _npName = _rec_member['np_name'];
    _npAbout = _rec_member['np_about'];
    _npPhone = _rec_member['np_phone'];
    _npEmail = _rec_member['np_email'];
    _npAdress = _rec_member['np_adress'];
    _npDistrict = _rec_member['np_district'];
    _npProvince = _rec_member['np_province'];
    print(_npId);
    print(_npName);
  }

  List<Imgsrows> imgsmembers = [];

  var npId;

  Future<void> _getOrImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    npId = prefs.getInt('id');
    print('orId = $npId');
    print('token = $token');
    var url = '${Connectapi().domain}/showimgnpforuser/$_npId';
    //conect
    var response = await http.get(Uri.parse(url), headers: {
      'Connect-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    //check response
    if (response.statusCode == 200) {
      //แปลงjson ให้อยู่ในรูปแบบ model members
      ShowImgnpforUser images =
          ShowImgnpforUser.fromJson(convert.jsonDecode(response.body));
      //รับค่า ข้อมูลทั้งหมดไว้ในตัวแปร
      setState(() {
        imgsmembers = images.imgsrows;
        // load = false;
        print(imgsmembers.length);
      });
    }
  }

  List<Revlimit> datamembers = [];
  //connect server api
  Future<Void> _getListReviewslimit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    _npId = prefs.getInt('id');
    print('npId = $_npId');
    print('token = $token');
    var url = '${Connectapi().domain}/getlistreviewslimit/$_npId';
    //conect
    var response = await http.get(Uri.parse(url), headers: {
      'Connect-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    //check response
    if (response.statusCode == 200) {
      //แปลงjson ให้อยู่ในรูปแบบ model members
      ReviewListLimitmodel members =
          ReviewListLimitmodel.fromJson(convert.jsonDecode(response.body));
      //รับค่า ข้อมูลทั้งหมดไว้ในตัวแปร
      setState(() {
        datamembers = members.revlimit;
        print(datamembers.length);
        // load = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getOrImage();
    _getListReviewslimit();
  }

  @override
  Widget build(BuildContext context) {
    getDataNp();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // extendBodyBehindAppBar: true,
      // extendBody: true,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      // ),
      body: Stack(
        children: [
          // Container(
          //   height: size.height * 0.45,
          //   child: Image.asset(
          //     'assets/images/NP/np02.jpg',
          //     width: double.infinity,
          //     height: 200,
          //     fit: BoxFit.cover,
          //   ),
          // ),
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            // width: double.infinity,
            // child: Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: imgsmembers.length,
              itemBuilder: (BuildContext context, index) {
                return Container(
                  child: Container(
                    child: _checkSendRepairImage(imgsmembers[index].npImg),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          DelayedDisplay(
            delay: Duration(milliseconds: 100),
            fadingDuration: Duration(milliseconds: 300),
            slidingBeginOffset: const Offset(0, 1),
            child: Container(
              // height: size.height * 0.6,
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              margin: EdgeInsets.only(top: size.height * 0.35),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Theme.of(context).scaffoldBackgroundColor,
                // color: Colors.white70,
              ),
              child: SingleChildScrollView(
                // child: SafeArea(
                // top: false,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${_npName}',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Divider(
                      height: 20,
                      thickness: 1,
                      color: Colors.white10,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'รายละเอียดร้าน',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      '${_npAbout}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'ข้อมูลติดต่อ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Text(
                          'เบอร์โทรศัพท์  : ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '${_npPhone}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Email  : ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '${_npEmail}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      height: 50,
                      thickness: 1,
                      color: Colors.white10,
                    ),
                    Row(
                      children: [
                        Text(
                          "รีวิวจากผู้ใช้บริการ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.normal),
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/reviewlistnp',
                                arguments: {
                                  '_npId': _npId,
                                });
                          },
                          child: Text(
                            'ดูทั้งหมด',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    //  Spacer(),

                    _reviewList(),
                  ],
                ),
              ),
            ),
          ),
          // ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).scaffoldBackgroundColor,
        // color: Colors.white,
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
                btnEditNp(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _reviewList() {
    var dateformate = DateFormat.yMMMEd();
    
    return ListView.builder(
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
              color: Theme.of(context).backgroundColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        useravatar(),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${datamembers[index].userUsername}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${dateformate.format(DateTime.parse(datamembers[index].revTime))}",
                              style: TextStyle(
                                color: Colors.white,
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
                          "${datamembers[index].revTopic}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${datamembers[index].revDetail}",
                          maxLines: 5,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
        // ],
      },
    );
  }

  Widget useravatar() {
    return SizedBox(
      height: 40,
      width: 40,
      child: Stack(
        overflow: Overflow.visible,
        fit: StackFit.expand,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white70,
            backgroundImage: AssetImage("assets/images/person.png"),
          ),
        ],
      ),
    );
  }

  Widget btnEditNp() {
    return SizedBox(
      width: 425,
      // height: 50,
      child: RaisedButton(
        color: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            'จัดการร้าน',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        onPressed: () {
          // Map<String, dynamic> valuse = Map();
          // valuse['user_id'] = _user_id;
          // valuse['np_id'] = _npId;
          // valuse['rev_topic'] = _rev_topic.text;
          // valuse['rev_detail'] = _rev_detail.text;

          // print(_rev_topic.text);
          // print(_rev_detail.text);

          // addReviews(valuse);
          // Navigator.pop(context, '/showdetailnp');
        },
      ),
    );
  }

  Widget _checkSendRepairImage(imageName) {
    Widget child;
    print('Imagename : $imageName');
    if (imageName != null) {
      child = Image.network('${Connectapi().domainimgnpforuser}${imageName}');
    } else {
      child = Image.asset('assets/images/no_image.png');
    }
    return new Container(child: child);
  }
}
