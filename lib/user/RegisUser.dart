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

  //! aad profile <<<<<

  var _filename;

  // ตัวแปรเกี่ยวกับ อัพโหลดรูปภาพ

  //multi_image_picker
  List<Asset> _images = <Asset>[];
  Asset _asset;
  String error = 'No Error Dectected';

  //LoadAssets
  Future<void> _loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 1,
        enableCamera: true,
        selectedAssets: _images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#9147ff",
          actionBarTitle: "รูปภาพจากแกลอรี่",
          allViewTitle: "รูปภาพทั้งหมด",
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
      _images = resultList;
      print('path : ${_images.length}');
      error = error;
    });
  }

//multi_image_picker
  Future<String> multiUploadimage(ast) async {
    var urlUpload = '${Connectapi().domain}/uploadsprofileuser';
// create multipart request
    MultipartRequest request =
        http.MultipartRequest("POST", Uri.parse(urlUpload));
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
  Future<void> sendImage() async {
    print('path : ${_images.length}');
    for (int i = 0; i < _images.length; i++) {
      _asset = _images[i];
      print('image : $i');
      var res = multiUploadimage(_asset);
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
                    (values) {
                      if (values.isEmpty) {
                        return 'กรุณากรอกชื่อผู้ใช้';
                      }
                      return null;
                    },
                    'assets/icons/user.png',
                    TextInputType.text,
                    false,
                  ),
                  SizedBox(height: 10),
                  regispasswordForm(
                    _upass,
                    'รหัสผ่าน',
                    'รหัสผ่าน (ไม่น้อยกว่า 8 ตัวอักษร)',
                    (values) {
                      if (values.isEmpty) {
                        return 'กรุณากรอกรหัสผ่าน';
                      }
                      if (values.length < 8) {
                        return 'กรุณากรอกรหัสผ่านไม่น้อยกว่า 8 ตัวอักษร';
                      }
                      if (!RegExp(r'[a-zA-Z]').hasMatch(values) ||
                          !RegExp(r'[0-9]').hasMatch(values)) {
                        return 'รหัสผ่านของคุณต้องมีอักษร a-z A-Z และตัวเลขอย่างน้อย 1 ตัวเลข';
                      }
                      return null;
                    },
                    'assets/icons/user.png',
                    TextInputType.text,
                    true,
                  ),
                  SizedBox(height: 10),
                  regisForm(
                    _uname,
                    'ชื่อ',
                    'ชื่อ',
                    (values) {
                      if (values.isEmpty) {
                        return 'กรุณากรอกชื่อ';
                      }
                      return null;
                    },
                    'assets/icons/user.png',
                    TextInputType.text,
                    false,
                  ),
                  SizedBox(height: 10),
                  regisForm(
                    _ulname,
                    'นามสกุล',
                    'นามสกุล',
                    (values) {
                      if (values.isEmpty) {
                        return 'กรุณากรอกนามสกุล';
                      }
                      return null;
                    },
                    'assets/icons/user.png',
                    TextInputType.text,
                    false,
                  ),
                  SizedBox(height: 10),
                  regisForm(
                    _upho,
                    'เบอร์โทรศัพท์',
                    'เบอร์โทรศัพท์ (081234****)',
                    (values) {
                      if (values.isEmpty) {
                        return 'กรุณากรอกเบอร์โทรศัพท์';
                      }
                      if (values.length < 10) {
                        return 'กรุณากรอกเบอร์โทรศัพท์ให้ครบ';
                      }
                      if (values.length > 10) {
                        return 'คุณกรอกเบอร์โทรศัพท์เกินจำนวน';
                      }
                      if (!RegExp(r'^(?:[+0][1-9])?[0-9]{10,12}$')
                          .hasMatch(values)) {
                        return 'กรุณากรอกเบอร์โทรศัพท์ให้ถูกต้อง';
                      }
                      return null;
                    },
                    'assets/icons/user.png',
                    TextInputType.number,
                    false,
                  ),
                  SizedBox(height: 10),
                  regisForm(
                    _uemail,
                    'E-mail',
                    'you@example.com',
                    (values) {
                      if (values.isEmpty) {
                        return 'กรุณากรอก E-mail';
                      }
                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(values)) {
                        return 'กรุณากรอก E-mail ให้ถูกต้อง';
                      }
                      return null;
                    },
                    'assets/icons/user.png',
                    TextInputType.emailAddress,
                    false,
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      genderForm(),
                      dateForm(),
                    ],
                  ),
                  SizedBox(height: 10),
                  Divider(
                    thickness: 1,
                    color: Colors.black12,
                  ),
                  SizedBox(height: 10),
                  Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'เพิ่มรูปภาพโปรไฟล์ของคุณ',
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
                              Text(
                                'ขนาดของรูปภาพต้องไม่เกิน 5 MB',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: tGreyColor,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          addImgs(_loadAssets),
                        ],
                      ),
                      SizedBox(height: 10),
                      buildImagesProfile(),
                    ],
                  ),
                  SizedBox(height: 50),
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
    // final String _validator,
    final FormFieldValidator _validator,
    final String _icon,
    final TextInputType _textType,
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
          validator: _validator,
          // (values) {
          //   if (values.isEmpty) {
          //     return _validator;
          //   }
          // },
          keyboardType: _textType,
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
          ),
        ),
      ],
    );
  }

  Widget regispasswordForm(
    final TextEditingController _controller,
    final String _hText,
    final String _hintText,
    // final String _validator,
    final FormFieldValidator _validator,
    final String _icon,
    final TextInputType _textType,
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
          validator: _validator,
          // (values) {
          //   if (values.isEmpty) {
          //     return _validator;
          //   }
          // },
          keyboardType: _textType,
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
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  isObscurePassword = !isObscurePassword;
                });
              },
              icon: isObscurePassword
                  ? Icon(
                      Icons.visibility,
                      color: tGreyColor,
                    )
                  : Icon(
                      Icons.visibility_off,
                      color: Colors.grey,
                    ),
            ),
          ),
        ),
      ],
    );
  }

  Widget genderForm() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 120),
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
            width: MediaQuery.of(context).size.width * 0.35,
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
          width: MediaQuery.of(context).size.width * 0.52,
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

  Widget addImgs(VoidCallback onload) {
    return SizedBox(
      width: 100,
      height: 50,
      child: RaisedButton(
        elevation: 0,
        color: tBGDeepColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            'เพิ่มรูปภาพ',
            style: TextStyle(
              fontSize: 14,
              color: tTextColor,
            ),
          ),
        ),
        onPressed: onload,
      ),
    );
  }

  Widget buildImagesProfile() {
    return SizedBox(
      height: 150,
      child: _images.length <= 0
          ? Card(
              elevation: 0,
              color: tBGDeepColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: SizedBox(
                height: 150,
                child: Center(
                  child: Text(
                    'เพิ่มรูปภาพของคุณ',
                    style: TextStyle(
                      color: tTextColor,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            )
          : Card(
              elevation: 0,
              color: tBGDeepColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: ListView.builder(
                  itemCount: _images.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Card(
                    child: AssetThumb(
                      asset: _images[index],
                      width: 150,
                      height: 150,
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Widget btnSubmit() {
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
          if (_uid.currentState.validate()) {
            Map<String, dynamic> valuse = Map();
            valuse['user_username'] = _uuser.text;
            valuse['user_password'] = _upass.text;
            valuse['user_name'] = _uname.text;
            valuse['user_lastname'] = _ulname.text;
            valuse['user_phone'] = _upho.text;
            valuse['user_email'] = _uemail.text;
            valuse['user_gender'] = _choseGender.toString();
            valuse['user_bday'] = _date.toString();

            print(_uuser.text);
            print(_upass.text);
            print(_uname.text);
            print(_ulname.text);
            print(_upho.text);
            print(_uemail.text);
            print(_choseGender.toString());
            print(_date.toString());

            register(valuse);

            sendImage();

            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
