import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_finalapp1/model/Connectapi.dart';
import 'package:my_finalapp1/model/model_get_list_promotions_np.dart';
import 'package:my_finalapp1/widget/colors.dart';
import 'package:my_finalapp1/widget/custom_back_button.dart';
import 'package:my_finalapp1/widget/loading_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class ShowPromotionsListNp extends StatefulWidget {
  // ShowPromotionsListNp({Key? key}) : super(key: key);

  @override
  _ShowPromotionsListNpState createState() => _ShowPromotionsListNpState();
}

class _ShowPromotionsListNpState extends State<ShowPromotionsListNp> {
  bool loadScreen = true;

  List<Rsprobynp> datamember = [];

  var token;

  Future<Void> showlist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    // uId = prefs.getInt('id');
    // print('uId = $uId');
    print('token = $token');
    var url = '${Connectapi().domain}/getpromotionsnp/$_npId';
    //conect
    var response = await http.get(Uri.parse(url), headers: {
      'Connect-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    //check response
    if (response.statusCode == 200) {
      //แปลงjson ให้อยู่ในรูปแบบ model members
      ListPromotionsNp members =
          ListPromotionsNp.fromJson(convert.jsonDecode(response.body));
      //รับค่า ข้อมูลทั้งหมดไว้ในตัวแปร
      setState(() {
        datamember = members.rsprobynp;
        // load = false;
        loadScreen = false;
      });
    }
  }

  Map<String, dynamic> _rec_member;
  var _npId;

  Future getDataNp() {
    _rec_member = ModalRoute.of(context).settings.arguments;
    _npId = _rec_member['_npId'];
    print(_rec_member);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //call _getAPI
    showlist();
  }

  Future<Null> refreshModel() async {
    var urlModel = '${Connectapi().domain}/getpromotionsnp/$_npId';
    print(urlModel);
    await http.get(Uri.parse(urlModel)).then((value) {
      setState(() {
        showlist();
      });
    });
    print('รีรีรีรี');
  }

  var dateformate = DateFormat.yMMMd();

  @override
  Widget build(BuildContext context) {
    getDataNp();
    return Scaffold(
      appBar: AppBar(
        title: Text('รายการโปรโมชั่น'),
        leading: CustomBackButton(
          tapBack: () {
            Navigator.pop(context);
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/addpromotions', arguments: {
            '_npId': _npId,
          }).then((value) => refreshModel());
        },
        label: Text('เพิ่มโปรโมชั่นร้านของคุณ'),
        backgroundColor: tPimaryColor,
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.height,
          child: loadScreen ? ShowProgress().loadingScreen() : _listView(),
        ),
      ),
    );
  }

  Widget _listView() {
    return SingleChildScrollView(
      child: datamember.length <= 0
          ? Container(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                    Icon(
                      Icons.error,
                      size: 100,
                      color: Colors.grey,
                    ),
                    Text(
                      'ไม่มีรายการ',
                      style: TextStyle(
                        color: tTextGColor,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: datamember.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/showpromotionsdetailnp',
                          arguments: {
                            'pro_id': datamember[index].proId,
                            'pro_topic': datamember[index].proTopic,
                            'pro_detail': datamember[index].proDetail,
                            'pro_start': datamember[index].proStart,
                            'pro_end': datamember[index].proEnd,
                            'pro_img': datamember[index].proImg,
                            //########################
                            'np_id': datamember[index].npId,
                            // 'np_name': datamember[index].npName,
                            // 'np_about': datamember[index].npAbout,
                            // 'np_phone': datamember[index].npPhone,
                            // 'np_email': datamember[index].npEmail,
                            // 'np_adress': datamember[index].npAdress,
                            // 'np_district': datamember[index].npDistrict,
                            // 'np_province': datamember[index].npProvince,
                            // 'np_lat': datamember[index].npLat,
                            // 'np_long': datamember[index].npLong,
                            // 'np_bk_status': datamember[index].npBkStatus,
                          }).then((value) => refreshModel());
                    },
                    child: Card(
                      elevation: 5,
                      shadowColor: tBGDeepColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "${datamember[index].proTopic}",
                              style: TextStyle(
                                color: tTextColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.black12,
                            ),
                            IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'วันที่เริ่มโปรโมชั่น',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          color: tTextColor,
                                        ),
                                      ),
                                      Text(
                                        '${dateformate.format(DateTime.parse(datamember[index].proStart))}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: tTextColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  VerticalDivider(
                                    indent: 0,
                                    endIndent: 0,
                                    thickness: 1,
                                    color: Colors.black12,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'วันที่สิ้นสุดโปรโมชั่น',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          color: tTextColor,
                                        ),
                                      ),
                                      Text(
                                        '${dateformate.format(DateTime.parse(datamember[index].proStart))}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: tTextColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.black12,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 200,
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child:
                                        _image('${datamember[index].proImg}'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                  // ],
                },
              ),
            ),
    );
  }

  // Widget _image(imageName) {
  //   Widget child;
  //   print('Imagename : $imageName');
  //   if (imageName != null) {
  //     child = Image.network(
  //       '${Connectapi().domainimgpro}${imageName}',
  //       fit: BoxFit.cover,
  //     );
  //   } else {
  //     child = Image.asset('assets/images/person.png');
  //   }
  //   return new Container(child: child);
  // }

  Widget _image(imageName) {
    return CachedNetworkImage(
      imageUrl: '${Connectapi().domainimgpro}${imageName}',
      fit: BoxFit.cover,
      placeholder: (context, url) => Center(
        child: CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => Container(
        child: Icon(
          Icons.error,
          color: tErrorColor,
        ),
      ),
    );
  }
}
