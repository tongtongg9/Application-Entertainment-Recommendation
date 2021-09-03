import 'package:flutter/material.dart';
import 'package:my_finalapp1/widget/custom_back_button.dart';

class ShowPromotionsList extends StatefulWidget {
  // ShowPromotionsList({Key? key}) : super(key: key);

  @override
  _ShowPromotionsListState createState() => _ShowPromotionsListState();
}

class _ShowPromotionsListState extends State<ShowPromotionsList> {
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
    );
  }
}
