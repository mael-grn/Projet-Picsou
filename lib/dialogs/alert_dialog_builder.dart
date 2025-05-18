
import 'package:flutter/material.dart';
import 'package:projet_picsou/widgets/ui/Text_field_widget.dart';

class DialogBuilder {
  static Future<void> warning(BuildContext context, String title, String content) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              title
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                  height: 200,
                  width: 200,
                  "images/warning.png"
              ),
              Text(content)
            ]
          ),

          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> yesOrNo(BuildContext context, String title, String content, Function onYes, [Function? onNo]) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              title
          ),
          content: Text(content),

          actions: <Widget>[
            TextButton(
              child: const Text('Non'),
              onPressed: () {
                if (onNo != null) {
                  onNo();
                }
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Oui'),
              onPressed: () {
                onYes();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}