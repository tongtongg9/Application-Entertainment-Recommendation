import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
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
      body: SafeArea(
        child: datamember.length <= 0
            ? Card(
                color: tBGDeepColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: SizedBox(
                  height: 200,
                  child: Center(
                    child: Text(
                      'ไม่มีร้าน',
                      style: TextStyle(
                        color: tTextColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(16),
                child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  scrollDirection: Axis.vertical,
                  itemCount: datamember.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
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
                        color: Colors.white,
                        shadowColor: tBGDeepColor,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                width: 150,
                                height: 100,
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: imgsNp(
                                          '${datamember[index].npImgspro}'),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${datamember[index].npName}",
                                    style: TextStyle(
                                      color: tTextColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${datamember[index].npAdress} ${datamember[index].npDistrict}",
                                    style: TextStyle(
                                      color: tTextColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    "${datamember[index].npProvince}",
                                    style: TextStyle(
                                      color: tTextColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }

  Widget imgsNp(imageName) {
    return CachedNetworkImage(
      imageUrl: '${Connectapi().domainimgnp}${imageName}',
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
