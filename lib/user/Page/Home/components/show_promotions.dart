import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:my_finalapp1/widget/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ShowPromotions extends StatefulWidget {
  const ShowPromotions({
    Key key,
  }) : super(key: key);

  @override
  _ShowPromotionsState createState() => _ShowPromotionsState();
}

class _ShowPromotionsState extends State<ShowPromotions> {
  int activeIndex = 0;
  final urlImg = [
    'https://images.unsplash.com/photo-1448570289386-7ec70f72f7dc?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1050&q=80',
    'https://images.unsplash.com/photo-1495981910432-f5186aae41ad?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
    'https://images.unsplash.com/photo-1569951707784-04494c5ed864?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1090&q=80',
    'https://images.unsplash.com/photo-1569402604464-6f466a53141e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1050&q=80',
    'https://images.unsplash.com/photo-1498085245356-7c3cda3b412f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1134&q=80',
    'https://images.unsplash.com/photo-1462737459557-3b7df9ed8f4c?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
  ];

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CarouselSlider.builder(
            options: CarouselOptions(
              height: 250,
              viewportFraction: 1,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 2),
              enableInfiniteScroll: false,
            ),
            itemCount: urlImg.length,
            itemBuilder: (context, index, realIndex) {
              final urlImgs = urlImg[index];
              return Container(
                // margin: EdgeInsets.symmetric(horizontal: 5),
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  urlImgs,
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
          SizedBox(height: 10),
          // buildIndicator(),
        ],
      );

  // Widget buildImage(String urlImg, int) =>

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: 0,
        count: urlImg.length,
        effect: WormEffect(
          dotHeight: 8,
          dotWidth: 8,
          activeDotColor: tPimaryColor,
          dotColor: tGreyColor,
        ),
      );
}
