import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';
import 'package:date_field/date_field.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:my_finalapp1/model/Connectapi.dart';
import 'package:my_finalapp1/widget/colors.dart';
import 'dart:convert' as convert;

import 'package:my_finalapp1/widget/custom_back_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisUser extends StatefulWidget {
  @override
  _RegisUserState createState() => _RegisUserState();
}

class _RegisUserState extends State<RegisUser> {
  final _uid = GlobalKey<FormState>();
  final _uuser = TextEditingController();
  final _upass = TextEditingController();
  final _uname = TextEditingController();
  final _ulname = TextEditingController();
  final _upho = TextEditingController();
  final _uemail = TextEditingController();
  // final _ubday = TextEditingController();
  // final _uage = TextEditingController();
  // final _uimg = TextEditingController();

  String _choseGender;
  // DateTime selectedData;
  DateTime _date;

  void register(Map<String, dynamic> values) async {
    // var url = 'http://192.168.0.8:8888/register';
    String url = '${Connectapi().domain}/register';
    var response = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: convert.jsonEncode(values));

    if (response.statusCode == 200) {
      print('Register Success');

      Navigator.pop(context, true);
    } else {
      print('Register not Success!!');
      print(response.body);
      Navigator.pop(context, false);
    }
  }

  //Upload Images อัพโหลดรูปภาพ =====================
  //ตัวแปรเกี่ยวกับ อัพโหลดรูปภาพ
  // File _image;
  // File _camera;
  // String imgstatus = '';
  // String error = 'Error';
  var filename;
  var token;
  var userId;
  // ตัวแปรเกี่ยวกับ อัพโหลดรูปภาพ

  //multi_image_picker
  List<Asset> images = <Asset>[];
  Asset asset;
  String _error = 'No Error Dectected';

  Future _getprefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    userId = prefs.getInt('id');
    print('uId = $userId');
    print('token = $token');
  }

  //สร้าง GridView
  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        // asset = images[index];
        return AssetThumb(
          asset: images[index],
          width: 300,
          height: 300,
        );
      }),
    );
  }

  // ? LoadAssets
  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    setState(() {
      images = resultList;
      print('path : ${images.length}');
      _error = error;
    });
  }

