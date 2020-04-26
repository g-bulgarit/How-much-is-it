
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:how_much_is_it/constants.dart';
import 'dart:math';
import 'package:sprintf/sprintf.dart';


class InputCalcDisp extends StatefulWidget{
  final String userText;
  final String userSubtext;
  
  // State object

  InputCalcDisp({@required this.userText, @required this.userSubtext});
  @override
  _InputCalcDispState createState() => _InputCalcDispState();

}

class _InputCalcDispState extends State<InputCalcDisp> {
  String userText = "";
  String userSubtext = "";
  double amtToConvert = 0.0;
  double unitMultiplier = 0.0;
  String unitFrom = "";
  String categoryFrom = "";

  // ------------------ Functions -----------

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
  // ----------------------------------------

  void doCalculations(String inStr){
    List result = this.praseText(inStr);
    List userConversions = this.getUserConversionRequest(result[1]);

    // Retain some info in variables
    amtToConvert = result[0];
    unitFrom = userConversions[0];
    unitMultiplier = userConversions[1];
    categoryFrom = userConversions[2];

    // Do the conversion and store it in the class' variable.
    userText = this.convertToRandomUnit(categoryFrom, unitFrom, amtToConvert, unitMultiplier);
    userSubtext = getRandomSubtext();
  }

  @override
  Widget build(BuildContext context){
    return Column(
      children: <Widget>[
        Container(
          child: TextField(
            decoration: InputDecoration(
              hintText: "How much is...?"
            ),
          onSubmitted: (String str){
            setState(() {
              doCalculations(str);
            });
          },
          ),
        ),

        Container(
          child: Text(
            "$userText",
          ),
        ),

        Container(
          child: Text(
            "$userSubtext",
          ),
        ),

      ],
    );
  }
}