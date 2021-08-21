import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_finalapp1/NewHome.dart';
import 'package:my_finalapp1/user/Page/Home/newHome.dart';
import 'package:my_finalapp1/widget/colors.dart';

import 'Page/Feed/Feed.dart';
import 'Page/Home/Home.dart';
import 'Page/Notification/Notification.dart';
import 'Page/Profile/Profile.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentTab = 0;
  final List<Widget> screens = [
    // Home(),
    NewwHome(),
    Feed(),
    Nontification(),
    Profile(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  // Widget currentScreen = Home();
  Widget currentScreen = NewwHome();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: tPimaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: tWhiteColor,
        shape: CircularNotchedRectangle(),
        notchMargin: 6,
        child: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 20),
                  // Spacer(),
                  homeScreen(context),
                  SizedBox(width: 20),
                  // Spacer(),
                  feedScreen(context),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  notiScreen(context),
                  SizedBox(width: 20),
                  profileScreen(context),
                  SizedBox(width: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  MaterialButton homeScreen(BuildContext context) {
    return MaterialButton(
      minWidth: 40,
      onPressed: () {
        setState(() {
          // currentScreen = Home();
          currentScreen = NewwHome();
          currentTab = 0;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ImageIcon(new AssetImage('assets/icons/home.png'),
              size: 28,
              color: currentTab == 0
                  ? tPimaryColor
                  : tGreyColor),
          // Text(
          //   'หน้าหลัก',
          //   style: TextStyle(
          //       fontSize: 14,
          //       fontWeight: FontWeight.normal,
          //       color: currentTab == 0
          //           ? tPimaryColor
          //           : tGreyColor),
          // ),
        ],
      ),
    );
  }

  MaterialButton feedScreen(BuildContext context) {
    return MaterialButton(
      minWidth: 40,
      onPressed: () {
        setState(() {
          currentScreen = Feed();
          currentTab = 1;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ImageIcon(new AssetImage('assets/icons/rss.png'),
              size: 28,
              color: currentTab == 1
                  ? tPimaryColor
                  : tGreyColor),
          // Text(
          //   'ฟีดข่าว',
          //   style: TextStyle(
          //       fontSize: 14,
          //       fontWeight: FontWeight.normal,
          //       color: currentTab == 1
          //           ? tPimaryColor
          //           : tGreyColor),
          // ),
        ],
      ),
    );
  }

  MaterialButton notiScreen(BuildContext context) {
    return MaterialButton(
      minWidth: 40,
      onPressed: () {
        setState(() {
          currentScreen = Nontification();
          currentTab = 3;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ImageIcon(new AssetImage('assets/icons/bell2.png'),
              size: 28,
              color: currentTab == 3
                  ? tPimaryColor
                  : tGreyColor),
          // Text(
          //   'แจ้งเตือน',
          //   style: TextStyle(
          //       fontSize: 14,
          //       fontWeight: FontWeight.normal,
          //       color: currentTab == 3
          //           ? tPimaryColor
          //           : tGreyColor),
          // ),
        ],
      ),
    );
  }

  MaterialButton profileScreen(BuildContext context) {
    return MaterialButton(
      minWidth: 40,
      onPressed: () {
        setState(() {
          currentScreen = Profile();
          currentTab = 4;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ImageIcon(new AssetImage('assets/icons/user.png'),
              size: 28,
              color: currentTab == 4
                  ? tPimaryColor
                  : tGreyColor),
          // Text(
          //   'โปรไฟล์',
          //   style: TextStyle(
          //       fontWeight: FontWeight.normal,
          //       fontSize: 14,
          //       color: currentTab == 4
          //           ? tPimaryColor
          //           : tGreyColor),
          // ),
        ],
      ),
    );
  }
} //! main Class
