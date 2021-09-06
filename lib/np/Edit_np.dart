import 'package:flutter/material.dart';
import 'package:my_finalapp1/model/Connectapi.dart';
import 'package:my_finalapp1/widget/colors.dart';
import 'package:my_finalapp1/widget/custom_back_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class EditPagenp extends StatefulWidget {
  // EditPagenp({Key? key}) : super(key: key);

  @override
  _EditPagenpState createState() => _EditPagenpState();
}

class _EditPagenpState extends State<EditPagenp> {
  final _np_id = GlobalKey<FormState>();
  // final _np_name = TextEditingController();
  // final _np_about = TextEditingController();
  // final _np_phone = TextEditingController();
  // final _np_email = TextEditingController();
  // final _np_adress = TextEditingController();
  // final _np_district = TextEditingController();
  // final _np_province = TextEditingController();

  var userID;
  var token;

  Future getNP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    userID = prefs.getInt('id');
    print('userID = $userID');
    print('token = $token');
  }

  Future<void> _updateMember(Map<String, dynamic> values) async {
    var url = '${Connectapi().domain}/updateownip/$_npId';
    print(_npId);
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

  Map<String, dynamic> _rec_member;
  var _npId;
  var _npName;
  var _npAbout;
  var _npPhone;
  var _npEmail;
  var _npAdress;
  var _npDistrict;
  var _npProvince;

  Future getDataNp() {
    _rec_member = ModalRoute.of(context).settings.arguments;
    _npId = _rec_member['_npId'];
    _npName = TextEditingController(text: _rec_member['_npName']);
    _npAbout = TextEditingController(text: _rec_member['_npAbout']);
    _npPhone = TextEditingController(text: _rec_member['_npPhone']);
    _npEmail = TextEditingController(text: _rec_member['_npEmail']);
    _npAdress = TextEditingController(text: _rec_member['_npAdress']);
    _npDistrict = TextEditingController(text: _rec_member['_npDistrict']);
    _npProvince = TextEditingController(text: _rec_member['_npProvince']);
    print(_npId);
    print(_npName);
    print(_npPhone);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNP();
  }

  @override
  Widget build(BuildContext context) {
    getDataNp();
    return Scaffold(
      appBar: AppBar(
        title: Text('แก้ไข้ข้อมูลร้านของคุณ'),
        leading: CustomBackButton(
          tapBack: () {
            Navigator.pop(context);
          },
        ),
      ),
      // backgroundColor: tBGDeepColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _np_id,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      npForm(_npName, 'ชื่อร้าน', 'ชื่อร้าน', 1),
                      SizedBox(height: 10),
                      npForm(_npAbout, 'เกี่ยวกับร้าน', 'เกี่ยวกับร้าน', 4),
                      SizedBox(height: 10),
                      npForm(_npPhone, 'เบอร์โทรร้าน', 'เบอร์โทรร้าน', 1),
                      SizedBox(height: 10),
                      npForm(_npEmail, 'E-mail', 'E-mail', 1),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                Divider(
                  endIndent: 25,
                  indent: 25,
                  thickness: 2,
                  color: Colors.black12,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      npForm(_npAdress, 'ที่อยู่', 'รายละเอียดที่อยู่', 2),
                      SizedBox(height: 10),
                      npForm(_npDistrict, 'อำเภอ', 'อำเภอ', 1),
                      SizedBox(height: 10),
                      npForm(_npProvince, 'จังหวัด', 'จังหวัด', 1),
                    ],
                  ),
                ),
                Divider(
                  endIndent: 25,
                  indent: 25,
                  thickness: 2,
                  color: Colors.black12,
                ),
                // Padding(
                //   padding: const EdgeInsets.all(20),
                //   child: Column(
                //     children: [
                //       Row(
                //         children: [
                //           Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               Row(
                //                 children: [
                //                   Text(
                //                     'เพิ่มรูปภาพหน้าร้านของคุณ',
                //                     style: TextStyle(
                //                       fontSize: 16,
                //                       fontWeight: FontWeight.bold,
                //                       color: tTextColor,
                //                     ),
                //                   ),
                //                   Text(
                //                     '*',
                //                     style: TextStyle(
                //                       fontSize: 16,
                //                       fontWeight: FontWeight.bold,
                //                       color: tErrorColor,
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //               Text(
                //                 'เลือกรูปภาพที่ดีที่สุดของร้านคุณ',
                //                 style: TextStyle(
                //                   fontSize: 12,
                //                   color: tGreyColor,
                //                 ),
                //               ),
                //               Text(
                //                 'เพิ่มรูปภาพร้านของคุณไม่เกิน 1 ภาพ ขนาดไม่เกิน 5 MB',
                //                 style: TextStyle(
                //                   fontSize: 12,
                //                   color: tGreyColor,
                //                 ),
                //               ),
                //             ],
                //           ),
                //           Spacer(),
                //           addImgs(_loadAssets),
                //         ],
                //       ),
                //       SizedBox(height: 10),
                //       buildImagesProfile(),
                //     ],
                //   ),
                // ),
                // Divider(
                //   endIndent: 25,
                //   indent: 25,
                //   thickness: 2,
                //   color: Colors.black12,
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(20),
                //   child: Column(
                //     children: [
                //       Row(
                //         children: [
                //           Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               Row(
                //                 children: [
                //                   Text(
                //                     'เพิ่มรูปภาพร้านของคุณ',
                //                     style: TextStyle(
                //                       fontSize: 16,
                //                       fontWeight: FontWeight.bold,
                //                       color: tTextColor,
                //                     ),
                //                   ),
                //                   Text(
                //                     '*',
                //                     style: TextStyle(
                //                       fontSize: 16,
                //                       fontWeight: FontWeight.bold,
                //                       color: tErrorColor,
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //               Text(
                //                 'เพิ่มรูปภาพร้านของคุณไม่เกิน 10 ภาพ ขนาดไม่เกิน 5 MB',
                //                 style: TextStyle(
                //                   fontSize: 12,
                //                   color: tGreyColor,
                //                 ),
                //               ),
                //             ],
                //           ),
                //           Spacer(),
                //           addImgs(loadAssets),
                //         ],
                //       ),
                //       SizedBox(height: 10),
                //       buildImagesList(),
                //     ],
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      btnSubmit(),
                    ],
                  ),
                ),
                // btnMap(),
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
          'บันทึก',
          style: TextStyle(
            fontSize: 16,
            color: tTextWColor,
          ),
        ),
        onPressed: () {
          if (_np_id.currentState.validate()) {
            Map<String, dynamic> valuse = Map();
            valuse['np_name'] = _npName.text;
            valuse['np_about'] = _npAbout.text;
            valuse['np_phone'] = _npPhone.text;
            valuse['np_email'] = _npEmail.text;
            valuse['np_adress'] = _npAdress.text;
            valuse['np_district'] = _npDistrict.text;
            valuse['np_province'] = _npProvince.text;
            // valuse['np_lat'] = _nplat.text;
            // valuse['np_long'] = _nplong.text;

            print(valuse);

            // print(_nplat.text);
            // print(_nplong.text);

            _updateMember(valuse);
            // sendPathImage();
            // sendPathImageProfile();
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
