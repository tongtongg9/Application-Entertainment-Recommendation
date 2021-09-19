import 'dart:ffi';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:my_finalapp1/model/model_get_img_np.dart';
import 'package:my_finalapp1/model/model_get_list_limit_reviews_for_np.dart';
import 'package:my_finalapp1/widget/loading_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:my_finalapp1/model/Connectapi.dart';
import 'package:my_finalapp1/user/Page/Home/Review_user_list.dart';
import 'package:my_finalapp1/widget/colors.dart';
import 'package:my_finalapp1/widget/custom_back_button.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DetailNp extends StatefulWidget {
  // DetailNp({Key? key}) : super(key: key);

  @override
  _DetailNpState createState() => _DetailNpState();
}

class _DetailNpState extends State<DetailNp> {
  var idUser;

  // Future getprefs() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   token = prefs.getString('token');
  //   idUser = prefs.getInt('id');
  //   print('idUser = $idUser');
  //   print('token = $token');
  // }

  List<Imgsrows> imgsmembers = [];

  // var _npId;

  Future<void> _getOrImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    idUser = prefs.getInt('id');
    print('orId = $idUser');
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

  Map<String, dynamic> _rec_member;
  var _npId;
  var token;

  Future getData() {
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
  }

  var npId;

  List<Revlimit> datamembers = [];
  //connect server api
  Future<Void> _getListReviewslimit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    npId = prefs.getInt('id');
    print('npId = $npId');
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

