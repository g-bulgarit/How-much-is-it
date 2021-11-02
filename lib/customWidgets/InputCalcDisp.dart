import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:how_much_is_it/constants.dart';
import 'package:how_much_is_it/colors.dart';
import 'package:how_much_is_it/customWidgets/InfoDialog.dart';
import 'package:how_much_is_it/customWidgets/ErrorDialog.dart';
import 'dart:math';
import 'package:sprintf/sprintf.dart';

class InputCalcDisp extends StatefulWidget {
  final String userText;
  final String userSubtext;
  final String currentUnit;
  final String currentSubtext;
  final String hintText;

  // State object

  InputCalcDisp(
      {@required this.userText,
      @required this.userSubtext,
      @required this.currentUnit,
      @required this.currentSubtext,
      @required this.hintText});
  @override
  _InputCalcDispState createState() => _InputCalcDispState();
}

class _InputCalcDispState extends State<InputCalcDisp> {
  String userText = "";
  String userSubtext = "";
  String hintText = "try 50 meters";
  String currentSubtext = "";
  String currentUnit = "";
  String savedInput = "";
  double amtToConvert = 0.0;
  double unitMultiplier = 0.0;
  String unitFrom = "";
  String categoryFrom = "";
  bool showHelpMessage = true;

  HelpDialog dialog = new HelpDialog();
  ErrorDialog err_dialog = new ErrorDialog();
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

    if (output.isEmpty) {
      // The unit does not exist...
      err_dialog.widgetErrorDialog(context, inputStr);
      textController.text = "";
    }
    return output;
  }

  String convertToRandomUnit(inCategory, inUnit, inUnitValue, inMultiplier) {
    // Function to take in a user input, convert it and return an output string.
    //  Params:
    //  - inCategory: category of the user input - choose answer from this category as well.
    //  - inUnit: the user's actual unit.
    //  - inUnitValue: the user's numeric input.
    //  - inMultiplier: scale multiplier.

    String currentSelectedUnit = currentUnit;
    String outputStr = "";
    bool is_approx = false;
    String toUnit = "";
    double calculatedValue = 0.0;
    String roundedCalculatedValue = "";
    double conversionValue = 0.0;
    bool doneSelectingRandom = false;
    // Get size of the convertTo map
    int maxSize = convertTo[inCategory].length;

    // Pick random unit from constants.convertTo and convert to it!
    while (!doneSelectingRandom) {
      var rng = new Random();
      int randEntryLoc = rng.nextInt(maxSize);
      toUnit = convertTo[inCategory].keys.toList()[randEntryLoc].toString();

      if (toUnit == currentSelectedUnit) {
        doneSelectingRandom = false;
      } else {
        doneSelectingRandom = true;
        currentUnit = toUnit;
      }
    }
    conversionValue = convertTo[inCategory][toUnit].toDouble();

    // Do conversion:
    calculatedValue =
        inUnitValue * inMultiplier.toDouble() / conversionValue.toDouble();
    if (calculatedValue > 1) {
      roundedCalculatedValue = calculatedValue.roundToDouble().toString();
      is_approx = true;
    } else {
      // Handle floating point rounding here?
      int zero_amt = RegExp("0").allMatches(calculatedValue.toString()).length;
      if (zero_amt >= 2) {
        roundedCalculatedValue = calculatedValue.toStringAsFixed(zero_amt);
      } else {
        roundedCalculatedValue = calculatedValue.toString();
      }
    }

    // Consider classification by size here - if the number is very small or very large,
    // maybe a different format would suit it better, like % of or 3*10^24 instead of 3e24
    // Use sprintf to format values:
    if (!is_approx) {
      outputStr = sprintf("%s %s is about %s %s", [
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
    doneSelectingRandom = false;

    // Set new hinttext and amt:
    var rng = new Random();
    int randomHintNumber = rng.nextInt(1000);
    int randomSelectionNumber = rng.nextInt(maxSize);
    String hintTextUnit =
        convertFrom[inCategory].keys.toList()[randomSelectionNumber].toString();
    hintText = "Try " + randomHintNumber.toString() + " " + hintTextUnit;

    return outputStr;
  }

  String getRandomSubtext() {
    // Returns a random subtext string from the list in constants.dart
    bool doneSelecting = false;
    int sizeofList = subtextList.length;
    String currentSelectedSubtext = currentSubtext;

    while (!doneSelecting) {
      var rng = new Random();
      int randEntryLoc = rng.nextInt(sizeofList);
      if (subtextList[randEntryLoc] == currentSelectedSubtext) {
        doneSelecting = false;
      } else {
        doneSelecting = true;
        currentSubtext = subtextList[randEntryLoc];
      }
    }
    return currentSubtext;
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            constraints: BoxConstraints(minWidth: 400, maxWidth: 800),
            margin: EdgeInsets.only(top: 20, left: 36, right: 36, bottom: 20),
            child: RawKeyboardListener(
              focusNode: FocusNode(),
              onKey: (event) {
                if (event.logicalKey.keyId == 54) {
                  setState(() {
                    doCalculations(textController.text);
                  });
                  textController.text = "";
                }
              },
              child: TextField(
                controller: textController,
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.center,
                style: Theme.of(context).textTheme.headline1,
                decoration: InputDecoration(
                  hintText: "How much is...?",
                  hintStyle: Theme.of(context).textTheme.headline1,
                  suffixIcon: IconButton(
                    padding: EdgeInsets.all(15),
                    icon: Icon(Icons.send, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        doCalculations(textController.text);
                        textController.text = "";
                      });
                    },
                  ),
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

          Container(
            alignment: Alignment.center,
            constraints: BoxConstraints(minWidth: 400, maxWidth: 800),
            margin: EdgeInsets.only(top: 8, bottom: 16),
            child: Text(
                showHelpMessage
                    ? "( Enter your irrelevant conversion here )"
                    : "",
                style: Theme.of(context).textTheme.subtitle1),
          ),

          Center(
            child: Container(
              constraints: BoxConstraints(minWidth: 400, maxWidth: 800),
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

          SizedBox(
            height: 10,
          ),

          // Spacer(),
          Flexible(
            child: Center(
              child: Container(
                constraints: BoxConstraints(minWidth: 400, maxWidth: 800),
                child: Text(
                  "$userSubtext",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
          ),

          SizedBox(
            height: 10,
          ),

          Container(
            margin: EdgeInsets.only(left: 36, right: 36),
            padding: EdgeInsets.all(16.0),
            constraints: BoxConstraints(minWidth: 400, maxWidth: 800),
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
          SizedBox(
            height: 20,
          ),

          Container(
              margin: EdgeInsets.only(left: 36, right: 36, bottom: 8),
              padding: EdgeInsets.all(16.0),
              constraints: BoxConstraints(minWidth: 400, maxWidth: 800),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Writer's Block? "),
                  Text("$hintText"),
                ],
              )),

          Container(
            constraints: BoxConstraints(minWidth: 400, maxWidth: 800),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text("Irrelevant answers to your pressing issues.",
                    style: Theme.of(context).textTheme.subtitle2),
                IconButton(
                    icon: Icon(
                      Icons.info_outline,
                      color: Colors.white,
                      size: 18,
                    ),
                    onPressed: () {
                      dialog.widgetHelpDialog(context);
                    }),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
