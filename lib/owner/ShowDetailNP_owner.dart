import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:my_finalapp1/NewHome.dart';
import 'package:my_finalapp1/model/Connectapi.dart';
import 'package:my_finalapp1/model/model_get_img_np.dart';
import 'package:my_finalapp1/widget/colors.dart';
import 'package:my_finalapp1/widget/loading_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class ShowDetailNPowner extends StatefulWidget {
  // ShowDetailNPowner({Key? key}) : super(key: key);

  @override
  _ShowDetailNPownerState createState() => _ShowDetailNPownerState();
}

class _ShowDetailNPownerState extends State<ShowDetailNPowner> {
  final keyRefresh = GlobalKey<RefreshIndicatorState>();

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
  var _npLat;
  var _npLong;
  var _npBkStatus;

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
    _npLat = _rec_member['np_lat'];
    _npLong = _rec_member['np_long'];
    _npBkStatus = _rec_member['np_bk_status'];
    print(_npId);
    print(_npName);
    print(_npBkStatus);
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

  Future<void> _updateStatus(Map<String, dynamic> values) async {
    var url = '${Connectapi().domain}/updatestatusnp/$_npId';
    print(_npId);
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
  // List<Revlimit> datamembers = [];
  // //connect server api
  // Future<Void> _getListReviewslimit() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   token = prefs.getString('token');
  //   _npId = prefs.getInt('id');
  //   print('npId = $_npId');
  //   print('token = $token');
  //   var url = '${Connectapi().domain}/getlistreviewslimit/$_npId';
  //   //conect
  //   var response = await http.get(Uri.parse(url), headers: {
  //     'Connect-type': 'application/json',
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer $token',
  //   });
  //   //check response
  //   if (response.statusCode == 200) {
  //     //แปลงjson ให้อยู่ในรูปแบบ model members
  //     ReviewListLimitmodel members =
  //         ReviewListLimitmodel.fromJson(convert.jsonDecode(response.body));
  //     //รับค่า ข้อมูลทั้งหมดไว้ในตัวแปร
  //     setState(() {
  //       datamembers = members.revlimit;
  //       print(datamembers.length);
  //       // load = false;
  //     });
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getOrImage();
    // _getListReviewslimit();
    // rerere();
  }

  Future<void> rerere() async {
    keyRefresh.currentState?.show();
    await Future.delayed(Duration(seconds: 4));
    setState(() {
      getDataNp();
      // this._rec_member = _rec_member;
    });
  }

  bool isSwiteched = true;
  // bool isSwitechedOpen = true;
  // bool isSwitechedClose = false;
  void toggleSwitch(bool value) {
    if (value) {
      setState(() {
        isSwiteched = true;
      });
      print('np : open');
    } else {
      setState(() {
        isSwiteched = false;
      });
      print('np : close');
    }
  }

  var _closeBk = 'close';
  var _openBk = 'open';

