import 'package:flutter/material.dart';

void main(){
  runApp(new MaterialApp(
    home: new TextInput()
  ));
}

class TextInput extends StatefulWidget {
  @override
  MyTextState createState() => new MyTextState();

}

class MyTextState extends State<TextInput>{

  String lookup = "";
  final TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("How Much Is It?"),
        backgroundColor: Colors.amber,
      ),
      body: new Container(
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new TextField(
                controller: controller,
                textAlign: TextAlign.center,
                decoration: new InputDecoration(
                  hintText: "How much is...?"
                ),
                onSubmitted: (String str){
                  setState(() {
                    lookup = str;
                  });
                  controller.text = "";
                },
              ),
              new Text(lookup)
            ] 
          ),
        ),
      )
    );
  }
}