//multi_image_picker
  Future<String> _multiUploadimage(ast) async {
    var _urlUpload = '${Connectapi().domain}/uploads/$userId';
// create multipart request
    MultipartRequest request =
        http.MultipartRequest("PUT", Uri.parse(_urlUpload));
    ByteData byteData = await ast.getByteData();
    List<int> imageData = byteData.buffer.asUint8List();

    http.MultipartFile multipartFile = http.MultipartFile.fromBytes(
      'picture', //key of the api
      imageData,
      filename: 'some-file-name.jpg',
      contentType: MediaType("image",
          "jpg"), //this is not nessessory variable. if this getting error, erase the line.
    );
// add file to multipart
    request.files.add(multipartFile);
// send
    var response = await request.send();
    return response.reasonPhrase;
  }

  //Loop รูปภาพ
  Future<void> _sendPathImage() async {
    print('path : ${images.length}');
    for (int i = 0; i < images.length; i++) {
      asset = images[i];
      print('image : $i');
      var res = _multiUploadimage(asset);
    }
  }

  bool isObscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(
          tapBack: () {
            Navigator.pop(context);
          },
        ),
        // title: Text('สมัครสมาชิก'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _uid,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "สมัครสมาชิก",
                    style: TextStyle(
                      color: tTextColor,
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20),
                  regisForm(
                    _uuser,
                    'ชื่อผู้ใช้',
                    'ชื่อผู้ใช้',
                    'กรุณากรอกชื่อผู้ใช้',
                    'assets/icons/user.png',
                    false,
                  ),
                  SizedBox(height: 10),
                  regisForm(
                    _upass,
                    'รหัสผ่าน',
                    'รหัสผ่าน',
                    'กรุณากรอกรหัสผ่าน',
                    'assets/icons/user.png',
                    true,
                  ),
                  SizedBox(height: 10),
                  regisForm(
                    _uname,
                    'ชื่อ',
                    'ชื่อ',
                    'กรุณากรอกชื่อ',
                    'assets/icons/user.png',
                    false,
                  ),
                  SizedBox(height: 10),
                  regisForm(
                    _ulname,
                    'นามสกุล',
                    'นามสกุล',
                    'กรุณากรอกนามสกุล',
                    'assets/icons/user.png',
                    false,
                  ),
                  SizedBox(height: 10),
                  regisForm(
                    _upho,
                    'เบอร์โทรศัพท์',
                    'เบอร์โทรศัพท์',
                    'กรุณากรอกเบอร์โทรศัพท์',
                    'assets/icons/user.png',
                    false,
                  ),
                  SizedBox(height: 10),
                  regisForm(
                    _uemail,
                    'E-mail',
                    'E-mail',
                    'กรุณากรอก E-mail',
                    'assets/icons/user.png',
                    false,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      genderForm(),
                      SizedBox(width: 20),
                      dateForm(),
                    ],
                  ),
                  SizedBox(height: 25),
                  btnSubmit(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget regisForm(
    final TextEditingController _controller,
    final String _hText,
    final String _hintText,
    final String _validator,
    final String _icon,
    final bool isPasswordTextField,
  ) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              _hText,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: tTextColor,
              ),
            ),
            Text(
              '*',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: tErrorColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        TextFormField(
          controller: _controller,
          obscureText: isPasswordTextField ? isObscurePassword : false,
          validator: (values) {
            if (values.isEmpty) {
              return _validator;
            }
          },
          style: TextStyle(
            color: tTextColor,
            fontSize: 16,
          ),
          cursorColor: tPimaryColor,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: tBGDeepColor,
            hintText: _hintText,
            hintStyle: TextStyle(
              fontSize: 16,
              color: tGreyColor,
            ),
            // icon: ImageIcon(
            //   new AssetImage(_icon),
            //   color: tTextColor,
            //   size: 30,
            // ),
          ),
        ),
      ],
    );
  }

  Widget genderForm() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 135),
          child: Row(
            children: [
              Text(
                'เพศ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: tTextColor,
                ),
              ),
              Text(
                '*',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: tErrorColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
        DropdownButtonHideUnderline(
          child: Container(
            width: 170,
            height: 65,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: tBGDeepColor,
              border: Border.all(
                color: tBGDeepColor,
              ),
            ),
            child: DropdownButton<String>(
              value: _choseGender,
              items: <String>[
                'ชาย',
                'หญิง',
                'อื่นๆ',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              style: TextStyle(
                fontFamily: 'IBMPlexSansThai',
                color: tTextColor,
                fontSize: 16,
              ),
              hint: Text(
                "เลือกเพศ",
                style: TextStyle(
                  fontSize: 16,
                  color: tTextGColor,
                ),
              ),
              // dropdownColor: Theme.of(context).backgroundColor,
              onChanged: (String value) {
                setState(() {
                  _choseGender = value;
                  print(value);
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget dateForm() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 165),
          child: Row(
            children: [
              Text(
                'วันเกิด',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: tTextColor,
                ),
              ),
              Text(
                '*',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: tErrorColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
        Container(
          width: 220,
          height: 65,
          child: DateTimeFormField(
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
              hintText: 'เลือกวันเกิด',
              hintStyle: TextStyle(
                fontSize: 16,
                color: tTextGColor,
              ),
              // labelStyle: TextStyle(color: Theme.of(context).primaryColor),
            ),
            mode: DateTimeFieldPickerMode.date,
          ),
        ),
      ],
    );
  }

  Widget btnSubmit() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: RaisedButton(
        color: tPimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            'บันทึก',
            style: TextStyle(
              fontSize: 16,
              color: tTextColor,
            ),
          ),
        ),
        onPressed: () {
          // Navigator.pop(context, '/LoginPage');

          if (_uid.currentState.validate()) {
            Map<String, dynamic> valuse = Map();
            valuse['user_username'] = _uuser.text;
            valuse['user_password'] = _upass.text;
            valuse['user_name'] = _uname.text;
            valuse['user_lastname'] = _ulname.text;
            valuse['user_phone'] = _upho.text;
            valuse['user_email'] = _uemail.text;
            // valuse['user_gender'] = _ugender.text;
            // valuse['user_age'] = _uage.text;
            valuse['user_gender'] = _choseGender.toString();
            valuse['user_bday'] = _date.toString();

            print(_uuser.text);
            print(_upass.text);
            print(_uname.text);
            print(_ulname.text);
            print(_upho.text);
            print(_uemail.text);
            // print(_ugender.text);
            // print(_uage.text);
            print(_choseGender.toString());
            print(_date.toString());

            register(valuse);
          }
        },
      ),
    );
  }
}
