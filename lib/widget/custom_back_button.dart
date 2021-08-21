import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    Key key,
    @required this.tapBack
  }) : super(key: key);

  final GestureTapCallback tapBack;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios_new),
      onPressed: tapBack,
    );
  }
}