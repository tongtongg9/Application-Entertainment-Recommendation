import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:my_finalapp1/model/Connectapi.dart';
import 'package:my_finalapp1/model/getNpforuser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  // Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Rows> datamember = [];
  // var uId;
  var token;

  //connect server api
  Future<Void> _getListNpbyOwPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    // uId = prefs.getInt('id');
    // print('uId = $uId');
    print('token = $token');
    var url = '${Connectapi().domain}/shownpforuser';
    //conect
    var response = await http.get(Uri.parse(url), headers: {
      'Connect-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    //check response
    if (response.statusCode == 200) {
      //แปลงjson ให้อยู่ในรูปแบบ model members
      GetNpforuser members =
          GetNpforuser.fromJson(convert.jsonDecode(response.body));
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
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: datamember.length,
        itemBuilder: (context, index) {
          // children: <Widget>[
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/showdetailnp', arguments: {
                'np_id': datamember[index].npId,
                'np_name': datamember[index].npName,
                'np_phone': datamember[index].npPhone,
                'np_email': datamember[index].npEmail,
                'np_adress': datamember[index].npAdress,
                'np_district': datamember[index].npDistrict,
                'np_province': datamember[index].npProvince,
                // 'ac_home': datamember[index].acHome,
                // 'ac_sub': datamember[index].acSub,
                // 'ac_district': datamember[index].acDistrict,
                // 'ac_province': datamember[index].acProvince,
                // 'ac_detel': datamember[index].acDetel,
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                child: new FittedBox(
                  child: Material(
                    color: Theme.of(context).backgroundColor,
                    elevation: 10,
                    borderRadius: BorderRadius.circular(15),
                    // shadowColor: ,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 200,
                          height: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(15),

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
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),

                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        child: Text(
                                          "${datamember[index].npAdress} ${datamember[index].npDistrict}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          "${datamember[index].npProvince}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          "ติดต่อ ${datamember[index].npPhone}",
                                          style: TextStyle(
                                              color: Colors.white,
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
                          width: 200,
                          height: 150,
                          child: npPhotos(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
          // ],
        },
      ),
    );
  }

  Widget npPhotos() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: ClipRRect(
        borderRadius: new BorderRadius.circular(24.0),
        child: Image.asset(
          'assets/images/pub.png',
          // width: 200,
          // height: 250,

          fit: BoxFit.contain,
          // alignment: Alignment.topRight,
          //   image: NetworkImage(
          //       "https://images.unsplash.com/photo-1495147466023-ac5c588e2e94?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80"),
          // ),
        ),
      ),
    );
  }

  // itemCount: datamember.length,
  // itemBuilder: (context, index)
} //! main class