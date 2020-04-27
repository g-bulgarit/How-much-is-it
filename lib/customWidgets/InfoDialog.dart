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
                Text("Stuck? try the following:", style: Theme.of(context).textTheme.body2),
                Text("Miles, Minutes, Liters, Watts, Tons, Kelvin, who am I to judge?", style: Theme.of(context).textTheme.body2),
                Divider(height: 20, color: Colors.white, ),
                Text(
                  '''This app could not have been made without great help from my friends,\nAll of whom I cherish and love.''',
                   style: Theme.of(context).textTheme.body2),
                
                // TODO: ADD ROW OF ICONS
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: <Widget>[
                //     Icon(Icons.playlist_add_check)
                //   ],
                // )
              ],
            )
          ),
        );
      }
    );
  }
}
