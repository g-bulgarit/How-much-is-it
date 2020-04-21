import 'package:flutter/material.dart';
import 'dart:math';
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
  final TextEditingController controller = new TextEditingController();
  String convertedResult = "";
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
                    List userConversions = this.getUserConversionRequest(result[1]);

                    double userUnitToConvert = result[0];
                    String selectedUnit = userConversions[0];
                    double multiplier = userConversions[1];
                    String selectedCategory = userConversions[2];

                    convertedResult = this.convertToRandomUnit(selectedCategory, selectedUnit, userUnitToConvert, multiplier);
                  });
                  // Remove text from textbox
                  controller.text = "";
                },
              ),
              new Text("$convertedResult"),
            ], 
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
          output = [unitName.toString(), unitValue.toDouble(), categoryName.toString()];
        }
      }
      )));
      return output;   
  }

  String convertToRandomUnit(inCategory, inUnit, inUnitValue, multiplier){
    String outStr = "";
    double calculatedValue = 0.0;
    double conversionValue = 0.0;
    String toUnit = "";

    // Get size of the convertTo map
    int maxSize = convertTo.length;

    // Pick random unit from constants.convertTo and convert to it!
    var rng = new Random();
    int randEntryLoc = rng.nextInt(maxSize);
    toUnit = convertTo[inCategory].keys.toList()[randEntryLoc].toString();
    conversionValue = convertTo[inCategory][toUnit].toDouble();


    // Do conversion:
    calculatedValue = inUnitValue * multiplier.toDouble() /  conversionValue;


    outStr = inUnitValue.toString() + " " 
             + inUnit.toString() + " is " 
             + calculatedValue.toString() + " " + toUnit;

    return outStr;
  }

}