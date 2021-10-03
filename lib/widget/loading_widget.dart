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

  Widget loadingScreen() {
    return Center(
      child: CircularProgressIndicator(
        color: tPimaryColor,
      ),
    );
  }

  Widget loadingBotton() {
    return Center(
      child: CircularProgressIndicator(
        color: Colors.white,
      ),
    );
  }

  Widget loadingDialog() {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 20,
      backgroundColor: tBGColor,
      child: Container(
        width: 100,
        height: 100,
        child: Center(
          child: CircularProgressIndicator(
            color: tPimaryColor,
          ),
        ),
      ),
    );
  }
}
