import 'package:flutter/material.dart';
import 'constants.dart';

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
  String category = "";

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
                    List result = this.praseText(str);
                    userNumber = result[0];
                    userText = result[1];
                    category = this.getUserConversionRequest(userText)[0];
                  });
                  // Remove text from textbox
                  controller.text = "";
                },
              ),
              new Text("(" + this.userText + ", " + this.userNumber.toString() + ")"),
              new Text("Found value in map: $category")
            ] 
          ),
        ),
      )
    );
  }

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

  List getUserConversionRequest(String inputStr){
    // Takes in user input and returns the category in which to compare.
    List output = [];
    // For each category, check if the inputStr is a value:
    convertFrom.forEach((categoryName, categoryValues) => (
      // The key is a new map, so iterate over it as well
      categoryValues.forEach((unitName, unitValue){
        if (inputStr == unitName){
          output = [unitName, unitValue];
        }
      }
      )));
      return output;   
  }

  generateRandomSize(inUnit, inUnitValue){
    // Pick random unit from constants.convertTo and convert to it!

  }

}