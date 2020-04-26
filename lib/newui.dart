import 'package:flutter/material.dart';

import 'colors.dart';
import 'customWidgets/InputCalcDisp.dart';
import 'customWidgets/InfoDialog.dart';

void main(){
  runApp(new MaterialApp(
    theme: ThemeData(
      fontFamily: 'Bebas',
      textTheme: TextTheme(
        title: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold, color: textColorMain),
        body1: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: textColorMain),
      ),
    ),
    home: new HomePage()));
}

class HomePage extends StatefulWidget {

  @override
  AppHomePage createState() => new AppHomePage();
}

class AppHomePage extends State<HomePage>{
  String userText = "";
  String userSubtext = "";

  HelpDialog dialog = new HelpDialog();

  final TextEditingController textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [gradientBottom, gradientCenter, gradientTop],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            ),
          ),
        child: ListView(
          children: <Widget>[
            InputCalcDisp(
              userText: "",
              userSubtext: "",
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.info_outline), 
                  onPressed: (){
                    dialog.widgetHelpDialog(context);
                  }
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
