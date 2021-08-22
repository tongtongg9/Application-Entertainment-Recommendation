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
