// import 'package:date_field/date_field.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert' as convert;
// import 'package:intl/intl.dart';

// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:userr/model/ConnectAPI.dart';

// class ActivityFrom extends StatefulWidget {
//   @override
//   _ActivityFromState createState() => _ActivityFromState();
// }

// class _ActivityFromState extends State<ActivityFrom> {
//   final _formkey = GlobalKey<FormState>();
//   final _fname = TextEditingController();
//   final _ftime = TextEditingController();
//   final _funit = TextEditingController();
//   // final _flatijood = TextEditingController();
//   // final _flongtijood = TextEditingController();
//   final _fhome = TextEditingController();
//   final _fsub = TextEditingController();
//   final _fdis = TextEditingController();
//   final _fprovin = TextEditingController();
//   final _fdetel = TextEditingController();

//   String _chosenValue;
//   DateTime selectedData;

//   var uId;
//   var token;

//   // var myFormat = DateFormat('d-MM-yyyy');

//   Future getAc() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     token = prefs.getString('token');
//     uId = prefs.getInt('id');
//     print('uId = $uId');
//     print('token = $token');
//   }

//   void _selectactivity(Map<String, dynamic> values) async {
//     String url = '${Connectapi().domain}/addactivity/$uId';
//     var response = await http.post(url,
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//         body: convert.jsonEncode(values));

//     if (response.statusCode == 200) {
//       print('Activity Success');

//       // Navigator.pop(context, true);
//     } else {
//       print('Activity not Success!!');
//       print(response.body);
//     }
//   }

//   void _showbar() {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text(
//         '\u2611 สร้างกิจกรรมสำเร็จ !',
//         style: GoogleFonts.kanit(color: Colors.black),
//       ),
//       backgroundColor: Colors.greenAccent.shade400,
//     ));
//   }

