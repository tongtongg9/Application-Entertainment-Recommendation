import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:my_finalapp1/model/Connectapi.dart';
import 'package:my_finalapp1/widget/colors.dart';

class ShowPromotionsDetail extends StatefulWidget {
  // ShowPromotionsDetail({Key? key}) : super(key: key);

  @override
  _ShowPromotionsDetailState createState() => _ShowPromotionsDetailState();
}

class _ShowPromotionsDetailState extends State<ShowPromotionsDetail> {
  var token;

  Map<String, dynamic> _rec_member;

  var _proId;
  var _proTopic;
  var _proDetail;
  var _proStart;
  var _proEnd;
  var _proImg;

  var _npId;
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

  Future getData() {
    _rec_member = ModalRoute.of(context).settings.arguments;
    _proId = _rec_member['pro_id'];
    _proTopic = _rec_member['pro_topic'];
    _proDetail = _rec_member['pro_detail'];
    _proStart = _rec_member['pro_start'];
    _proEnd = _rec_member['pro_end'];
    _proImg = _rec_member['pro_img'];
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

    print(_rec_member);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
            child: _image('$_proImg'),
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
              initialChildSize: 0.7,
              minChildSize: 0.7,
              maxChildSize: 0.9,
              builder: (context, scrollController) => Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Container(
                        //   alignment: Alignment.center,
                        //   child: SizedBox(
                        //     width: 60,
                        //     child: Image.asset('assets/icons/coupon2.png'),
                        //   ),
                        // ),
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
                            // checkStatus(_npBkStatus),
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
                                // TextButton.icon(
                                //   onPressed: () {
                                //     googleMap();
                                //     print(googleMap);
                                //   },
                                //   icon: Icon(
                                //     Icons.location_pin,
                                //     color: tPimaryColor,
                                //   ),
                                //   label: Text(
                                //     '$_npName',
                                //     style: TextStyle(
                                //       color: tPimaryColor,
                                //       fontSize: 16,
                                //     ),
                                //   ),
                                // ),
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
                        // Card(
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
                        // ),
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
                        // _reviewList(),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // btnReserve(),
                // btnReview(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _image(imageName) {
    Widget child;
    print('Imagename : $imageName');
    if (imageName != null) {
      child = Image.network(
        '${Connectapi().domainimgpro}${imageName}',
        fit: BoxFit.cover,
      );
    } else {
      child = Image.asset('assets/images/person.png');
    }
    return new Container(child: child);
  }
}
