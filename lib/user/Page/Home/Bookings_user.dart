import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:my_finalapp1/model/Connectapi.dart';
import 'package:my_finalapp1/widget/colors.dart';
import 'package:my_finalapp1/widget/custom_back_button.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';

class ReservePage extends StatefulWidget {
  // ReservePage({Key? key}) : super(key: key);

  @override
  _ReservePageState createState() => _ReservePageState();
}

class _ReservePageState extends State<ReservePage> {
  final _user_id = GlobalKey<FormState>();
  final _book_detail = TextEditingController();

  int _seats = 1;

  void _incrementCount() {
    setState(() {
      _seats++;
    });
  }

  void _decrementCount() {
    if (_seats < 2) {
      return;
    }
    setState(() {
      _seats--;
    });
  }

  var userID;
  var token;

  DateTime _date;

  Future getNP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    userID = prefs.getInt('id');
    print('userID = $userID');
    print('token = $token');
  }

  void addBookings(Map<String, dynamic> values) async {
    // var url = 'http://192.168.0.8:8888/register';
    String url = '${Connectapi().domain}/addbookings/$userID';
    var response = await http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: convert.jsonEncode(values));

    if (response.statusCode == 200) {
      print('Register Success');
      // Navigator.pop(context, true);
    } else {
      print('Register not Success!!');
      print(response.body);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNP();
  }

  Map<String, dynamic> _rec_member;
  var _npId;
  var _npName;

  Future getDataNp() {
    _rec_member = ModalRoute.of(context).settings.arguments;
    _npId = _rec_member['_npId'];
    _npName = _rec_member['_npName'];
  }

  @override
  Widget build(BuildContext context) {
    getDataNp();
    return Scaffold(
      appBar: AppBar(
        title: Text('สำรองที่นั่ง'),
        leading: CustomBackButton(
          tapBack: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        // width: double.infinity,
        padding: EdgeInsets.all(20),
        child: SafeArea(
          child: Column(
            key: _user_id,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row(
              //   children: [
              //     Text(
              //       'สำรองที่นั่งร้าน ',
              //       style: TextStyle(
              //         fontSize: 18,
              //         fontWeight: FontWeight.bold,
              //         color: tTextColor,
              //       ),
              //     ),
              //     Text(
              //       _npName,
              //       style: TextStyle(
              //         fontSize: 18,
              //         fontWeight: FontWeight.bold,
              //         color: tTextColor,
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(height: 15),
              Row(
                children: [
                  Text(
                    'เลือกจำนวนที่นั่ง',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: tTextColor,
                    ),
                  ),
                  Text(
                    '*',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: tErrorColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(
                width: 120,
                // color: Colors.black54,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      //! ? -
                      onTap: () {
                        _decrementCount();
                      },
                      child: Container(
                        width: 30,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: tPimaryColor,
                          // color: Colors.white70,
                        ),
                        child: Icon(
                          Icons.remove_circle_sharp,
                          color: tTextWColor,
                          size: 18,
                        ),
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: tBGDeepColor,
                        // color: Colors.white70,
                      ),
                      child: Center(
                        child: Text(
                          _seats.toString(),
                          style: TextStyle(
                            color: tTextColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      //! ? +
                      onTap: () {
                        _incrementCount();
                      },
                      child: Container(
                        width: 30,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: tPimaryColor,
                          // color: Colors.white70,
                        ),
                        child: Icon(
                          Icons.add_circle_sharp,
                          color: tTextWColor,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30), //! <<<<
              Row(
                children: [
                  Text(
                    'รายละเอียดการสำรองที่นั่ง',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: tTextColor,
                    ),
                  ),
                  Text(
                    '*',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: tErrorColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'กรุณากรอกรายละเอียดการสำรองที่นั่ง';
                  }
                },
                controller: _book_detail,
                style: TextStyle(
                  // color: Theme.of(context).primaryColor,
                  color: tTextColor,
                  fontSize: 16,
                ),
                maxLines: 4,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: tBGDeepColor,
                  hintText: 'แจ้งรายละเอียดให้กับทางร้าน ${_npName} ',
                  focusColor: Colors.white54,
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: tTextGColor,
                  ),
                ),
              ),
              SizedBox(height: 30), //! <<<<
              Row(
                children: [
                  Text(
                    'วันที่และเวลาที่ต้องการสำรองที่นั่ง',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: tTextColor,
                    ),
                  ),
                  Text(
                    '*',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: tErrorColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              dateForm(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: tBGColor,
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
                btnSummitReview(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dateForm() {
    return SizedBox(
      width: 220,
      height: 65,
      child: DateTimeFormField(
        firstDate: DateTime.now(),
        onDateSelected: (DateTime value) {
          setState(() {
            _date = value;
          });
          print(value);
        },
        dateTextStyle: TextStyle(
          color: tGreyColor,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: tBGDeepColor,
          hintText: 'เลือกวันและเวลา',
          hintStyle: TextStyle(
            fontSize: 16,
            color: tTextGColor,
          ),
          // labelStyle: TextStyle(color: Theme.of(context).primaryColor),
        ),
        mode: DateTimeFieldPickerMode.dateAndTime,
      ),
    );
  }

  Widget btnSummitReview() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          primary: tPimaryColor,
        ),
        child: Text(
          'ยืนยัน',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        onPressed: () {
          Map<String, dynamic> valuse = Map();
          valuse['np_id'] = _npId;
          valuse['bk_seat'] = _seats.toString();
          valuse['bk_detail'] = _book_detail.text;
          valuse['bk_checkin_date'] = _date.toString();

          print(_date.toString());
          print(_seats.toString());
          print(_book_detail.text);

          addBookings(valuse);
          Navigator.pop(context, '/showdetailnp');
        },
      ),
    );
  }
}
