import 'dart:typed_data';

import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:my_finalapp1/model/Connectapi.dart';
import 'package:my_finalapp1/owner/add_promptions_img.dart';
import 'package:my_finalapp1/widget/colors.dart';
import 'package:my_finalapp1/widget/custom_back_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class AddPromotions extends StatefulWidget {
  // AddPromotions({Key? key}) : super(key: key);

  @override
  _AddPromotionsState createState() => _AddPromotionsState();
}

class _AddPromotionsState extends State<AddPromotions> {
  final _formkey = GlobalKey<FormState>();
  final _pro_topic = TextEditingController();
  final _pro_detail = TextEditingController();

  var userID;
  var token;

  Future getNP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    userID = prefs.getInt('id');
    print('userID = $userID');
    print('token = $token');
  }

  void addPromotions(Map<String, dynamic> values) async {
    // var url = 'http://192.168.0.8:8888/register';
    String url = '${Connectapi().domain}/addpromotions/$_npId';
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
    print(_rec_member);
  }

  DateTime _dateStart;
  DateTime _dateEnd;

  //! aad img <<<<<
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
      _images = resultList;
      print('path : ${_images.length}');
      error = error;
    });
  }

//multi_image_picker
  Future<String> multiUploadimage(ast) async {
    var urlUpload = '${Connectapi().domain}/uploadsimgpromotions';
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
  Future<void> sendPathImage() async {
    print('path : ${_images.length}');
    for (int i = 0; i < _images.length; i++) {
      _asset = _images[i];
      print('image : $i');
      var res = multiUploadimage(_asset);
    }
  }

  @override
  Widget build(BuildContext context) {
    getDataNp();
    return Scaffold(
      appBar: AppBar(
        title: Text('เพิ่มโปรโมชั่นร้าน'),
        leading: CustomBackButton(
          tapBack: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Container(
            padding:
                EdgeInsets.fromLTRB(20, 0, 20, 20), // todo ระยะห่างจากขอบจอ !!
            child: Column(
              children: [
                npForm(
                  _pro_topic,
                  'หัวข้อโปรโมชั่น',
                  'เพิ่มหัวข้อโปรโมชั่น',
                  1,
                ),
                SizedBox(height: 30),
                npForm(
                  _pro_detail,
                  'รายละเอียดโปรโมชั่น',
                  'เพิ่มรายละเอียดโปรโมชั่น',
                  4,
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    dateStart(),
                    dateEnd(),
                  ],
                ),
                SizedBox(height: 20),
                Divider(
                  thickness: 2,
                  color: Colors.black12,
                ),
                SizedBox(height: 10),
                _addImg(),
                SizedBox(height: 50),
                btnSubmit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget npForm(
    final TextEditingController _controller,
    final String hText,
    final String _hintText,
    final int _maxLine,
  ) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              hText,
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
          validator: (values) {
            if (values.isEmpty) {
              return 'กรุณากรอกชื่อร้าน';
            }
          },
          style: TextStyle(
            color: tTextColor,
            fontSize: 16,
          ),
          maxLines: _maxLine,
          cursorColor: tPimaryColor,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
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

  Widget dateStart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'วันที่เริ่มโปรโมชั่น',
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
        Row(
          children: [
            Container(
              width: 180,
              height: 65,
              child: DateTimeFormField(
                onDateSelected: (DateTime value) {
                  setState(() {
                    _dateStart = value;
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
                  hintText: 'เลือกวันที่เริ่มโปรโมชั่น',
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
        ),
      ],
    );
  }

  Widget dateEnd() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'วันที่สิ้นสุดโปรโมชั่น',
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
        Row(
          children: [
            Container(
              width: 200,
              height: 65,
              child: DateTimeFormField(
                onDateSelected: (DateTime value) {
                  setState(() {
                    _dateEnd = value;
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
                  hintText: 'เลือกวันที่สิ้นสุดโปรโมชั่น',
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
        ),
      ],
    );
  }

  Widget _addImg() {
    return Column(
      children: [
        Row(
          children: [
            Row(
              children: [
                Text(
                  'เพิ่มรูปภาพโปรโมชั่น',
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
            Spacer(),
            addImgs(() {
              _loadAssets();
            }),
          ],
        ),
        SizedBox(height: 5),
        SizedBox(
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
            'เสร็จสิ้น',
            style: TextStyle(
              fontSize: 16,
              color: tTextWColor,
            ),
          ),
        ),
        onPressed: () {
          if (_formkey.currentState.validate()) {
            Map<String, dynamic> valuse = Map();
            // valuse['np_id'] = _npId;
            valuse['pro_topic'] = _pro_topic.text;
            valuse['pro_detail'] = _pro_detail.text;
            valuse['pro_start'] = _dateStart.toString();
            valuse['pro_end'] = _dateEnd.toString();

            print(valuse);
            addPromotions(valuse);
            sendPathImage();
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
