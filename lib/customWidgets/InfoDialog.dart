import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:how_much_is_it/colors.dart';

class HelpDialog{

  widgetHelpDialog(BuildContext context){
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context){
        return AlertDialog(
          title: Center(child: Text("How To Use", style: Theme.of(context).textTheme.title)),
          backgroundColor: foregroundColorDark,
          elevation: 24.0,
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("try the following:", style: Theme.of(context).textTheme.body2),
                Text("Miles, Minutes, Liters, Watts, Tons...\nwho am I to judge?", style: Theme.of(context).textTheme.subtitle),
                Divider(height: 20, color: foregroundColorInner, thickness: 3,),
                Text(
                  '''This app could not have been made without a lot of help from my friends,\nWho I cherish and love.''',
                   style: Theme.of(context).textTheme.subtitle),
                SizedBox(height: 35,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.favorite, color: textColorMain,)
                  ],
                )
              ],
            )
          ),
        );
      }
    );
  }
}
