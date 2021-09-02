import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:my_finalapp1/model/Connectapi.dart';
import 'package:my_finalapp1/model/model_get_img_promotions.dart';
import 'package:my_finalapp1/widget/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class ShowPromotions extends StatefulWidget {
  // const ShowPromotions({
  //   Key key,
  // }) : super(key: key);

  @override
  _ShowPromotionsState createState() => _ShowPromotionsState();
}

class _ShowPromotionsState extends State<ShowPromotions> {
  int activeIndex = 0;

  List<Imgpro> datamember = [];

  var uId;
  var token;

  Future<Void> getList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    uId = prefs.getInt('id');
    print('uId = $uId');
    print('token = $token');
    var url = '${Connectapi().domain}/showimgproforuser';
    //conect
    var response = await http.get(Uri.parse(url), headers: {
      'Connect-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    //check response
    if (response.statusCode == 200) {
      //แปลงjson ให้อยู่ในรูปแบบ model members
      ImgPromotions members =
          ImgPromotions.fromJson(convert.jsonDecode(response.body));
      //รับค่า ข้อมูลทั้งหมดไว้ในตัวแปร
      setState(() {
        datamember = members.imgpro;
        // load = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //call _getAPI
    getList();
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: CarouselSlider.builder(
              options: CarouselOptions(
                aspectRatio: 16 / 9,
                height: 250,
                viewportFraction: 1,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 2),
                enableInfiniteScroll: false,
              ),
              itemCount: datamember.length,
              itemBuilder: (context, index, realIndex) {
                return Container(
                  // margin: EdgeInsets.symmetric(horizontal: 5),
                  width: MediaQuery.of(context).size.width,
                  child: imgs(datamember[index].proImg),
                );
              },
            ),
          ),
          SizedBox(height: 10),
          // buildIndicator(),
        ],
      );

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: datamember.length,
        effect: WormEffect(
          dotHeight: 8,
          dotWidth: 8,
          activeDotColor: tPimaryColor,
          dotColor: tGreyColor,
        ),
      );

  Widget imgs(imageName) {
    Widget child;
    print('Imagename : $imageName');
    if (imageName != null) {
      child = Image.network(
        '${Connectapi().domainimgpro}${imageName}',
        fit: BoxFit.cover,
      );
    } else {
      child = Image.asset('assets/images/person.png');
    }
    return new Container(child: child);
  }
}
