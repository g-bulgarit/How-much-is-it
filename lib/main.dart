import 'dart:ui';

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
  String subtext = "";

  // ----------------------------------
  //          State Variables         |
  // ---------------------------------
  double amtToConvert = 0.0;
  String unitFrom = "";
  double unitMultiplier = 0.0;
  String categoryFrom = "";
  // --------------------------------- 

  @override
  Widget build(BuildContext context){
    // Override the build method when we load this state

    // Get 90% of size of screen in the width axis.
    double cWidth = MediaQuery.of(context).size.width*0.9;

    return new Scaffold(
      // Make sure that the keyboard does not squeeze the app up
      resizeToAvoidBottomInset: false,
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
                                 right: 15,
                                 left: 15),
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
                Container(
                  height: 100,
                  child: new TextField(
                  style: TextStyle(
                    color: textColorMain,
                    fontFamily: 'Bebas',
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
                  controller: controller,
                  textAlign: TextAlign.center,
                  decoration: new InputDecoration(
                    hintText: "How much is...?",

                    // Set borders around the text input:
                    // On load:
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: textColorMain, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(40))
                    ),

                    // On focus:
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: foregroundColorInner, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(40))
                    ),

                    // Set hint text:
                    hintStyle: TextStyle(
                      color: textColorHint,
                    ),

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
                      amtToConvert = result[0];
                      unitFrom = userConversions[0];
                      unitMultiplier = userConversions[1];
                      categoryFrom = userConversions[2];

                      // Do the conversion and store it in the class' variable.
                      convertedResult = this.convertToRandomUnit(categoryFrom, unitFrom, amtToConvert, unitMultiplier);
                      subtext = getRandomSubtext();
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
                  height: cWidth,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape:  BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2
                    ),
                    // color: foregroundColorDark,
                    gradient: RadialGradient(
                      colors: [foregroundColorInner, foregroundColorDark],
                      
                    )
                  ),

                  padding: EdgeInsets.all(20.0),
                  margin: EdgeInsets.all(20.0),
                  
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

              new Container(
                height: 150,
                child:Center(
                  child: Text(
                    "$subtext",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: textColorMain,
                        fontFamily: 'Bebas',
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.italic,
                        fontSize: 30,
                      ),
                    ),
                ),
              ),
              
              new Container(
                width: 50,
                alignment: Alignment.center,
                child: new IconButton(
                icon: new Icon(
                  Icons.refresh,
                  color: Colors.white,
                  size: (35)),
                onPressed: (){
                  setState(() {
                    // Re-do calculation
                    convertedResult = this.convertToRandomUnit(categoryFrom, unitFrom, amtToConvert, unitMultiplier);
                    subtext = getRandomSubtext();
                  });
                },
              ),
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

    RegExp extractQuantity = RegExp(r'^[0-9.]+');
    RegExp extractAttribute = RegExp(r'\s+([A-Za-z\s]+)'); 

    quantity = double.parse(extractQuantity.firstMatch(inputStr).group(0));
    attribute = extractAttribute.firstMatch(inputStr).group(1).toLowerCase();

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

  String convertToRandomUnit(inCategory, inUnit, inUnitValue, inMultiplier){
    // Function to take in a user input, convert it and return an output string.
    //  Params:
    //  - inCategory: category of the user input - choose answer from this category as well.
    //  - inUnit: the user's actual unit.
    //  - inUnitValue: the user's numeric input.
    //  - inMultiplier: scale multiplier.

    String outputStr = "";

    String toUnit = "";
    double calculatedValue = 0.0;
    double conversionValue = 0.0;

    // Get size of the convertTo map
    int maxSize = convertTo[inCategory].length;

    // Pick random unit from constants.convertTo and convert to it!
    var rng = new Random();
    int randEntryLoc = rng.nextInt(maxSize);
    toUnit = convertTo[inCategory].keys.toList()[randEntryLoc].toString();
    conversionValue = convertTo[inCategory][toUnit].toDouble();

    // Do conversion:
    calculatedValue = inUnitValue * inMultiplier.toDouble() /  conversionValue.toDouble();

    // Consider classification by size here - if the number is very small or very large,
    // maybe a different format would suit it better, like % of or 3*10^24 instead of 3e24

    // Use sprintf to format values:
    outputStr = sprintf("%g %s is %g %s", [inUnitValue,
                                           inUnit.toString(),
                                           calculatedValue,
                                           toUnit.toString()]);
    return outputStr;
  }


  String getRandomSubtext(){
    // Returns a random subtext string from the list in constants.dart
    var rng = new Random();
    int sizeofList = subtextList.length;
    int randEntryLoc = rng.nextInt(sizeofList);

    return subtextList[randEntryLoc];
  }

}