  Future<Null> refreshModel() async {
    var urlModel = '${Connectapi().domain}/getlistreviewslimit/$_npId';
    print(urlModel);
    await http.get(Uri.parse(urlModel)).then((value) {
      setState(() {
        _getListReviewslimit();
      });
    });
    print('รีรีรีรี');
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
  void initState() {
    // TODO: implement initState
    super.initState();
    _getOrImage();
    _getListReviewslimit();
  }

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

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      // extendBodyBehindAppBar: true,
      // extendBody: true,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   leading: CustomBackButton(
      //     tapBack: () {
      //       Navigator.pop(context);
      //     },
      //   ),
      // ),
      body: Stack(
        children: [
          // Container(
          //   height: MediaQuery.of(context).size.height * 0.4,
          //   // width: double.infinity,
          //   // child: Expanded(
          //   child: ListView.builder(
          //     scrollDirection: Axis.horizontal,
          //     itemCount: imgsmembers.length,
          //     itemBuilder: (BuildContext context, index) {
          //       return Container(
          //         child: Container(
          //           child: _checkSendRepairImage(imgsmembers[index].npImg),
          //         ),
          //       );
          //     },
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
                  child: _imageNP('${imgsmembers[index].npImg}'),
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
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
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
                            Spacer(),
                            checkStatus(_npBkStatus),
                          ],
                        ),
                        Divider(
                          thickness: 2,
                          color: Colors.black12,
                        ),
                        SizedBox(height: 15),
                        Text(
                          'รายละเอียดร้าน',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: tTextColor,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          '$_npAbout',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: tTextColor,
                          ),
                        ),
                        SizedBox(height: 0),
                        Text(
                          'ข้อมูลติดต่อ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: tTextColor,
                          ),
                        ),
                        SizedBox(height: 10),
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
                        SizedBox(height: 10),
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
                        // Card(
                        //   elevation: 2,
                        //   shadowColor: tBGDeepColor,
                        //   child: SizedBox(
                        //     width: MediaQuery.of(context).size.width,
                        //     height: 250,
                        //     child: Center(
                        //       child: Text(
                        //         'ไม่มีตำแหน่งร้าน',
                        //         style: TextStyle(
                        //           color: tTextColor,
                        //           fontSize: 12,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Card(
                          elevation: 2,
                          shadowColor: tBGDeepColor,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 250,
                            child: GoogleMap(
                              initialCameraPosition: CameraPosition(
                                target: LatLng(_npLat, _npLong),
                                zoom: 15,
                              ),
                              mapType: MapType.normal,
                              markers: <Marker>{
                                Marker(
                                  markerId: MarkerId('myStore'),
                                  position: LatLng(_npLat, _npLong),
                                  infoWindow: InfoWindow(
                                      title: '$_npName',
                                      snippet:
                                          '${_npAdress} อำเภอ${_npDistrict} จังหวัด${_npProvince}',
                                      onTap: () {
                                        googleMap();
                                      }),
                                ),
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Divider(
                          thickness: 2,
                          color: Colors.black12,
                        ),
                        Row(
                          children: [
                            Text(
                              "รีวิวจากผู้ใช้บริการ",
                              style: TextStyle(
                                color: tTextColor,
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                              ),
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
                                  color: tPimaryColor,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        _reviewList(),
                      ],
                    ),
                  )),
            ),
          ),
        ],
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                btnReserve(),
                btnReview(),
              ],
            ),
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
                      elevation: 5,
                      shadowColor: tBGDeepColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.white,
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
                                SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: Stack(
                                    overflow: Overflow.visible,
                                    fit: StackFit.expand,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: imgsuser(
                                            '${datamembers[index].userImg}'),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${datamembers[index].userUsername}",
                                      style: TextStyle(
                                        color: tTextColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "${dateformate.format(DateTime.parse(datamembers[index].revTime))}",
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
                                  "${datamembers[index].revTopic}",
                                  style: TextStyle(
                                    color: tTextColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${datamembers[index].revDetail}",
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
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget btnReserve() {
    return _npBkStatus == 'open'
        ? SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                primary: tPimaryColor,
              ),
              child: Text(
                'สำรองที่นั่ง',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/reservepage', arguments: {
                  '_npId': _npId,
                  '_npName': _npName,
                });
              },
            ),
          )
        : SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                primary: tPimaryColor,
              ),
              child: Text(
                'สำรองที่นั่ง',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                // Navigator.pushNamed(context, '/reservepage', arguments: {
                //   '_npId': _npId,
                //   '_npName': _npName,
                // });
              },
            ),
          );
  }

  Widget btnReview() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          primary: tPimaryColor,
        ),
        child: Text(
          'เขียนรีวิว',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        // child: RaisedButton(
        //   color: tPimaryColor,
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(10),
        //   ),
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(vertical: 10),
        //     child: Text(
        //       'เขียนรีวิว',
        //       style: TextStyle(
        //         color: tTextWColor,
        //         fontSize: 18,
        //       ),
        //     ),
        //   ),
        onPressed: () {
          Navigator.pushNamed(context, '/reviewpage', arguments: {
            '_npId': _npId,
          }).then((value) => refreshModel());
        },
      ),
    );
  }

  Widget _imageNP(imageName) {
    return CachedNetworkImage(
      imageUrl: '${Connectapi().domainimgnpforuser}${imageName}',
      fit: BoxFit.cover,
      placeholder: (context, url) => Center(
        child: ShowProgress().loading(),
      ),
      errorWidget: (context, url, error) => Container(
        child: Icon(
          Icons.error,
          color: tErrorColor,
        ),
      ),
    );
  }

  // Widget imgsuser(imageName) {
  //   Widget child;
  //   print('Imagename : $imageName');
  //   if (imageName != null) {
  //     child = Image.network(
  //       '${Connectapi().domainimguser}${imageName}',
  //       fit: BoxFit.cover,
  //     );
  //   } else {
  //     child = Image.asset('assets/images/person.png');
  //   }
  //   return new Container(child: child);
  // }
  Widget imgsuser(imageName) => ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: CachedNetworkImage(
          key: UniqueKey(),
          imageUrl: '${Connectapi().domainimguser}${imageName}',
          fit: BoxFit.cover,
          placeholder: (context, imageUrl) => ShowProgress().loading(),
          errorWidget: (context, imageUrl, error) =>
              Image.asset('assets/images/person.png'),
        ),
      );

  // Widget _reviewList() {
  //   return Container(
  //     height: 370,
  //     child: ListView.builder(
  //       itemCount: datamembers.length,
  //     itemBuilder: (context, index) {
  //         // DateTime orDate = DateTime.parse('${commentmember[index].comTime}');
  //         return Center(
  //           // widthFactor: 200,
  //           child: Padding(
  //             padding: EdgeInsets.all(5.0),
  //             child: Card(
  //               elevation: 2,
  //               color: Colors.lightBlue.shade50,
  //               clipBehavior: Clip.antiAlias,
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(10),
  //               ),
  //               child: Column(
  //                 children: [
  //                   Padding(
  //                     padding: EdgeInsets.all(5),
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                             "${datamembers[index].revTopic}",
  //                             style: TextStyle(
  //                               color: Colors.white,
  //                               fontSize: 16,
  //                               fontWeight: FontWeight.bold,
  //                             ),
  //                           ),
  //                           Text(
  //                             "${datamembers[index].revDetail}",
  //                             style: TextStyle(
  //                               color: Colors.white,
  //                               fontSize: 16,
  //                               fontWeight: FontWeight.normal,
  //                             ),
  //                           ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }
}
