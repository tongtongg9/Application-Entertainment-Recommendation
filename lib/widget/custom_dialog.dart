import 'package:flutter/material.dart';
import 'package:my_finalapp1/widget/colors.dart';

class CustomDialog extends StatelessWidget {
  final String title, descriptoin, textsubmitButton, textcancelButton;
  final VoidCallback submit, cancel;

  CustomDialog(
      {this.title,
      this.descriptoin,
      this.textsubmitButton,
      this.textcancelButton,
      this.submit,
      this.cancel});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 20,
      backgroundColor: tBGColor,
      child: dialogContent(context),
    );
  }

  dialogContent(context) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.35,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                descriptoin,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(height: 30),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    primary: tPimaryColor,
                  ),
                  child: Text(
                    textsubmitButton,
                    style: TextStyle(
                      fontSize: 16,
                      color: tTextWColor,
                    ),
                  ),
                  onPressed: submit,
                ),
              ),
              SizedBox(height: 5),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    primary: tGreyColor,
                    side: BorderSide(color: tGreyColor),
                  ),
                  child: Text(
                    textcancelButton,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  onPressed: cancel,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
