import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_finalapp1/model/Connectapi.dart';
import 'package:my_finalapp1/model/model_get_data_user.dart';
import 'package:my_finalapp1/widget/colors.dart';
import 'package:my_finalapp1/widget/custom_back_button.dart';
import 'package:my_finalapp1/widget/loading_widget.dart';
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
  Infouser udata;
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
      DataUser members = DataUser.fromJson(convert.jsonDecode(response.body));
      //รับค่า ข้อมูลทั้งหมดไว้ในตัวแปร
      setState(() {
        udata = members.infouser;
      });
    }
  }

  Future onGoBack() {
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
    onGoBack();
  }

  var dateformate = DateFormat.yMMMd();

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
                  data: '${dateformate.format(DateTime.parse(udata.userBday))}',
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

  Widget imgsuser() => ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: CachedNetworkImage(
          key: UniqueKey(),
          imageUrl: '${Connectapi().domainimguser}${udata.userImg}',
          fit: BoxFit.cover,
          placeholder: (context, imageUrl) => ShowProgress().loading(),
          errorWidget: (context, imageUrl, error) =>
              Image.asset('assets/images/person.png'),
        ),
      );
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
