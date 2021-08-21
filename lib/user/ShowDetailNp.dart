import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:google_fonts/google_fonts.dart';
// import 'package:userr/widgets/bottom_container.dart';

class ShowDetailNp extends StatefulWidget {
  @override
  _ShowDetailNpState createState() => _ShowDetailNpState();
}

class _ShowDetailNpState extends State<ShowDetailNp> {
  // final _npId = GlobalKey<FormState>();
  var _npName;
  var _npPhone;
  var _npEmail;
  var _npAdress;
  var _npDistrict;
  var _npProvince;
  // var _fachome;
  // var _facsub;
  // var _facdistrict;
  // var _facprovince;
  // var _facdetel;

  Map<String, dynamic> _rec_member;
  var npId;
  var token;

  Future getDataNp() {
    _rec_member = ModalRoute.of(context).settings.arguments;
    npId = _rec_member['id']; 
    _npName = _rec_member['np_name'];
    _npPhone = _rec_member['np_phone'];
    _npEmail = _rec_member['np_email'];
    _npAdress = _rec_member['np_adress'];
    _npDistrict = _rec_member['np_district'];
    _npProvince = _rec_member['np_province'];
    // _fachome = _rec_member['ac_home'];
    // _facsub = _rec_member['ac_sub'];
    // _facdistrict = _rec_member['ac_district'];
    // _facprovince = _rec_member['ac_province'];
    // _facdetel = _rec_member['ac_detel'];
  }

  @override
  Widget build(BuildContext context) {
    getDataNp();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      // backgroundColor: Theme.of(context).primaryColorDark,
      body: Container(
        child: ListView(
          padding: EdgeInsets.all(10), // todo ระยะห่างจากขอบจอ !!
          children: [
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ชื่อ-นามสกุล',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Text(
                  '${_npName}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Divider(
              height: 20,
              thickness: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'เบอร์โทร',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Text(
                  '${_npPhone}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Divider(
              height: 20,
              thickness: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'E-mail',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Text(
                  '${_npEmail}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Divider(
              height: 20,
              thickness: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'เพศ',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Text(
                  '${_npAdress}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Divider(
              height: 20,
              thickness: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'อายุ',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Text(
                  '${_npDistrict}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Divider(
              height: 20,
              thickness: 2,
            ),
            // frmp4()
          ],
        ),
      ),
    );
  }
}
