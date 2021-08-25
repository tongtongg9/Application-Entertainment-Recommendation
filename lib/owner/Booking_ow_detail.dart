import 'package:flutter/material.dart';
import 'package:my_finalapp1/widget/colors.dart';
import 'package:my_finalapp1/widget/custom_back_button.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:my_finalapp1/model/Connectapi.dart';

class BookingDetailow extends StatefulWidget {
  // BookingDetailow({Key? key}) : super(key: key);

  @override
  _BookingDetailowState createState() => _BookingDetailowState();
}

class _BookingDetailowState extends State<BookingDetailow> {
  var bkId;
  var bkSeat;
  var bkDetail;
  var bkBookingTime;
  var bkStatus;
  var npId;
  var npName;
  var userId;
  var userName;
  var userPhone;
  var userEmail;
  var owId;

  var token;

  Map<String, dynamic> _rec_member;

  var _bkId;
  var _bkSeat;
  var _bkDetail;
  var _bkBookingTime;
  var _bkStatus;
  var _npId;
  var _npName;
  var _userId;
  var _userName;
  var _userPhone;
  var _userEmail;
  var _owId;

  Future getDataNp() {
    _rec_member = ModalRoute.of(context).settings.arguments;
    _bkId = _rec_member['bk_id'];
    _bkSeat = _rec_member['bk_seat'];
    _bkDetail = _rec_member['bk_detail'];
    _bkBookingTime = _rec_member['bk_booking_time'];
    _bkStatus = _rec_member['bk_status'];
    _npId = _rec_member['np_id'];
    _npName = _rec_member['np_name'];
    _userId = _rec_member['user_id'];
    _userName = _rec_member['user_name'];
    _userPhone = _rec_member['user_phone'];
    _userEmail = _rec_member['user_email'];
    _owId = _rec_member['ow_id'];
    print(_bkId);
    // print(_npName);
    // _fachome = _rec_member['ac_home'];
    // _facsub = _rec_member['ac_sub'];
    // _facdistrict = _rec_member['ac_district'];
    // _facprovince = _rec_member['ac_province'];
    // _facdetel = _rec_member['ac_detel'];
  }

  String _updatestatus = '1';

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

  @override
  Widget build(BuildContext context) {
    getDataNp();
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Map<String, dynamic> valuse = Map();
          valuse['bk_status'] = _updatestatus;
          print(valuse);
          _update(valuse);
        },
        label: Text('เพิ่มร้านของคุณ'),
        backgroundColor: tPimaryColor,
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: Column(
                children: [
                  Text(
                    '${_bkDetail}',
                  ),
                  Text(
                    '${_bkSeat}',
                  ),
                  Text(
                    '${_bkStatus}',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
