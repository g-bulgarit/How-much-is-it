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

    // Get 80% of size of screen in the width axis.
    double cWidth = MediaQuery.of(context).size.width*0.9;

    return new Scaffold(
      backgroundColor: backgroundColorMain,
      body: new Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [backgroundColorMain, textColorHint],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            
            ),
          ),
          
        
        padding: EdgeInsets.only(top: 40,
                                 bottom: 40,
                                 right: 5,
                                 left: 5),
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Expanded(
                flex: 2,
                child:new TextField(
                style: TextStyle(
                  color: textColorMain,
                  fontFamily: 'Bebas',
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
                controller: controller,
                textAlign: TextAlign.center,
                decoration: new InputDecoration(
                  hintText: "How much is...?",

                  // Set borders around the text input:
                  // On load:
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.all(Radius.circular(40))
                  ),

                  // On focus:
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.all(Radius.circular(40))
                  ),

                  // Set hint text:
                  hintStyle: TextStyle(
                    color: textColorHint,
                  ),

                  // Add suffix icon:
                  suffixIcon: Icon(Icons.search, color: textColorMain,),

                  // Fill color:
                  filled: true,
                  fillColor: foregroundAccent,

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

              new Expanded(
                flex: 7,
                child: new Container(
                  width: cWidth,
                  alignment: Alignment.center,
                  
                  decoration: BoxDecoration(
                    shape:  BoxShape.circle,
                    color: foregroundColorDark,
                  ),

                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.all(10.0),
                  
                  child: new Text(
                    "$convertedResult",
                    textAlign: TextAlign.center,
                    textScaleFactor: 1,
                    style: TextStyle(
                      color: textColorMain,
                      fontFamily: 'Bebas',
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                )
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
    calculatedValue = inUnitValue * multiplier.toDouble() /  conversionValue.toDouble();

    // Use sprintf to format values:
    oStr = sprintf("%g %s is %g %s", [inUnitValue,
                                      inUnit.toString(),
                                      calculatedValue,
                                      toUnit.toString()]);
    return oStr;
  }

}