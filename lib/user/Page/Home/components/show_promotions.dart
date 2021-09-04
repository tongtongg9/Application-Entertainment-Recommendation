import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:my_finalapp1/model/Connectapi.dart';
import 'package:my_finalapp1/model/model_get_img_promotions.dart';
import 'package:my_finalapp1/widget/colors.dart';
import 'package:my_finalapp1/widget/loading_widget.dart';
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
  int _current = 0;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

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
          CarouselSlider.builder(
            options: CarouselOptions(
              aspectRatio: 3 / 2,
              height: 250,
              viewportFraction: 1,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 5),
              enableInfiniteScroll: false,
            ),
            itemCount: datamember.length,
            itemBuilder: (context, index, realIndex) {
              return Container(
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(10),
                //   border: Border.all(
                //     width: 1,
                //     color: tPimaryColor,
                //   ),
                // ),
                width: MediaQuery.of(context).size.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: imgs(datamember[index].proImg),
                ),
              );
            },
          ),
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   height: 200,
          //   child: Swiper(
          //     onIndexChanged: (index) {
          //       setState(() {
          //         _current = index;
          //       });
          //     },
          //     autoplay: true,
          //     layout: SwiperLayout.DEFAULT,
          //     itemCount: datamember.length,
          //     itemBuilder: (BuildContext context, index) {
          //       return Container(
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(8),
          //           // image: DecorationImage(
          //           //   image: Image.network('${Connectapi().domainimgpro}${datamember[index].proImg}'),
          //           // ),
          //         ),
          //         child: imgs(datamember[index].proImg),
          //       );
          //     },
          //   ),
          // ),

          SizedBox(height: 10),
          // buildIndicator(),
          // Row(
          //   children: map<Widget>(datamember, (index, image) {
          //     return Container(
          //       alignment: Alignment.center,
          //       height: 9,
          //       width: 9,
          //       // margin: EdgeInsets.only(right: 8),
          //       decoration: BoxDecoration(shape: BoxShape.circle),
          //       color: _current == index ? tPimaryColor : tGreyColor,
          //     );
          //   }),
          // )
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
    return CachedNetworkImage(
      imageUrl: '${Connectapi().domainimgpro}${imageName}',
      fit: BoxFit.cover,
      placeholder: (context, url) => Center(
        child: ShowProgress().loading(),
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
