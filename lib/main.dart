import 'package:flutter/material.dart';

void main(){
  runApp(new MaterialApp(
    home: new TextInput()
  ));
}

class TextInput extends StatefulWidget {
  @override
  UserTextInput createState() => new UserTextInput();

}


class UserTextInput extends State<TextInput>{
  String userText = "";
  double userNumber = 0.0;

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
                    //final Tuple2<double, String> result = this.praseText(str);
                    List result = this.praseText(str);
                    userNumber = result[0];
                    userText = result[1];
                  });
                  // Remove text from textbox
                  controller.text = "";
                },
              ),
              new Text("(" + this.userText + "," + this.userNumber.toString() + ")")
            ] 
          ),
        ),
      )
    );
  }

  // Tuple2 <double, String> praseText(String inputStr){
  //   // Function to parse user input into <quantity> and <attribute>

  //   double quantity = 0.0;
  //   String attribute = "";

  //   RegExp extractQuantity = RegExp(r'^[0-9]+');
  //   RegExp extractAttribute = RegExp(r'[A-Za-z]+');

  //   quantity = double.parse(extractQuantity.firstMatch(inputStr).group(0));
  //   attribute = extractAttribute.firstMatch(inputStr).group(0);

  //   return new Tuple2(quantity, attribute);
  // }

  List praseText(String inputStr){
    // Function to parse user input into <quantity> and <attribute>

    double quantity = 0.0;
    String attribute = "";

    RegExp extractQuantity = RegExp(r'^[0-9]+');
    RegExp extractAttribute = RegExp(r'[A-Za-z]+');

    quantity = double.parse(extractQuantity.firstMatch(inputStr).group(0));
    attribute = extractAttribute.firstMatch(inputStr).group(0);

    return [quantity, attribute];
  }
}