import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HelpDialog{
  widgetHelpDialog(BuildContext context){
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context){
        return AlertDialog(
          title: Center(child: Text("How To Use")),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Try:"),
                Text("Miles, Minutes, Liters, "),
                Divider(height: 20,),
                Text(
                  '''This app could not have been made without great help from my friends,\nAll of whom I cherish and love.'''),
              ],
            )
          ),
        );
      }
    );
  }
}
