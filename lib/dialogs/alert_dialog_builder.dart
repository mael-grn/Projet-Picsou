
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../core/theme/app_theme.dart';

class DialogBuilder {
  static Future<void> warning(BuildContext context, String title, String content, [Function? onCLose]) {
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
                if (onCLose != null) {
                  onCLose();
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> loading(BuildContext context) {
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            width: 100,
            height: 100,
            child: Center(
              child: LoadingAnimationWidget.inkDrop(
                color: foregroundColor,
                size: 20,
              ),
            )
          )
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