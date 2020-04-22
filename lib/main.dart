import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

import 'dart:math';
import 'constants.dart';

import 'colors.dart';

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
      backgroundColor: backgroundColorMain,
      body: new Container(
        padding: EdgeInsets.all(50),
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Expanded(
                flex: 2,
                child:new TextField(
                style: TextStyle(
                  color: textColorMain,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
                controller: controller,
                textAlign: TextAlign.center,
                decoration: new InputDecoration(
                  hintText: "How much is...?",
                  hintStyle: TextStyle(
                    color: textColorHint,
                  ),
                ),
                onSubmitted: (String str){
                  setState(() {
                    // On submit, calculate stuff and call the build method again.
                    // Parse user input with regex
                    List result = this.praseText(str);
                    List userConversions = this.getUserConversionRequest(result[1]);

                    // Retain some info in variables
                    double userUnitToConvert = result[0];
                    String selectedUnit = userConversions[0];
                    double multiplier = userConversions[1];
                    String selectedCategory = userConversions[2];

                    // Do the conversion and store it in the class' variable.
                    convertedResult = this.convertToRandomUnit(selectedCategory, selectedUnit, userUnitToConvert, multiplier);
                  });
                  // Remove text from textbox
                  controller.text = "";
                },
              ),
              ),
              
              new Divider(
                height: 20.0,
                color: Color(0x00FFFFFF),
              ),

              new Expanded(
                flex: 4,
                child: new Text("$convertedResult",
                  textAlign: TextAlign.center,
                  textScaleFactor: 1,
                  style: TextStyle(
                    color: textColorMain,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.normal,
                    fontSize: 40,
                  ),),
              ),
              new Expanded(
                flex: 4,
                child: new Image(image: AssetImage("assets/w4_2.PNG")),
                ),
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
    String oStr = "";
    double calculatedValue = 0.0;
    double conversionValue = 0.0;
    String toUnit = "";

    // Get size of the convertTo map
    int maxSize = convertTo[inCategory].length;

    // Pick random unit from constants.convertTo and convert to it!
    var rng = new Random();
    int randEntryLoc = rng.nextInt(maxSize);
    toUnit = convertTo[inCategory].keys.toList()[randEntryLoc].toString();
    conversionValue = convertTo[inCategory][toUnit].toDouble();

    // Do conversion:
    calculatedValue = inUnitValue * multiplier.toDouble() /  conversionValue;

    // Use sprintf to format values:
    oStr = sprintf("%g %s is %g %s", [inUnitValue,
                                      inUnit.toString(),
                                      calculatedValue,
                                      toUnit.toString()]);

    return oStr;
  }

}