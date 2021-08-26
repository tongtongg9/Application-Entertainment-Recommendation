// import 'package:flutter/material.dart';
// import 'package:flutter_project_app/Widgets/Show_progress.dart';
// import 'package:flutter_project_app/model/Connectapi.dart';
// import 'package:flutter_project_app/model/OrderImage.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert' as convert;
// import 'package:intl/intl.dart';

// class OrderCheck extends StatefulWidget {
//   const OrderCheck({Key key}) : super(key: key);

//   @override
//   _OrderCheckState createState() => _OrderCheckState();
// }

// class _OrderCheckState extends State<OrderCheck> {
//   final _formkey = GlobalKey<FormState>();
//   var _sTATUS1 = 'กำลังนำส่งสำนักงาน';

//   var orid;
//   var _ordate;
//   var _ortime;
//   var _ornum;
//   var _orstatus;
//   var _oraddress;
//   Getorderimage _orImg;
//   var formatter = DateFormat('dd/MM/y');

//   Map<String, dynamic> _rec_order;
//   var token;
//   // var or_id;

//   // CameraPosition position;
//   Position userLocation;
//   Set<Marker> _markers = {};
//   double _orlat, _orlng;
//   bool load = true;
//   GoogleMapController mapController;

//   Future getInfo() async {
//     // รับค่า
//     _rec_order = ModalRoute.of(context).settings.arguments;

//     orid = _rec_order['or_id'];
//     _ordate = _rec_order['or_date'];
//     _ortime = _rec_order['or_time'];
//     _ornum = _rec_order['or_num'];
//     _orstatus = _rec_order['or_status'];
//     _oraddress = _rec_order['or_address'];
//     _orlat = _rec_order['or_lat'];
//     _orlng = _rec_order['or_lng'];
//   }

//     Future getPrefs() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     token = prefs.getString('token');
//     // psId = prefs.getInt('psid');
//     print('token = $token');
//     print('orid = $orid');
//   }

//   //Delete
//   Future<void> _cancelorder(Map<String, dynamic> values) async {
//     var url = '${Connectapi().domain}/deleteperson/$orid';
//     var response = await http.delete(Uri.parse(url),
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//         body: convert.jsonEncode(values));
//     print(values);
//     if (response.statusCode == 200) {
//       print('Delete Success!');
//     } else {
//       print('Delete Fail!!');
//     }
//   }

//   Future<void> _getOrImage() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     token = prefs.getString('token');
//     // var uId = prefs.getInt('id');
//     // print('uId = $uId');
//     print('token = $token');
//     var url = '${Connectapi().domain}/getorderimage/$orid';
//     //conect
//     var response = await http.get(Uri.parse(url), headers: {
//       'Connect-type': 'application/json',
//       'Accept': 'application/json',
//       'Authorization': 'Bearer $token',
//     });
//     //check response
//     if (response.statusCode == 200) {
//       //แปลงjson ให้อยู่ในรูปแบบ model members
//       OrderImage images =
//           OrderImage.fromJson(convert.jsonDecode(response.body));
//       //รับค่า ข้อมูลทั้งหมดไว้ในตัวแปร
//       setState(() {
//         _orImg = images.getorderimage;
//         load = false;
//       });
//     }
//   }

//   Future<Null> findLatLan() async {
//     Position position = await findPosition();
//     setState(() {
//       _orlat = position.latitude;
//       _orlng = position.longitude;
//       load = false;
//     });
//     print('lat = $_orlat, lng = $_orlng, load = $load');
//   }

//   Future<Position> findPosition() async {
//     try {
//       userLocation = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.best);
//     } catch (e) {
//       userLocation = null;
//     }
//     return userLocation;
//   }

//   void _onMapCreated(GoogleMapController controller) {
//     // controller.setMapStyle(Utils.mapStyle);
//     setState(() {
//       _markers.add(
//         Marker(
//           markerId: MarkerId('id'),
//           position: LatLng(_orlat, _orlng),
//         ),
//       );
//     });
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _getOrImage();
//     // findLatLan();
//   }

//   @override
//   Widget build(BuildContext context) {
//     getInfo();
//     getPrefs();
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'แสดงออเดอร์',
//           style: TextStyle(color: Colors.black),
//         ),
//         backgroundColor: Colors.amber,
//       ),
//       backgroundColor: Colors.grey[300],
//       body: load ? ShowProgress() : buildCenter(),
//     );
//   }

