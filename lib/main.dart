import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:my_finalapp1/routes/routes.dart';
import 'package:my_finalapp1/widget/colors.dart';

void main() {
  runApp(MyApp());

  Intl.defaultLocale = "th";
  initializeDateFormatting();
}

class MyApp extends StatelessWidget {
  // get initialRoute => Routes();
  // get routes => Routes();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: mytheme(),
      initialRoute: '/main',
      routes: routes,
    );
  }

  ThemeData mytheme() {
    return ThemeData(
      // primaryColor: HexColor('#5dcbed'),
      // primaryColor: HexColor('#f34dc3'),
      // primaryColorLight: HexColor('#245c86'),
      // primaryColorDark: HexColor('#353b40'),
      // primaryColorDark: HexColor('#1a1e22'),
      // errorColor: HexColor('#d90429'),
      // backgroundColor: HexColor('#1a1e22'),
      // scaffoldBackgroundColor: HexColor('#353b40'),
      // scaffoldBackgroundColor: HexColor('#1a1e22'),
      scaffoldBackgroundColor: tBackgroundColor,
      // accentColor: HexColor('#1a1e22'),
      fontFamily: 'Mitr',
      appBarTheme: AppBarTheme(
        centerTitle: true,
        // color: HexColor('#1a1e22'),
        color: tBackgroundColor,
        elevation: 0,
        // brightness: Brightness.light,
        iconTheme: IconThemeData(
          color: tPimaryColor,
        ),
        textTheme: TextTheme(
          title: TextStyle(
            fontFamily: 'Mitr',
            color: tWhiteColor,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
