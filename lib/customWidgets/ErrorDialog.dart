import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:how_much_is_it/colors.dart';

class ErrorDialog {
  widgetErrorDialog(BuildContext context, String userInputUnit) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
                child: Text(
                    "The unit \'${userInputUnit}\' is not supported (yet)",
                    style: Theme.of(context).textTheme.headline1)),
            backgroundColor: foregroundColorDark,
            elevation: 24.0,
          );
        });
  }
}