  Widget checkStatus(_status) {
    Widget child;
    if (_status == 'open') {
      child = Card(
        elevation: 0,
        color: Colors.green,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('เปิดบริการสำรองที่นั่ง',
              style: TextStyle(fontSize: 12, color: tTextWColor)),
        ),
      );
    } else if (_status == 'close') {
      child = Card(
        elevation: 0,
        color: tErrorColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('ปิดบริการสำรองที่นั่ง',
              style: TextStyle(fontSize: 12, color: tTextWColor)),
        ),
      );
    }
    return new Container(child: child);
  }

  void googleMap() async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$_npLat,$_npLong';

    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else
      throw ('ไม่สามารถเปิด Google Maps ได้ ');
  }

  @override
  Widget build(BuildContext context) {
    getDataNp();
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
            child: CarouselSlider.builder(
              options: CarouselOptions(
                height: 400,
                viewportFraction: 1,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 4),
                enableInfiniteScroll: false,
              ),
              itemCount: imgsmembers.length,
              itemBuilder: (context, index, realIndex) {
                return Container(
                  // margin: EdgeInsets.symmetric(horizontal: 5),
                  width: MediaQuery.of(context).size.width,

                  child: _checkSendRepairImage(imgsmembers[index].npImg),
                  // fit: BoxFit.cover,
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              padding: const EdgeInsets.only(left: 16, top: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black87,
                        // color: Colors.white70,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: tPimaryColor,
                        ),
                      ),
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
            child: DraggableScrollableSheet(
              initialChildSize: 0.6,
              minChildSize: 0.6,
              maxChildSize: 0.9,
              builder: (context, scrollController) => Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                // margin: EdgeInsets.only(top: size.height * 0.3),
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  primary: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '$_npName',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: tTextColor,
                            ),
                          ),
                          SizedBox(width: 5),
                          checkStatus(_npBkStatus),
                          Spacer(),
                          CupertinoSwitch(
                            value: isSwiteched =
                                (_npBkStatus != 'open') ? false : true,
                            onChanged: (bool npStatus) {
                              isSwiteched
                                  ? showCupertinoDialog(
                                      context: context, builder: closeDialog)
                                  : showCupertinoDialog(
                                      context: context, builder: openDialog);
                              setState(() {
                                (_npBkStatus != 'open')
                                    ? setState(() {
                                        isSwiteched = true;
                                      })
                                    : setState(() {
                                        isSwiteched = false;
                                      });
                                // isSwiteched = npStatus;
                              });
                            },
                          )
                        ],
                      ),
                      Divider(
                        thickness: 2,
                        color: Colors.black12,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'รายละเอียดร้าน',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: tTextColor,
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        '$_npAbout',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: tTextColor,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'ข้อมูลติดต่อ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: tTextColor,
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
                              color: tTextColor,
                            ),
                          ),
                          Text(
                            '$_npPhone',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: tTextColor,
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
                              color: tTextColor,
                            ),
                          ),
                          Text(
                            '$_npEmail',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: tTextColor,
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 2,
                        color: Colors.black12,
                      ),
                      SizedBox(height: 10),
                      Column(
                        children: [
                          Row(
                            children: [
                              // Text(
                              //   'ที่อยู่ร้าน',
                              //   style: TextStyle(
                              //     fontSize: 18,
                              //     fontWeight: FontWeight.w700,
                              //     color: tTextColor,
                              //   ),
                              // ),
                              TextButton.icon(
                                onPressed: () {
                                  googleMap();
                                  print(googleMap);
                                },
                                icon: Icon(
                                  Icons.location_pin,
                                  color: tPimaryColor,
                                ),
                                label: Text(
                                  '$_npName',
                                  style: TextStyle(
                                    color: tPimaryColor,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                '${_npAdress} อำเภอ${_npDistrict} จังหวัด${_npProvince}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: tTextColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Card(
                        elevation: 2,
                        shadowColor: tBGDeepColor,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 250,
                          child: Center(
                            child: Text(
                              'ไม่มีตำแหน่งร้าน',
                              style: TextStyle(
                                color: tTextColor,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // ! Card(
                      //   elevation: 2,
                      //   shadowColor: tBGDeepColor,
                      //   child: SizedBox(
                      //     width: MediaQuery.of(context).size.width,
                      //     height: 250,
                      //     child: GoogleMap(
                      //       initialCameraPosition: CameraPosition(
                      //         target: LatLng(_npLat, _npLong),
                      //         zoom: 15,
                      //       ),
                      //       mapType: MapType.normal,
                      //       markers: <Marker>{
                      //         Marker(
                      //           markerId: MarkerId('myStore'),
                      //           position: LatLng(_npLat, _npLong),
                      //           infoWindow: InfoWindow(
                      //               title: '$_npName',
                      //               snippet:
                      //                   '${_npAdress} อำเภอ${_npDistrict} จังหวัด${_npProvince}',
                      //               onTap: () {
                      //                 googleMap();
                      //               }),
                      //         ),
                      //       },
                      //     ),
                      //   ),
                      //! ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomAppBar(
        color: tBGColor,
        // color: Colors.white,
        // color: Colors.transparent,
        // shape: CircularNotchedRectangle(),
        // notchMargin: 6,
        child: Container(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                btnBottombar(
                  'ดูรีวิว',
                  () {
                    Navigator.pushNamed(context, '/reviewlistnp', arguments: {
                      '_npId': _npId,
                    });
                  },
                ),
                btnBottombar(
                  'จัดการโปรโมชั่น',
                  () {
                    Navigator.pushNamed(context, '/showpromotionslistnp',
                        arguments: {
                          '_npId': _npId,
                        });
                  },
                ),
                btnBottombar(
                  'จัดการร้าน',
                  () {
                    Navigator.pushNamed(context, '/oweditmypub', arguments: {
                      '_npId': _npId,
                      '_npName': _npName,
                      '_npAbout': _npAbout,
                      '_npPhone': _npPhone,
                      '_npEmail': _npEmail,
                      '_npAdress': _npAdress,
                      '_npDistrict': _npDistrict,
                      '_npProvince': _npProvince,
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget closeDialog(BuildContext context) => CupertinoAlertDialog(
        title: Text(
          'บริการสำรองที่นั่ง',
          style: TextStyle(fontFamily: 'IBMPlexSansThai'),
        ),
        content: Text(
          'คุณต้องการปิดบริการสำรองที่นั่งหรือไม่?',
          style: TextStyle(fontFamily: 'IBMPlexSansThai'),
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text(
              'ยกเลิก',
              style: TextStyle(
                color: tErrorColor,
                fontFamily: 'IBMPlexSansThai',
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoDialogAction(
            child: Text(
              'ตกลง',
              style: TextStyle(
                fontFamily: 'IBMPlexSansThai',
              ),
            ),
            onPressed: () {
              Map<String, dynamic> valuse = Map();
              valuse['np_bk_status'] = _closeBk;
              print(_closeBk);
              _updateStatus(valuse);
              Navigator.pop(context);
            },
          )
        ],
      );
  Widget openDialog(BuildContext context) => CupertinoAlertDialog(
        title: Text(
          'บริการสำรองที่นั่ง',
          style: TextStyle(
            fontFamily: 'IBMPlexSansThai',
          ),
        ),
        content: Text(
          'คุณต้องการเปิดบริการสำรองที่นั่งหรือไม่?',
          style: TextStyle(
            fontFamily: 'IBMPlexSansThai',
          ),
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text(
              'ยกเลิก',
              style: TextStyle(
                color: tErrorColor,
                fontFamily: 'IBMPlexSansThai',
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoDialogAction(
            child: Text(
              'ตกลง',
              style: TextStyle(
                fontFamily: 'IBMPlexSansThai',
              ),
            ),
            onPressed: () {
              Map<String, dynamic> valuse = Map();
              valuse['np_bk_status'] = _openBk;
              print(_openBk);
              _updateStatus(valuse);
              // rerere();
              Navigator.pop(context);
            },
          )
        ],
      );

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

  Widget btnBottombar(final String _text, final VoidCallback _pressed) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          primary: tPimaryColor,
        ),
        child: Text(
          _text,
          style: TextStyle(
            fontSize: 16,
            color: tTextWColor,
          ),
        ),
        onPressed: _pressed,
      ),
    );
  }

  Widget _checkSendRepairImage(imageName) {
    Widget child;
    print('Imagename : $imageName');
    if (imageName != null) {
      child = Image.network(
        '${Connectapi().domainimgnpforuser}${imageName}',
        fit: BoxFit.cover,
      );
    } else {
      child = Image.asset('assets/images/no_image.png');
    }
    return new Container(child: child);
  }
}
