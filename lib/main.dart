// import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import 'colors.dart';
import 'customWidgets/InputCalcDisp.dart';


// void main() => runApp(
//   DevicePreview(
//     builder: (context) => MyApplication(),
//   )
// );

// class MyApplication extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       locale: DevicePreview.of(context).locale, // <--- Add the locale
//       builder: DevicePreview.appBuilder, // <--- Add the builder
//       title: 'Flutter Demo',
//       theme: appTheme,
//       home: new HomePage(),
//       );
//   }
// }

// Normal app operation:

void main(){
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: appTheme,
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
        top: 36.0,
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
