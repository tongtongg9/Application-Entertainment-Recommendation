import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:my_finalapp1/owner/Booking_ow_detail.dart';
import 'package:my_finalapp1/owner/Booking_ow_list.dart';
import 'package:my_finalapp1/routes/routes.dart';
import 'package:my_finalapp1/user/Page/Home/Booking_user_get.dart';
import 'package:my_finalapp1/widget/colors.dart';

import 'package:my_finalapp1/MainPage.dart';
import 'package:my_finalapp1/MainPageOwner.dart';
import 'package:my_finalapp1/MainPageUser.dart';
import 'package:my_finalapp1/owner/ShowDetailNP_owner.dart';
import 'package:my_finalapp1/np/add_Imgs_np.dart';
import 'package:my_finalapp1/user/Page/Home/Bookings_user.dart';
import 'package:my_finalapp1/user/Page/Home/DetailNp.dart';
import 'package:my_finalapp1/user/Page/Home/Review_np_list.dart';
import 'package:my_finalapp1/user/Page/Home/Review_user.dart';
import 'package:my_finalapp1/user/bottom_nav_bar.dart';
import 'package:my_finalapp1/user/Page/Profile/Profile.dart';
import 'package:my_finalapp1/np/AddNP.dart';
import 'package:my_finalapp1/owner/Dashboard.dart';
import 'package:my_finalapp1/owner/EditPageOw.dart';
import 'package:my_finalapp1/owner/MyPubOw.dart';
import 'package:my_finalapp1/owner/ShowDataOw.dart';
import 'package:my_finalapp1/user/uploadPicture.dart';
import 'package:my_finalapp1/user/Page/Profile/EditPageUser.dart';
import 'package:my_finalapp1/owner/LoginPageOw.dart';
import 'package:my_finalapp1/user/LoginUser.dart';
import 'package:my_finalapp1/user/RegisUser.dart';
import 'package:my_finalapp1/owner/RegisterPageOw.dart';
import 'package:my_finalapp1/user/Page/Profile/ShowDataUser.dart';

void main() {
  runApp(MyApp());

  Intl.defaultLocale = "th";
  initializeDateFormatting();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: mytheme(),
      initialRoute: '/main',
      routes: {
        '/main': (context) => MainPage(),
        '/mainpageuser': (context) => MainPageUser(),
        '/mainpageowner': (context) => MainPageOwner(),
        '/uloginpage': (context) => LoginUser(),
        // '/uloginpage': ( context) => LoginPage(),
        // '/uregisterpage': ( context) => RegisterPage(),
        '/uregisterpage': (context) => RegisUser(),
        '/homepage': (context) => BottomNavBar(),
        // '/showdetailnp': ( context) => ShowDetailNp(),
        '/showdetailnp': (context) => DetailNp(),
        '/reviewpage': (context) => ReviewPage(),
        '/reservepage': (context) => ReservePage(),
        '/showbookinguser': (context) => ShowBookingUser(),
        '/showbookingowner': (context) => ShowBookingOwner(),
        '/showdetailbookingow': (context) => BookingDetailow(),
        '/reviewlistnp': (context) => ReviewListNp(),
        '/uprofilescreen': (context) => Profile(),
        '/upload': (context) => UploadPicture(),
        '/showdataUser': (context) => ShowDataUser(),
        '/editdataUser': (context) => EditPageUser(),

        // '/owloginpage' : ( context) => LoginPageOw(),

        //  '/': ( context) => LoginPageOw(),

        '/owloginpage': (context) => LoginPageOw(),
        '/owregisterpage': (context) => RegisterPageOw(),
        '/owdashboard': (context) => Dashboard(),
        '/owshowdata': (context) => ShowDataOw(),
        '/oweditdata': (context) => EditPageOw(),
        '/owmypub': (context) => MyPubOw(),
        '/showdetailnpowner': (context) => ShowDetailNPowner(),
        // '/owaddmypub' : ( context) => RegisterPageOw(),
        '/owaddmypub': (context) => AddNP(),
        '/addimgsnp': (context) => AddImagesNP(),
      },
    );
  }

  ThemeData mytheme() {
    return ThemeData(
      scaffoldBackgroundColor: tBGColor,
      fontFamily: 'Mitr',
      appBarTheme: AppBarTheme(
        centerTitle: true,
        color: tBGColor,
        elevation: 0,
        iconTheme: IconThemeData(
          color: tPimaryColor,
        ),
        textTheme: TextTheme(
          title: TextStyle(
            fontFamily: 'Mitr',
            color: tTextColor,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