//   Center buildCenter() {
//     DateTime orDate = DateTime.parse(_ordate);
//     return Center(
//       child: Padding(
//         padding: EdgeInsets.all(5.0),
//         child: Form(
//           key: _formkey,
//           child: Center(
//             child: Column(
//               children: [
//                 Card(
//                   // color: Colors.grey[200],
//                   child: Container(
//                     // alignment: Alignment.topLeft,
//                     padding: EdgeInsets.all(10),
//                     child: Column(
//                       children: [
//                         Column(
//                           children: [
//                             ...ListTile.divideTiles(
//                               color: Colors.grey,
//                               tiles: [
//                                 Container(
//                                   width: 400,
//                                   height: 200,
//                                   child: _checkImage(_orImg.orImg),
//                                 ),
//                                 // ListTile(
//                                 //   // leading: Icon(Icons.person,size: 30,),
//                                 //   title: Text('ออเดอร์ที่',
//                                 //       style: TextStyle(
//                                 //           fontSize: 15, color: Colors.blue)),
//                                 //   subtitle: Text(' ${_orid}',
//                                 //       style: TextStyle(
//                                 //           fontSize: 19, color: Colors.black87)),
//                                 // ),
//                                 ListTile(
//                                   // leading: Icon(Icons.person_outline,size: 30,),
//                                   title: Text('วันที่',
//                                       style: TextStyle(
//                                           fontSize: 15, color: Colors.blue)),
//                                   subtitle: Text('${formatter.format(orDate)}',
//                                       style: TextStyle(
//                                           fontSize: 19, color: Colors.black87)),
//                                 ),
//                                 ListTile(
//                                   // leading: Icon(Icons.person_outline,size: 30,),
//                                   title: Text('เวลา',
//                                       style: TextStyle(
//                                           fontSize: 15, color: Colors.blue)),
//                                   subtitle: Text('${_ortime}',
//                                       style: TextStyle(
//                                           fontSize: 19, color: Colors.black87)),
//                                 ),
//                                 ListTile(
//                                   // leading: Icon(Icons.phone,size: 30,),
//                                   title: Text('จำนวน',
//                                       style: TextStyle(
//                                           fontSize: 15, color: Colors.blue)),
//                                   subtitle: Text('${_ornum}',
//                                       style: TextStyle(
//                                           fontSize: 19, color: Colors.black87)),
//                                 ),
//                                 ListTile(
//                                   // leading: Icon(Icons.email,size: 30,),
//                                   title: Text('สถานะ',
//                                       style: TextStyle(
//                                           fontSize: 15, color: Colors.blue)),
//                                   subtitle: _statusApprove(context, _orstatus),
//                                 ),
//                                 ListTile(
//                                   // leading: Icon(Icons.email,size: 30,),
//                                   title: Text('ที่อยู่',
//                                       style: TextStyle(
//                                           fontSize: 15, color: Colors.blue)),
//                                   subtitle: Text('${_oraddress}',
//                                       style: TextStyle(
//                                           fontSize: 19, color: Colors.black87)),
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                               ],
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                   elevation: 10,
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // Widget ShowMap() {
//   //   return SizedBox(
//   //     width: 250,
//   //     child: OutlineButton(
//   //       child: Text('ตำแหน่งที่อยู่',
//   //           style: TextStyle(
//   //             fontSize: 14,
//   //           )),
//   //       onPressed: () {
//   //         Navigator.push(context, MaterialPageRoute(builder: (context) {
//   //           return Container(
//   //             margin: EdgeInsets.all(2),
//   //             color: Colors.black45,
//   //             height: 380,
//   //             child: GoogleMap(
//   //                 markers: _markers,
//   //                 onMapCreated: _onMapCreated,
//   //                 initialCameraPosition: CameraPosition(
//   //                   target: LatLng(_orlat, _orlng),
//   //                   zoom: 17,
//   //                 )),
//   //           );
//   //         }));
//   //       },
//   //     ),
//   //   );
//   // }

//   //  Widget btncancel() {
//   //     return SizedBox(
//   //       width : 250,
//   //       height: 40,
//   //       child: RaisedButton(
//   //         child: Text('ยกเลิกรายการส่ง',
//   //         style: TextStyle(color: Colors.white, fontSize: 18),),
//   //         color: Colors.redAccent,
//   //         onPressed: () {
//   //          return showDialog(
//   //       context: context,
//   //       builder: (_) => AlertDialog(
//   //             title: Row(
//   //               children: [
//   //                 Icon(
//   //                   Icons.cancel_sharp,
//   //                   size: 30,
//   //                   color: Colors.red,
//   //                 ),
//   //                 Expanded(
//   //                   child: Text('ต้องการยกเลิกรายการส่ง'),
//   //                 ),
//   //               ],
//   //             ),
//   //             actions: <Widget>[
//   //               TextButton(
//   //                 child: Text(
//   //                   'ไม่ใช่',
//   //                   style: TextStyle(fontSize: 18),
//   //                 ),
//   //                 onPressed: () => Navigator.pop(context, '/personlist'),
//   //               ),
//   //               TextButton(
//   //                 child: Text(
//   //                   'ใช่',
//   //                   style: TextStyle(fontSize: 18),
//   //                 ),
//   //                 onPressed: () {
//   //                   Map<String, dynamic> values = Map();
//   //                   values['or_id'] = orid;

//   //                   _cancelorder(values);
//   //                   int count = 0;
//   //                   Navigator.of(context).popUntil((_) => count++ >= 2);
//   //                 },
//   //               ),
//   //             ],
//   //           )
//   //           );
//   //         },
//   //         ),
//   //     );
//   // }

//   Widget _checkImage(imageName) {
//     Widget child;
//     print('Imagename : $imageName');
//     if (imageName != null
//         // || imageName == ''
//         ) {
//       child = Image.network('${Connectapi().orImageDomain}$imageName');
//     } else {
//       child = Image.asset('assets/images/noimg.png');
//     }
//     return new Container(child: child);
//   }

//   Widget _statusApprove(BuildContext context, orStatus) {
//     Widget child;
//     if (orStatus != '1') {
//       child =
//           Text(_sTATUS1, style: TextStyle(fontSize: 16, color: Colors.orange[900]));
//     } else {
//     }
//     return new Container(child: child);
//   }
// } //class