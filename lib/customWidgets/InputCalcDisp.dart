import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:how_much_is_it/constants.dart';
import 'package:how_much_is_it/colors.dart';
import 'package:how_much_is_it/customWidgets/InfoDialog.dart';
import 'dart:math';
import 'package:sprintf/sprintf.dart';

class InputCalcDisp extends StatefulWidget {
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
  String savedInput = "";
  double amtToConvert = 0.0;
  double unitMultiplier = 0.0;
  String unitFrom = "";
  String categoryFrom = "";
  bool showHelpMessage = true;

  HelpDialog dialog = new HelpDialog();
  final TextEditingController textController = new TextEditingController();

  // ------------------ Functions -----------

  List praseText(String inputStr) {
    // Function to parse user input into <quantity> and <attribute>
    double quantity = 0.0;
    String attribute = "";

    RegExp extractQuantity = RegExp(r'^[0-9.]+');
    RegExp extractAttribute = RegExp(r'\s+([A-Za-z\s]+)');

    quantity = double.parse(extractQuantity.firstMatch(inputStr).group(0));
    attribute = extractAttribute.firstMatch(inputStr).group(1).toLowerCase();

    return [quantity, attribute];
  }

  List getUserConversionRequest(String inputStr) {
    // Takes in user input and returns the category in which to compare.
    List output = [];
    // For each category, check if the inputStr is a value:
    convertFrom.forEach((categoryName, categoryValues) => (
            // The key is a new map, so iterate over it as well
            categoryValues.forEach((unitName, unitValue) {
          if (inputStr == unitName) {
            output = [
              unitName.toString(),
              unitValue.toDouble(),
              categoryName.toString()
            ];
          }
        })));
    return output;
  }

  String convertToRandomUnit(inCategory, inUnit, inUnitValue, inMultiplier) {
    // Function to take in a user input, convert it and return an output string.
    //  Params:
    //  - inCategory: category of the user input - choose answer from this category as well.
    //  - inUnit: the user's actual unit.
    //  - inUnitValue: the user's numeric input.
    //  - inMultiplier: scale multiplier.

    String outputStr = "";
    bool is_approx = false;
    String toUnit = "";
    double calculatedValue = 0.0;
    String roundedCalculatedValue = "";
    double conversionValue = 0.0;

    // Get size of the convertTo map
    int maxSize = convertTo[inCategory].length;

    // Pick random unit from constants.convertTo and convert to it!
    var rng = new Random();
    int randEntryLoc = rng.nextInt(maxSize);
    toUnit = convertTo[inCategory].keys.toList()[randEntryLoc].toString();
    conversionValue = convertTo[inCategory][toUnit].toDouble();

    // Do conversion:
    calculatedValue =
        inUnitValue * inMultiplier.toDouble() / conversionValue.toDouble();
    if (calculatedValue > 1) {
      roundedCalculatedValue = calculatedValue.roundToDouble().toString();
      is_approx = true;
    } else {
      // Handle floating point rounding here?
      int fp_amount = calculatedValue.toString().length;
      int zero_amt = RegExp("0").allMatches(calculatedValue.toString()).length;
      if (zero_amt > 3) {
        roundedCalculatedValue = calculatedValue.toStringAsFixed(zero_amt);
      } else {
        roundedCalculatedValue = calculatedValue.toString();
      }
    }

    // Consider classification by size here - if the number is very small or very large,
    // maybe a different format would suit it better, like % of or 3*10^24 instead of 3e24
    // Use sprintf to format values:
    if (!is_approx) {
      outputStr = sprintf("%s %s is %s %s", [
        inUnitValue,
        inUnit.toString(),
        roundedCalculatedValue,
        toUnit.toString()
      ]);
    } else {
      outputStr = sprintf("%s %s is approximately %s %s", [
        inUnitValue,
        inUnit.toString(),
        roundedCalculatedValue,
        toUnit.toString()
      ]);
    }
    is_approx = false;

    return outputStr;
  }

  String getRandomSubtext() {
    // Returns a random subtext string from the list in constants.dart
    var rng = new Random();
    int sizeofList = subtextList.length;
    int randEntryLoc = rng.nextInt(sizeofList);
    return subtextList[randEntryLoc];
  }

  // ----------------------------------------

  void doCalculations(String inStr) {
    List result = this.praseText(inStr);
    List userConversions = this.getUserConversionRequest(result[1]);

    // Retain some info in variables
    amtToConvert = result[0];
    unitFrom = userConversions[0];
    unitMultiplier = userConversions[1];
    categoryFrom = userConversions[2];

    // Do the conversion and store it in the class' variable.
    userText = this.convertToRandomUnit(
        categoryFrom, unitFrom, amtToConvert, unitMultiplier);
    userSubtext = getRandomSubtext();
    showHelpMessage = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        children: <Widget>[
          Flexible(
            flex: 2,
            child: Container(
              margin: EdgeInsets.only(left: 36, right: 36, top: 36),
              child: TextField(
                controller: textController,
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.center,
                style: Theme.of(context).textTheme.headline1,
                decoration: InputDecoration(
                  hintText: "How much is...?",
                  hintStyle: Theme.of(context).textTheme.headline1,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: textColorMain, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(40))),

                  // On focus:
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: textColorMain, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                ),
                onSubmitted: (String str) {
                  setState(() {
                    doCalculations(str);
                  });
                  textController.text = "";
                },
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),

          Container(
            child: Text(
                showHelpMessage ? "(Input your irrelevant question here)" : "",
                style: Theme.of(context).textTheme.subtitle1),
          ),

          SizedBox(
            height: 50,
          ),

          Flexible(
            flex: 6,
            child: Center(
              child: Container(
                margin: EdgeInsets.only(left: 36, right: 36),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: userText != "" ? Colors.white : Colors.transparent,
                      width: 2,
                    )),
                child: Text(
                  "$userText",
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),

          SizedBox(
            height: 20,
          ),

          // Spacer(),
          Flexible(
            flex: 2,
            child: Center(
              child: Container(
                child: Text(
                  "$userSubtext",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
          ),

          SizedBox(
            height: 20,
          ),

          Flexible(
            flex: 1,
            child: Container(
              child: IconButton(
                  icon: Icon(
                    Icons.refresh,
                    size: 40,
                  ),
                  color: userText != "" ? Colors.white : Colors.transparent,
                  onPressed: userText == ""
                      ? () {}
                      : () {
                          setState(() {
                            userText = this.convertToRandomUnit(categoryFrom,
                                unitFrom, amtToConvert, unitMultiplier);
                            userSubtext = getRandomSubtext();
                          });
                        }),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.info_outline,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: () {
                      dialog.widgetHelpDialog(context);
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
