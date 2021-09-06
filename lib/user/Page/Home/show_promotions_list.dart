import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_finalapp1/model/model_get_list_promotions.dart';
import 'package:my_finalapp1/widget/colors.dart';
import 'package:my_finalapp1/widget/custom_back_button.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_finalapp1/model/Connectapi.dart';

class ShowPromotionsList extends StatefulWidget {
  // ShowPromotionsList({Key? key}) : super(key: key);

  @override
  _ShowPromotionsListState createState() => _ShowPromotionsListState();
}

class _ShowPromotionsListState extends State<ShowPromotionsList> {
  List<Showpromotions> datamember = [];

  var token;
  Future<Void> showfeedreviews() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    // uId = prefs.getInt('id');
    // print('uId = $uId');
    print('token = $token');
    var url = '${Connectapi().domain}/showpromotions';
    //conect
    var response = await http.get(Uri.parse(url), headers: {
      'Connect-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    //check response
    if (response.statusCode == 200) {
      //แปลงjson ให้อยู่ในรูปแบบ model members
      ListPromotions members =
          ListPromotions.fromJson(convert.jsonDecode(response.body));
      //รับค่า ข้อมูลทั้งหมดไว้ในตัวแปร
      setState(() {
        datamember = members.showpromotions;
        // load = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //call _getAPI
    showfeedreviews();
  }

  var dateformate = DateFormat.yMMMEd();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายการโปรโมชั่น'),
        leading: CustomBackButton(
          tapBack: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.height,
          child: _listView(),
        ),
      ),
    );
  }

  Widget _listView() {
    return SingleChildScrollView(
      child: datamember.length <= 0
          ? Card(
              color: tBGDeepColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: SizedBox(
                height: 200,
                child: Center(
                  child: Text(
                    'ไม่มีโปรโมชั่น',
                    style: TextStyle(
                      color: tTextColor,
                      fontSize: 16,
                    ),
                  ),
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
                      Navigator.pushNamed(context, '/showpromotionsdetail',
                          arguments: {
                            'pro_id': datamember[index].proId,
                            'pro_topic': datamember[index].proTopic,
                            'pro_detail': datamember[index].proDetail,
                            'pro_start': datamember[index].proStart,
                            'pro_end': datamember[index].proEnd,
                            'pro_img': datamember[index].proImg,
                            //########################
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
                      elevation: 5,
                      shadowColor: tBGDeepColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
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
                                        child: _image(
                                            '${datamember[index].proImg}'),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Card(
                                          color: tPimaryColor,
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10, left: 10),
                                            child: Text(
                                              "${datamember[index].npName}",
                                              style: TextStyle(
                                                color: tTextWColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "${datamember[index].proTopic}",
                                          style: TextStyle(
                                            color: tTextColor,
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
                                          '${dateformate.format(DateTime.parse(datamember[index].proStart))} ถึง ${dateformate.format(DateTime.parse(datamember[index].proEnd))}',
                                          style: TextStyle(
                                            color: tTextColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                            //   child: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       Text(
                            //         "${datamember[index].revTopic}",
                            //         style: TextStyle(
                            //           color: tTextColor,
                            //           fontSize: 16,
                            //           fontWeight: FontWeight.bold,
                            //         ),
                            //       ),
                            //       Text(
                            //         "${datamember[index].revDetail}",
                            //         maxLines: 5,
                            //         style: TextStyle(
                            //           color: tTextColor,
                            //           fontSize: 16,
                            //           fontWeight: FontWeight.normal,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
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
