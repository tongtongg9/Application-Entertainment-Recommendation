import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_finalapp1/model/Connectapi.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:my_finalapp1/model/model_get_list_reviews_feed.dart';
import 'package:my_finalapp1/widget/colors.dart';
import 'package:my_finalapp1/widget/loading_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Feed extends StatefulWidget {
  // Feed({Key? key}) : super(key: key);

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  List<Showfeed> datamember = [];
  var token;

  Future<Void> showfeedreviews() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    // uId = prefs.getInt('id');
    // print('uId = $uId');
    print('token = $token');
    var url = '${Connectapi().domain}/showfeed';
    //conect
    var response = await http.get(Uri.parse(url), headers: {
      'Connect-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    //check response
    if (response.statusCode == 200) {
      //แปลงjson ให้อยู่ในรูปแบบ model members
      ShowFeedUser members =
          ShowFeedUser.fromJson(convert.jsonDecode(response.body));
      //รับค่า ข้อมูลทั้งหมดไว้ในตัวแปร
      setState(() {
        datamember = members.showfeed;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          'รีวิวล่าสุด',
          style: TextStyle(
            color: tTextColor,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
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
    var dateformate = DateFormat.yMMMEd();

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
                    'ไม่มีรีวิวจากผู้ใช้อื่น',
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
                  return Card(
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
                                height: 40,
                                width: 40,
                                child: Stack(
                                  overflow: Overflow.visible,
                                  fit: StackFit.expand,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: imgsuser(
                                          '${datamember[index].userImg}'),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${datamember[index].userUsername}",
                                        style: TextStyle(
                                          color: tTextColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'รีวิวให้ร้าน',
                                        style: TextStyle(
                                          color: tTextColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        "${datamember[index].npName}",
                                        style: TextStyle(
                                          color: tPimaryColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    // "${datamember[index].revTime}",
                                    '${dateformate.format(DateTime.parse(datamember[index].revTime))}',
                                    style: TextStyle(
                                      color: tTextColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${datamember[index].revTopic}",
                                  style: TextStyle(
                                    color: tTextColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${datamember[index].revDetail}",
                                  maxLines: 5,
                                  style: TextStyle(
                                    color: tTextColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                  // ],
                },
              ),
            ),
    );
  }

  // Widget imgsuser(imageName) {
  //   Widget child;
  //   print('Imagename : $imageName');
  //   if (imageName != null) {
  //     child = Image.network('${Connectapi().domainimguser}${imageName}');
  //   } else {
  //     child = Image.asset('assets/images/person.png');
  //   }
  //   return new Container(child: child);
  // }

  Widget imgsuser(imageName) => ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: CachedNetworkImage(
          key: UniqueKey(),
          imageUrl: '${Connectapi().domainimguser}${imageName}',
          fit: BoxFit.cover,
          placeholder: (context, imageUrl) => ShowProgress().loading(),
          errorWidget: (context, imageUrl, error) =>
              Image.asset('assets/images/person.png'),
        ),
      );
}
