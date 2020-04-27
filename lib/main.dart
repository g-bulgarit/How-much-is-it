import 'package:flutter/material.dart';

import 'colors.dart';
import 'customWidgets/InputCalcDisp.dart';


void main(){
  runApp(new MaterialApp(
    theme: ThemeData(
      fontFamily: 'Bebas',
      textTheme: TextTheme(
        title: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold, color: textColorMain),
        body1: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: textColorMain),
        body2: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: textColorMain),
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

  final TextEditingController textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.only(
          top: 40.0,
          left: 18.0,
          right: 18.0,
          bottom: 6.0,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [gradientBottom, gradientCenter, gradientTop],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: [0.35,0.65,1]
            ),
          ),

          child:InputCalcDisp(
              userText: "",
              userSubtext: "",
            ),
      ),
    );
  }
}
