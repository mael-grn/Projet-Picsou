import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:projet_picsou/widgets/ui/button_widget.dart';

import '../core/theme/app_theme.dart';
import '../enums/network_error_enum.dart';
import '../main.dart';
import '../widgets/animations/scale_animation_widget.dart';

class DialogBuilder {
  static final context = navigatorKey.currentContext;
  static bool _isDialogOpen = false;

  static Future<void> _showDialog(Widget Function(BuildContext) builder) {
    if (context == null) {
      return Future.value();
    }
    if (_isDialogOpen) {
      closeCurrentDialog();
    }
    _isDialogOpen = true;
    return showDialog<void>(
      barrierDismissible: false,
      context: context!,
      builder: builder,
    );
  }

  static closeCurrentDialog() {
    if (context == null) {
      return;
    }
    if (_isDialogOpen) {
      Navigator.of(context!).pop();
      _isDialogOpen = false;
    }
  }

  static Future<void> _simpleImageDialog(
    String title,
    String content,
    String image, [
    Function? onCLose,
  ]) {
    return _showDialog((BuildContext context) {
      return ScaleAnimationWidget(
        child: AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(width: 300, height: 200, image),
                SizedBox(height: 20),
                Text(
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  title,
                ),
                SizedBox(height: 20),
                Text(textAlign: TextAlign.center, content),
              ],
            ),
          ),

          actions: <Widget>[
            ButtonWidget(
                message: "Ok",
                icon: Icons.check,
                onPressed: () {
                  closeCurrentDialog();
                  if (onCLose != null) {
                    onCLose();
                  }
                }
            )
          ],
        )
      );
    });
  }

  static Future<void> success(
    String title,
    String content, {
        Function? onCLose,
      }) {
    return _simpleImageDialog(
      title,
      content,
      "images/thumbs_up.png",
      onCLose,
    );
  }

  static Future<void> warning(
    String title,
    String content, {
        Function? onCLose,
      }) {
    return _simpleImageDialog(
      title,
      content,
      "images/warning.png",
      onCLose,
    );
  }

  static Future<void> networkError(
    NetworkErrorEnum error, {
        List<
            ({int code, String title, String message})> personalizedErrors = const [
        ],
        Function? onCLose,
      }) {
    String image = "";
    String title = "Une erreur s'est produite lors de la connexion au serveur";
    String detailedMessage = "";
    switch (error) {
      case NetworkErrorEnum.unauthorized:
        detailedMessage =
            "Vous n'êtes pas autorisé à accéder à cette ressource. Veuillez vous connecter.";
        image = "images/bodyguard.png";
        break;
      case NetworkErrorEnum.forbidden:
        detailedMessage =
            "Accès refusé. Vous n'avez pas les autorisations nécessaires.";
        image = "images/bodyguard.png";
        break;
      case NetworkErrorEnum.notFound:
        detailedMessage =
            "La ressource demandée est introuvable. Verifiez les mises à jour de l'application.";
        image = "images/searching.png";
        break;
      case NetworkErrorEnum.requestTimeout:
        detailedMessage =
            "Le serveur a mis trop de temps à répondre. Veuillez réessayer plus tard.";
        image = "images/timer.png";
      case NetworkErrorEnum.internalServerError:
        detailedMessage =
            "Erreur interne du serveur. Veuillez réessayer plus tard.";
        image = "images/broken_server.png";
        break;
      case _:
        detailedMessage =
            "Une erreur s'est produite. Veuillez réessayer plus tard.";
        image = "images/broken_phone.png";
    }

    for (var e in personalizedErrors) {
      if (e.code == error.code) {
        title = e.title;
        detailedMessage = e.message;
      }
    }

    return _simpleImageDialog(
      title,
      "$detailedMessage (${error.code} : ${error.message})",
      image,
      onCLose,
    );
  }

  static Future<void> serverError({Function? onCLose}) {
    return _simpleImageDialog(
      "Erreur",
      "Une erreur s'est produite lors de la connexion aux serveurs. Veuillez réessayer plus tard",
      "images/broken_server.png",
      onCLose,
    );
  }

  static Future<void> appError({Function? onCLose}) {
    return _simpleImageDialog(
      "Erreur",
      "Une erreur s'est produite dans l'application. Essayez de verifier les mises à jours. Si le problème persiste, vous pouvez contacter le support.",
      "images/broken_phone.png",
      onCLose,
    );
  }

  static Future<void> error(String title, String content, {Function? onCLose}) {
    return _simpleImageDialog(
      title,
      content,
      "images/error.png",
      onCLose,
    );
  }

  static Future<void> loading() {
    return _showDialog((BuildContext context) {
      return AlertDialog(
        content: SizedBox(
          width: 100,
          height: 100,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LoadingAnimationWidget.inkDrop(
                  color: foregroundColor,
                  size: 30,
                ),
                const SizedBox(height: 20),
                const Text("Chargement..."),
              ],
            ),
          ),
        ),
      );
    });
  }

  static Future<void> customDialog(Widget content, List<Widget> actions) {
    return _showDialog((BuildContext context) {
      return AlertDialog(
        content: content,
        actions: actions,
      );
    });
  }

  static Future<void> yesOrNo(
    String title,
    String content,
    Function onYes, {
        Function? onNo,
      }) {
    return _showDialog((BuildContext context) {
      return ScaleAnimationWidget(
          child: AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(width: 300, height: 200, "images/interrogation.png"),
                  SizedBox(height: 20),
                  Text(
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    title,
                  ),
                  SizedBox(height: 20),
                  Text(textAlign: TextAlign.center, content),
                ],
              ),
            ),

            actions: <Widget>[
              ButtonWidget(
                  message: "Non",
                  backgroundColor: Colors.redAccent,
                  icon: Icons.close,
                  onPressed: () {
                    closeCurrentDialog();
                    if (onNo != null) {
                      onNo();
                    }
                  }
              ),
              ButtonWidget(
                  message: "Oui",
                  icon: Icons.check,
                  onPressed: () {
                    closeCurrentDialog();
                    onYes();
                  }
              )
            ],
          )
      );
    });
  }
}
