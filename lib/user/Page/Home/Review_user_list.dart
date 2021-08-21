// import 'package:flutter/material.dart';
// import 'package:my_finalapp1/model/Connectapi.dart';
// import 'package:my_finalapp1/model/Member.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert' as convert;
// import 'package:http/http.dart' as http;
// import 'dart:ffi';

// class ReviewList extends StatefulWidget {
//   // ReviewList({Key? key}) : super(key: key);

//   @override
//   _ReviewListState createState() => _ReviewListState();
// }

// class _ReviewListState extends State<ReviewList> {
//   List<Revlimit> datamembers = [];

//   var npId;
//   var token;

//   //connect server api
//   Future<Void> _getListReviewslimit() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     token = prefs.getString('token');
//     npId = prefs.getInt('id');
//     print('npId = $npId');
//     print('token = $token');
//     var url = '${Connectapi().domain}/getlistreviewslimit/$_npId';
//     //conect
//     var response = await http.get(Uri.parse(url), headers: {
//       'Connect-type': 'application/json',
//       'Accept': 'application/json',
//       'Authorization': 'Bearer $token',
//     });
//     //check response
//     if (response.statusCode == 200) {
//       //แปลงjson ให้อยู่ในรูปแบบ model members
//       ReviewListLimitmodel members =
//           ReviewListLimitmodel.fromJson(convert.jsonDecode(response.body));
//       //รับค่า ข้อมูลทั้งหมดไว้ในตัวแปร
//       setState(() {
//         datamembers = members.revlimit;
//         print(datamembers.length);
//         // load = false;
//       });
//     }
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     //call _getAPI
//     _getListReviewslimit();
//   }

//   @override
//   Widget build(BuildContext context) {
    
//     return ListView.builder(
//       // physics: ScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
//       // scrollDirection: Axis.vertical,
//       // shrinkWrap: true,
//       itemCount: datamembers.length,
//       itemBuilder: (context, index) {
//         return Padding(
//           padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
//           child: Container(
//             child: new FittedBox(
//               fit: BoxFit.cover,
//               child: Material(
//                 color: Theme.of(context).backgroundColor,
//                 borderRadius: BorderRadius.circular(15),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Container(
//                       width: MediaQuery.of(context).size.width,
//                       // height: 200,
//                       child: Padding(
//                         padding: const EdgeInsets.all(10),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             Container(
//                               child: Text(
//                                 "${datamembers[index].revTopic}",
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               child: Text(
//                                 "${datamembers[index].revDetail}",
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.normal,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     // Container(
//                     //   width: 200,
//                     //   height: 150,
//                     //   child: mynpPhotos(),
//                     // ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//         // ],
//       },
//     );

// // return Container(
//     //   width: double.infinity,
//     //   height: MediaQuery.of(context).size.height,
//     //   // color: Colors.white70,
//     //   child: Column(
//     //     mainAxisAlignment: MainAxisAlignment.start,
//     //     crossAxisAlignment: CrossAxisAlignment.start,
//     //     children: <Widget>[
//     //       new FittedBox(
//     //         child: Material(
//     //           color: Theme.of(context).backgroundColor,
//     //           elevation: 0,
//     //           borderRadius: BorderRadius.circular(15),
//     //           // shadowColor: ,
//     //           child: Row(
//     //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     //             crossAxisAlignment: CrossAxisAlignment.start,
//     //             children: <Widget>[
//     //               Container(
//     //                 width: MediaQuery.of(context).size.width,
//     //                 // height: MediaQuery.of(context).size.height,
//     //                 child: Padding(
//     //                   padding: const EdgeInsets.all(15),
//     //                   // child: mynpDetails(),
//     //                   child: Column(
//     //                     mainAxisAlignment: MainAxisAlignment.start,
//     //                     crossAxisAlignment: CrossAxisAlignment.start,
//     //                     children: <Widget>[
//     //                       // Padding(
//     //                       //   padding: const EdgeInsets.only(left: 20,bottom: 30),
//     //                       Container(
//     //                         child: Text(
//     //                           "ลองก่อน",
//     //                           style: TextStyle(
//     //                             color: Colors.white,
//     //                             fontSize: 16,
//     //                             fontWeight: FontWeight.bold,
//     //                           ),
//     //                         ),
//     //                       ),
//     //                     ],
//     //                   ),
//     //                 ),
//     //               ),
//     //             ],
//     //           ),
//     //         ),
//     //       ),
//     //     ],
//     //   ),
//     // );





//     // Container(
//     //   width: double.infinity,
//     //   height: 50,
//     //   color: Theme.of(context).backgroundColor,
//     // ),
//     // Container(
//     //   child: Column(
//     //     mainAxisAlignment: MainAxisAlignment.start,
//     //     crossAxisAlignment: CrossAxisAlignment.start,
//     //     children: <Widget>[
//     //       Text(
//     //         'About',
//     //         style: TextStyle(
//     //           color: Colors.white,
//     //           fontSize: 16,
//     //         ),
//     //       ),
//     //     ],
//     //   ),
//     // ),
//   }
// }
