import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:my_finalapp1/model/Connectapi.dart';
import 'package:my_finalapp1/model/Member.dart';
import 'package:my_finalapp1/widget/colors.dart';
import 'package:my_finalapp1/widget/custom_back_button.dart';
import 'package:my_finalapp1/widget/loading_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPubOw extends StatefulWidget {
  // MyPubOw({Key? key}) : super(key: key);

  @override
  _MyPubOwState createState() => _MyPubOwState();
}

class _MyPubOwState extends State<MyPubOw> {
  List<Rows> datamember = [];
  var uId;
  var token;

  //connect server api
  Future<Void> _getListNpbyOwPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    uId = prefs.getInt('id');
    print('uId = $uId');
    print('token = $token');
    var url = '${Connectapi().domain}/getdatanpbyow/$uId';
    //conect
    var response = await http.get(Uri.parse(url), headers: {
      'Connect-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    //check response
    if (response.statusCode == 200) {
      //แปลงjson ให้อยู่ในรูปแบบ model members
      Np_by_Owner members =
          Np_by_Owner.fromJson(convert.jsonDecode(response.body));
      //รับค่า ข้อมูลทั้งหมดไว้ในตัวแปร
      setState(() {
        datamember = members.rows;
        // load = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //call _getAPI
    _getListNpbyOwPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ร้านของฉัน'),
        leading: CustomBackButton(
          tapBack: () {
            Navigator.pop(context);
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/owaddmypub');
        },
        label: Text('เพิ่มร้านของคุณ'),
        backgroundColor: tPimaryColor,
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        primary: false,
        scrollDirection: Axis.vertical,
        itemCount: datamember.length,
        itemBuilder: (context, index) {
          // children: <Widget>[
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/showdetailnpowner',
                      arguments: {
                        'np_id': datamember[index].npId,
                        'np_name': datamember[index].npName,
                        'np_about': datamember[index].npAbout,
                        'np_phone': datamember[index].npPhone,
                        'np_email': datamember[index].npEmail,
                        'np_adress': datamember[index].npAdress,
                        'np_district': datamember[index].npDistrict,
                        'np_province': datamember[index].npProvince,
                        'np_lat': datamember[index].npLat,
                        'np_long': datamember[index].npLong,
                        'np_bk_status': datamember[index].npBkStatus,
                      });
                },
                child: Card(
                  color: tBGDeepColor,
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          // child: mynpDetails(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 20,bottom: 30),
                              Container(
                                child: Text(
                                  "${datamember[index].npName}",
                                  style: TextStyle(
                                      color: tTextColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // Container(
                                    //   child: Text(
                                    //     // "${datamember[index].npAbout}",
                                    //     'About',
                                    //     style: TextStyle(
                                    //       color: Colors.white,
                                    //       fontSize: 16,
                                    //     ),
                                    //   ),
                                    // ),
                                    Container(
                                      child: Text(
                                        "${datamember[index].npAdress} ${datamember[index].npDistrict}",
                                        style: TextStyle(
                                          color: tTextColor,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "${datamember[index].npProvince}",
                                        style: TextStyle(
                                          color: tTextColor,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "ติดต่อ ${datamember[index].npPhone}",
                                        style: TextStyle(
                                            color: tTextColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 150,
                        height: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: imgsNp('${datamember[index].npImgspro}'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget imgsNp(imageName) {
    Widget child;
    print('Imagename : $imageName');

    if (imageName != null) {
      child = Image.network(
        '${Connectapi().domainimgnp}${imageName}',
        width: double.infinity,
        height: 200,
        fit: BoxFit.cover,
      );
    } else {
      child = Image.asset(
        'assets/images/no_image.png',
        width: double.infinity,
        height: 200,
        fit: BoxFit.cover,
      );
      // child = Image.network(
      //   '${Connectapi().domainonimgnp}',
      //   width: double.infinity,
      //   height: 200,
      //   fit: BoxFit.cover,
      // );
    }
    return new Container(child: child);
  }

  Widget mynpPhotos() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: new BorderRadius.circular(24.0),
        child: Image.asset(
          'assets/images/no_image.png',
          // width: 200,
          // height: 250,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // itemCount: datamember.length,
  // itemBuilder: (context, index)
} //! main class
