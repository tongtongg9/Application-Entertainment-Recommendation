import 'package:flutter/material.dart';
import 'package:my_finalapp1/model/Connectapi.dart';
import 'package:my_finalapp1/model/Member.dart';
import 'package:my_finalapp1/widget/colors.dart';
import 'package:my_finalapp1/widget/custom_back_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ffi';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class ShowDataUser extends StatefulWidget {
  @override
  _ShowDataUserState createState() => _ShowDataUserState();
}

class _ShowDataUserState extends State<ShowDataUser> {
  String userId;
  UserInfo udata;
  //connect server api
  Future<Void> _getInfoUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var userId = prefs.getInt('id');
    print('uId = $userId');
    print('token = $token');
    var url = '${Connectapi().domain}/getprofileuser/$userId';
    //conect
    var response = await http.get(Uri.parse(url), headers: {
      'Connect-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    //check response
    if (response.statusCode == 200) {
      //แปลงjson ให้อยู่ในรูปแบบ model members
      UserMember members =
          UserMember.fromJson(convert.jsonDecode(response.body));
      //รับค่า ข้อมูลทั้งหมดไว้ในตัวแปร
      setState(() {
        udata = members.info;
      });
    }
  }

  Future onGoBack(dynamic value) {
    setState(() {
      _getInfoUser();
    });
  }

  @override
  void initState() {
    // TODO implement initState
    super.initState();
    //call _getAPI
    _getInfoUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ข้อมูลส่วนตัว',
        ),
        leading: CustomBackButton(
          tapBack: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            iconSize: 20,
            onPressed: () {
              Navigator.pushNamed(context, '/editdataUser', arguments: {
                'user_id': udata.userId,
                'user_username': udata.userUsername,
                'user_password': udata.userPassword,
                'user_name': udata.userName,
                'user_lastname': udata.userLastname,
                'user_phone': udata.userPhone,
                'user_email': udata.userEmail,
                'user_gender': udata.userGender,
                'user_bday': udata.userBday,
              });
              print(udata.userName);
              print(udata.userUsername);
              print(udata.userPassword);
              print(udata.userLastname);
              print(udata.userPhone);
              print(udata.userEmail);
              print(udata.userGender);
              print(udata.userBday);
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20), // todo ระยะห่างจากขอบจอ !!
        child: Column(
          children: [
            profilePic(), //? -- > Profile Picture
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/upload');
              },
              child: Text(
                'เปลี่ยนรูปโปร์ไฟล์',
                style: TextStyle(color: tPimaryColor),
              ),
            ),
            Divider(
              thickness: 2,
              color: Colors.black12,
            ),
            SizedBox(height: 25),
            Row(
              children: [
                Infotype(
                  type: 'ชื่อผู้ใช้',
                ),
                Infodata(
                  data: '${udata.userUsername}',
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
                  data: '${udata.userName} ${udata.userLastname}',
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
                  data: '${udata.userPhone}',
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
                  data: '${udata.userEmail}',
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
                  data: '${udata.userGender}',
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
                  data: '${udata.userBday}',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ? Proile Picture
  SizedBox profilePic() {
    return SizedBox(
      height: 100,
      width: 100,
      child: Stack(
        overflow: Overflow.visible,
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: imgsuser(),
          ),
        ],
      ),
    );
  } //! >> class Proile Picture

  Widget imgsuser() {
    Widget child;
    if (udata.userImg != null) {
      child = ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Image.network(
          '${Connectapi().domainimguser}${udata.userImg}',
          fit: BoxFit.cover,
        ),
      );
    } else {
      child = Image.asset(
        'assets/images/person.png',
        fit: BoxFit.cover,
      );
    }
    print('Imagename : $udata.userImg');
    return new ClipRRect(child: child);
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
              color: tTextColor,
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
            color: tTextColor,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
