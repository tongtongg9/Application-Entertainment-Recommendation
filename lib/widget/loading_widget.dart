import 'package:flutter/material.dart';
import 'package:my_finalapp1/widget/colors.dart';

class ShowProgress {
  Widget loading() {
    return Center(
      child: CircularProgressIndicator(
        color: tPimaryColor,
      ),
    );
  }
}
