import 'package:flutter/material.dart';
import 'package:my_finalapp1/model/Connectapi.dart';
import 'package:my_finalapp1/model/Member.dart';
import 'package:my_finalapp1/widget/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ffi';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class ShowDataOw extends StatefulWidget {
  @override
  _ShowDataOwState createState() => _ShowDataOwState();
}

class _ShowDataOwState extends State<ShowDataOw> {
  String owId;
  OwnerInfo odata;
  //connect server api
  Future<Void> _getInfoOw() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var owId = prefs.getInt('id');
    print('uId = $owId');
    print('token = $token');
    var url = '${Connectapi().domain}/getprofileowner/$owId';
    //conect
    var response = await http.get(Uri.parse(url), headers: {
      'Connect-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    //check response
    if (response.statusCode == 200) {
      //แปลงjson ให้อยู่ในรูปแบบ model members
      OwnerMember members =
          OwnerMember.fromJson(convert.jsonDecode(response.body));
      //รับค่า ข้อมูลทั้งหมดไว้ในตัวแปร
      setState(() {
        odata = members.info;
      });
    }
  }

  @override
  void initState() {
    // TODO implement initState
    super.initState();
    //call _getAPI
    _getInfoOw();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ข้อมูลส่วนตัว',
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.pushNamed(context, '/oweditdata', arguments: {
                'ow_id': odata.owId,
                'ow_username': odata.owUsername,
                'ow_password': odata.owPassword,
                'ow_name': odata.owName,
                'ow_lastname': odata.owLastname,
                'ow_phone': odata.owPhone,
                'ow_email': odata.owEmail,
                'ow_gender': odata.owGender,
                'ow_bday': odata.owBday,
              });
              print(odata.owId);
              print(odata.owUsername);
              print(odata.owPassword);
              print(odata.owName);
              print(odata.owLastname);
              print(odata.owPhone);
              print(odata.owEmail);
              print(odata.owGender);
              print(odata.owBday);
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20), // todo ระยะห่างจากขอบจอ !!
        child: Column(
          children: [
            // profilePic(), //? -- > Profile Picture
            // TextButton(
            //   onPressed: () {
            //     Navigator.pushNamed(context, '/upload');
            //   },
            //   child: Text(
            //     'เปลี่ยนรูปโปร์ไฟล์',
            //     style: TextStyle(color: tPimaryColor),
            //   ),
            // ),
            // Divider(
            //   thickness: 3,
            //   color: Colors.white10,
            // ),
            SizedBox(height: 25),
            Row(
              children: [
                Infotype(
                  type: 'ชื่อผู้ใช้',
                ),
                Infodata(
                  data: '${odata.owUsername}',
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Infotype(
                  type: 'ชื่อ-สกุล',
                ),
                Infodata(
                  data: '${odata.owName} ${odata.owLastname}',
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Infotype(
                  type: 'เบอร์โทร',
                ),
                Infodata(
                  data: '${odata.owPhone}',
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Infotype(
                  type: 'Email',
                ),
                Infodata(
                  data: '${odata.owEmail}',
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Infotype(
                  type: 'เพศ',
                ),
                Infodata(
                  data: '${odata.owGender}',
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Infotype(
                  type: 'วันเกิด',
                ),
                Infodata(
                  data: '${odata.owBday}',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} //! main class

class Infotype extends StatelessWidget {
  const Infotype({
    Key key,
    @required this.type,
  }) : super(key: key);

  final String type;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      child: Row(
        children: [
          Text(
            type,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class Infodata extends StatelessWidget {
  const Infodata({
    Key key,
    @required this.data,
  }) : super(key: key);

  final String data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          data,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