//   void _showbarnot() {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text(
//         '\u26A0 สร้างกิจกรรมไม่สำเร็จ !!!',
//         style: GoogleFonts.kanit(color: Colors.black),
//       ),
//       backgroundColor: Colors.orangeAccent,
//     ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     getAc();
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           'สร้างกิจกรรม',
//           style: GoogleFonts.kanit(),
//         ),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(5.0),
//         child: Form(
//           key: _formkey,
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Text(
//                           'ชื่อกิจกรรม',
//                           style: GoogleFonts.kanit(
//                             fontSize: 16,
//                           ),
//                         ),
//                         Text(
//                           '*',
//                           style: GoogleFonts.kanit(
//                             fontSize: 16,
//                             color: Colors.red,
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     SizedBox(
//                       width: double.infinity,
//                       height: 60,
//                       child: TextField(
//                         style: GoogleFonts.kanit(),
//                         controller: _fname,
//                         // obscureText: obsureText,
//                         decoration: InputDecoration(
//                           contentPadding:
//                               EdgeInsets.symmetric(vertical: 0, horizontal: 10),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                               color: Colors.blue,
//                             ),
//                           ),
//                           border: OutlineInputBorder(
//                               borderSide:
//                                   BorderSide(color: Colors.red.shade800)),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 // SizedBox(height: 5,),

//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Text(
//                           'จำนวนคนที่ต้องการ',
//                           style: GoogleFonts.kanit(
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     SizedBox(
//                       width: 110,
//                       height: 60,
//                       child: TextField(
//                         style: GoogleFonts.kanit(),
//                         controller: _funit,
//                         // obscureText: obsureText,
//                         decoration: InputDecoration(
//                           contentPadding:
//                               EdgeInsets.symmetric(vertical: 0, horizontal: 10),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                               color: Colors.blue,
//                             ),
//                           ),
//                           border: OutlineInputBorder(
//                               borderSide:
//                                   BorderSide(color: Colors.red.shade800)),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 frm1(),
//                 SizedBox(height: 😎,

//                 Divider(
//                   height: 20,
//                   thickness: 1,
//                   indent: 20,
//                   endIndent: 20,
//                 ),

//                 frm2(),
//                 SizedBox(height: 😎,
//                 Divider(
//                   height: 20,
//                   thickness: 1,
//                 ),
//                 frm3(),
//                 SizedBox(height: 😎,
//                 frm4(),
//                 SizedBox(height: 😎,
//                 Divider(
//                   height: 20,
//                   thickness: 1,
//                 ),
//                 frm5(),
//                 SizedBox(height: 10),
//                 btssubmit(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget frm1() {
//     return Row(
//       children: <Widget>[
//         // Container(
//         //   width: 300.0,
//         //   padding: EdgeInsets.all(5.0),
//         //   child: TextFormField(
//         //     style: GoogleFonts.kanit(),
//         //     validator: (value) {
//         //       if (value.isEmpty) {
//         //         return '\u26A0 กรุณากรอกชื่อกิจกรรม';
//         //       }
//         //     },
//         //     controller: _fname,
//         //     decoration: InputDecoration(
//         //         fillColor: Colors.black12,
//         //         filled: true,
//         //         labelText: 'ชื่อกิจกรรม',
//         //         border: OutlineInputBorder(
//         //             borderRadius: BorderRadius.circular(5.0))),
//         //   ),
//         // ),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Text(
//                   'ชื่อกิจกรรม',
//                   style: GoogleFonts.kanit(
//                     fontSize: 16,
//                   ),
//                 ),
//                 Text(
//                   '*',
//                   style: GoogleFonts.kanit(
//                     fontSize: 16,
//                     color: Colors.red,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             SizedBox(
//               width: 285,
//               height: 60,
//               child: TextField(
//                 style: GoogleFonts.kanit(),
//                 controller: _fname,
//                 // obscureText: obsureText,
//                 decoration: InputDecoration(
//                   contentPadding:
//                       EdgeInsets.symmetric(vertical: 0, horizontal: 10),
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Colors.blue,
//                     ),
//                   ),
//                   border: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.red.shade800)),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(
//           width: 5,
//         ),
//         Padding(
//           padding: EdgeInsets.only(top: 16),
//           child: Container(
//             width: 150.0,
//             height: 48.0,
//             // color: Colors.black12,
//             padding: EdgeInsets.all(5),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(5.0),
//               // color: Colors.cyan,
//               border: Border.all(
//                 color: Colors.blue,
//               ),
//             ),
//             child: DropdownButtonHideUnderline(
//               child: DropdownButton<String>(
//                 value: _chosenValue,
//                 // elevation: 5,
//                 // style: GoogleFonts.kanit(color: Colors.black),
//                 items: <String>[
//                   'จิตอาสาพัฒนา',
//                   'จิตอาสาภัยพิบัติ',
//                   'จิตอาสาเฉพาะกิจ',
//                 ].map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//                 hint: Text(
//                   "ประเภทกิจกรรม",
//                   // style: GoogleFonts.kanit(
//                   //   color: Colors.black,
//                   //   fontSize: 14,
//                   // ),
//                 ),
//                 onChanged: (String value) {
//                   setState(() {
//                     _chosenValue = value;
//                   });
//                 },
//               ),
//             ),
//           ),
//         ),
//         // SizedBox(
//         //   width: 10,
//         // ),
//         // Column(
//         //   crossAxisAlignment: CrossAxisAlignment.start,
//         //   children: [
//         //     Row(
//         //       children: [
//         //         Text(
//         //           'จำนวนคนที่ต้องการ',
//         //           style: GoogleFonts.kanit(
//         //             fontSize: 14,
//         //           ),
//         //         ),
//         //       ],
//         //     ),
//         //     SizedBox(
//         //       height: 5,
//         //     ),
//         //     SizedBox(
//         //       width: 110,
//         //       height: 60,
//         //       child: TextField(
//         //         style: GoogleFonts.kanit(),
//         //         controller: _funit,
//         //         // obscureText: obsureText,
//         //         decoration: InputDecoration(
//         //           contentPadding:
//         //               EdgeInsets.symmetric(vertical: 0, horizontal: 10),
//         //           enabledBorder: OutlineInputBorder(
//         //             borderSide: BorderSide(
//         //               color: Colors.blue,
//         //             ),
//         //           ),
//         //           border: OutlineInputBorder(
//         //               borderSide: BorderSide(color: Colors.red.shade800)),
//         //         ),
//         //       ),
//         //     ),
//         //   ],
//         // ),
//       ],
//     );
//   }

//   Widget frm2() {
//     DateFormat("dd-MM-yyyy").format(DateTime.now());
//     return Row(
//       children: <Widget>[
//         Container(
//           width: 165.0,
//           padding: EdgeInsets.all(5.0),
//           child: TextFormField(
//             // style: GoogleFonts.kanit(),
//             validator: (value) {
//               if (value.isEmpty) {
//                 return '\u26A0 กรุณากรอกเวลาทำกิจกรรม';
//               }
//             },
//             controller: _ftime,
//             decoration: InputDecoration(
//                 fillColor: Colors.black12,
//                 filled: true,
//                 labelText: 'เวลาทำกิจกรรม',
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(5.0),
//                     ),
//                     ),
//           ),
//         ),
//         Container(
//           width: 150.0,
//           height: 58.0,
//           // color: Colors.black12,
//           // decoration: BoxDecoration(
//           //     borderRadius: BorderRadius.circular(5.0),
//           //     // color: Colors.cyan,
//           //     border: Border.all(
//           //       color: Colors.blue,
//           //     ),
//           //   ),
//           child: DateField(
//             onDateSelected: (DateTime value) {
//               setState(() {
//                 selectedData = value;
//               });
//             },
//             decoration: InputDecoration(
//               border: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.yellow),
//               ),
//             ),
//             label: 'ว/ด/ป',
//             dateFormat: DateFormat("dd-MM-yyyy"),
//             selectedDate: selectedData,
//           ),
//         ),
//         Container(
//           width: 120.0,
//           padding: EdgeInsets.all(5.0),
//           child: TextFormField(
//             style: GoogleFonts.kanit(),
//             validator: (value) {
//               if (value.isEmpty) {
//                 return '\u26A0 กรุณากรอกจำนวนคน';
//               }
//             },
//             controller: _funit,
//             decoration: InputDecoration(
//                 fillColor: Colors.black12,
//                 filled: true,
//                 labelText: 'จำนวนคน',
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(5.0))),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget frm3() {
//     return Row(
//       children: <Widget>[
//         Container(
//           width: 220.0,
//           padding: EdgeInsets.all(5.0),
//           child: TextFormField(
//             style: GoogleFonts.kanit(),
//             validator: (value) {
//               if (value.isEmpty) {
//                 return '\u26A0 กรุณากรอกบ้าน';
//               }
//             },
//             controller: _fhome,
//             decoration: InputDecoration(
//                 fillColor: Colors.black12,
//                 filled: true,
//                 labelText: 'บ้าน',
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(5.0))),
//           ),
//         ),
//         Container(
//           width: 220.0,
//           padding: EdgeInsets.all(5.0),
//           child: TextFormField(
//             style: GoogleFonts.kanit(),
//             validator: (value) {
//               if (value.isEmpty) {
//                 return '\u26A0 กรุณากรอกตำบล';
//               }
//             },
//             controller: _fsub,
//             decoration: InputDecoration(
//                 fillColor: Colors.black12,
//                 filled: true,
//                 labelText: 'ตำบล',
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(5.0))),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget frm4() {
//     return Row(
//       children: <Widget>[
//         Container(
//           width: 220.0,
//           padding: EdgeInsets.all(5.0),
//           child: TextFormField(
//             style: GoogleFonts.kanit(),
//             validator: (value) {
//               if (value.isEmpty) {
//                 return '\u26A0 กรุณากรอกอำเภอ';
//               }
//             },
//             controller: _fdis,
//             decoration: InputDecoration(
//                 fillColor: Colors.black12,
//                 filled: true,
//                 labelText: 'อำเภอ',
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(5.0))),
//           ),
//         ),
//         Container(
//           width: 220.0,
//           padding: EdgeInsets.all(5.0),
//           child: TextFormField(
//             style: GoogleFonts.kanit(),
//             validator: (value) {
//               if (value.isEmpty) {
//                 return '\u26A0 กรุณากรอกจังหวัด';
//               }
//             },
//             controller: _fprovin,
//             decoration: InputDecoration(
//                 fillColor: Colors.black12,
//                 filled: true,
//                 labelText: 'จังหวัด',
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(5.0))),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget frm5() {
//     return Container(
//       // height: 200.0,
//       width: 450.0,
//       padding: EdgeInsets.all(5.0),
//       child: TextField(
//         style: GoogleFonts.kanit(),
//         maxLines: 5,
//         // validator: (value) {
//         //   if (value.isEmpty) {
//         //     return '\u26A0 กรุณากรอกรายละเอียด';
//         //   }
//         // },
//         controller: _fdetel,
//         decoration: InputDecoration(
//             fillColor: Colors.black12,
//             filled: true,
//             labelText: 'รายละเอียด',
//             border:
//                 OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
//       ),
//     );
//   }

//   //ปุ่มบันทึก--------------------------------------------------
//   Widget btssubmit() {
//     return RaisedButton(
//       onPressed: () {
//         Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);

//         if (_formkey.currentState.validate()) {
//           Map<String, dynamic> valuse = Map();
//           valuse['ac_name'] = _fname.text;
//           valuse['ac_type'] = _chosenValue.toString();
//           valuse['ac_time'] = _ftime.text;
//           valuse['ac_date'] = selectedData.toString();
//           valuse['ac_number'] = _funit.text;
//           valuse['ac_home'] = _fhome.text;
//           valuse['ac_sub'] = _fsub.text;
//           valuse['ac_district'] = _fdis.text;
//           valuse['ac_province'] = _fprovin.text;
//           valuse['ac_detel'] = _fdetel.text;

//           _selectactivity(valuse);
//           _showbar();
//         } else {
//           _showbarnot();
//         }
//       },
//       child: Text(
//         'สร้างกิจกรรม',
//         style: GoogleFonts.kanit(),
//       ),
//       color: Colors.cyanAccent,
//     );
//   }
//   Widget frmdate() {
//     DateFormat("dd-MM-yyyy").format(DateTime.now());
//     return Column(
//       children: <Widget>[
//         Row(
//           children: [
//             Text(
//               'วันที่ในการทำกิจกรรม',
//               style: TextStyle(
//                 fontSize: 16,
//               ),
//             ),
//             Text(
//               '*',
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.red,
//               ),
//             ),
//           ],
//         ),
//         Row(
//           children: [
//             Container(
//               width: 150.0,
//               height: 56.7,
//               // color: Colors.black12,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(5.0),
//                 // color: Colors.cyan,
//                 border: Border.all(
//                   color: Colors.blue,
//                 ),
//               ),
//               child: DateField(
//                 onDateSelected: (DateTime value) {
//                   setState(() {
//                     selectedData = value;
//                   });
//                 },
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                       // borderSide: BorderSide(color: Colors.yellow),
//                       ),
//                 ),
//                 // label: 'ว/ด/ป',
//                 dateFormat: DateFormat("dd-MM-yyyy"),
//                 selectedDate: selectedData,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }



// fsafafffasffffas