import 'package:flutter/material.dart';
import 'package:my_finalapp1/model/Connectapi.dart';
import 'package:my_finalapp1/widget/colors.dart';
import 'package:my_finalapp1/widget/custom_back_button.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';

class ReviewPage extends StatefulWidget {
  // ReviewPage({Key? key}) : super(key: key);

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final _user_id = GlobalKey<FormState>();
  final _rev_topic = TextEditingController();
  final _rev_detail = TextEditingController();

  var userID;
  var token;

  Future getNP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    userID = prefs.getInt('id');
    print('userID = $userID');
    print('token = $token');
  }

  void addReviews(Map<String, dynamic> values) async {
    // var url = 'http://192.168.0.8:8888/register';
    String url = '${Connectapi().domain}/addreviews/$userID';
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

  Future getDataNp() {
    _rec_member = ModalRoute.of(context).settings.arguments;
    _npId = _rec_member['_npId'];
  }

  @override
  Widget build(BuildContext context) {
    getDataNp();
    return Scaffold(
      appBar: AppBar(
        title: Text('รีวิวให้ร้านนี้'),
        leading: CustomBackButton(
          tapBack: () {
            Navigator.pop(context);
          },
        ),
        // actions: [
        //   IconButton(
        //     icon: Icon(
        //       Icons.check,
        //       color: Theme.of(context).primaryColor,
        //     ),
        //     onPressed: save,
        //   ),
        // ],
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: SafeArea(
          child: Column(
            key: _user_id,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'หัวเรื่องรีวิว',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
                    return 'กรุณากรอกหัวเรื่องรีวิว';
                  }
                },
                controller: _rev_topic,
                style: TextStyle(
                  // color: Theme.of(context).primaryColor,
                  color: Colors.white,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: tBGDeepColor,
                  hintText: 'พูดสรุปถึงร้านนี้',
                  focusColor: tGreyColor,
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.white54,
                  ),
                  // icon: ImageIcon(
                  //   new AssetImage('assets/icons/user.png'),
                  //   color: Theme.of(context).primaryColor,
                  //   // size: 30,
                  // ),
                ),
              ),
              SizedBox(height: 30), //! <<<<
              Row(
                children: [
                  Text(
                    'เนื้อหารีวิว',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
                    return 'กรุณากรอกเนื้อหารีวิว';
                  }
                },
                controller: _rev_detail,
                style: TextStyle(
                  // color: Theme.of(context).primaryColor,
                  color: Colors.white,
                  fontSize: 16,
                ),
                maxLines: 6,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: tBGDeepColor,
                  hintText:
                      'เล่ารายละเอียดตรงนนี้เลย เขียนรีวิวเหมือนเล่าให้ฟังนะครับ',
                  focusColor: Colors.white54,
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.white54,
                  ),
                  // icon: ImageIcon(
                  //   new AssetImage('assets/icons/user.png'),
                  //   color: Theme.of(context).primaryColor,
                  //   // size: 30,
                  // ),
                ),
              ),
            ],
          ),
        ),
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

  Widget btnSummitReview() {
    return SizedBox(
      width: 425,
      // height: 50,
      child: RaisedButton(
        color: tPimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            'โพสต์',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
        onPressed: () {
          Map<String, dynamic> valuse = Map();
          // valuse['user_id'] = _user_id;
          valuse['np_id'] = _npId;
          valuse['rev_topic'] = _rev_topic.text;
          valuse['rev_detail'] = _rev_detail.text;

          print(_rev_topic.text);
          print(_rev_detail.text);

          addReviews(valuse);
          Navigator.pop(context, '/showdetailnp');
        },
      ),
    );
  }
}
