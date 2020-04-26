import 'package:flutter/material.dart';

import 'colors.dart';
import 'customWidgets/InputCalcDisp.dart';
import 'customWidgets/InfoDialog.dart';

void main(){
  runApp(new MaterialApp(
    home: new HomePage()));
}

class HomePage extends StatefulWidget {

  @override
  AppHomePage createState() => new AppHomePage();
}

class AppHomePage extends State<HomePage>{
  String userText = "";
  String userSubtext = "";


  final TextEditingController textController = new TextEditingController();

  Widget infoButton = new Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.info_outline), 
          onPressed: (){
            // return InfoDialog();
          }
          ),
      ],
    ),
  );


  Widget infoScreen = new Container();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          InputCalcDisp(
            userText: "",
            userSubtext: "",
          ),
          infoButton,
        ],
      ),
    );
  }
}
