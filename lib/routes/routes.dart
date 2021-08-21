import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_finalapp1/MainPage.dart';
import 'package:my_finalapp1/MainPageOwner.dart';
import 'package:my_finalapp1/MainPageUser.dart';
import 'package:my_finalapp1/owner/ShowDetailNP_owner.dart';
import 'package:my_finalapp1/np/add_Imgs_np.dart';
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
import 'package:my_finalapp1/uploadPicture.dart';
import 'package:my_finalapp1/user/Page/Profile/EditPageUser.dart';
import 'package:my_finalapp1/owner/LoginPageOw.dart';
import 'package:my_finalapp1/user/LoginUser.dart';
import 'package:my_finalapp1/user/RegisUser.dart';
import 'package:my_finalapp1/owner/RegisterPageOw.dart';
import 'package:my_finalapp1/user/Page/Profile/ShowDataUser.dart';

final Map<String, WidgetBuilder> routes = {
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
};
