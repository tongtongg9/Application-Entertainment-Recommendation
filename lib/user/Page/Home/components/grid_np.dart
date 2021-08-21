import 'package:flutter/material.dart';
import 'dart:ffi';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:my_finalapp1/model/Connectapi.dart';
import 'package:my_finalapp1/model/ShowImgnpforUser.dart';
import 'package:my_finalapp1/model/getNpforuser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowGridNP extends StatefulWidget {
  const ShowGridNP({
    Key key,
  }) : super(key: key);

  @override
  _ShowGridNPState createState() => _ShowGridNPState();
}

class _ShowGridNPState extends State<ShowGridNP> {
  List<Rows> datamember = [];

  var token;

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
    return SafeArea(
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(20),
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1.2,
        children: List.generate(datamember.length, (index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/showdetailnp', arguments: {
                'np_id': datamember[index].npId,
                'np_name': datamember[index].npName,
                'np_about': datamember[index].npAbout,
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
              print(datamember[index].npName);
            },
            child: Card(
              elevation: 5,
              // width: double.infinity,
              // color: Theme.of(context).accentColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Stack(
                children: [
                  Hero(
                    tag: datamember,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: imgsNp('${datamember[index].npImgspro}'),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 70,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.black54,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  ('${datamember[index].npName}'),
                                  maxLines: 3,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Text(
                                  ('${datamember[index].npProvince}'),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal),
                                ),
                                // Spacer(),

                                // LikedButton()
                              ],
                            ),

                            // SmoothStarRating(
                            //   allowHalfRating: false,
                            //   onRated: (v) {},
                            //   starCount: 5,
                            //   rating: place.rating,
                            //   size: 15,
                            //   isReadOnly: true,
                            //   color: kRatingStarColor,
                            //   borderColor: kRatingStarColor,
                            // )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        }),
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
      child = Image.asset('assets/images/person.png');
    }
    return new Container(child: child);
  }
}
