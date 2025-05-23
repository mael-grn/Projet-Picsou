import 'package:flutter/material.dart';
import 'package:projet_picsou/dialogs/alert_dialog_builder.dart';
import 'package:projet_picsou/exceptions/request_exception.dart';
import 'package:projet_picsou/services/user_service.dart';
import '../main.dart';
import '../models/user.dart';

class SearchUserWithEmailController with ChangeNotifier {
  final UserService userService;
  final emailController = TextEditingController();
  static final context = navigatorKey.currentContext;

  SearchUserWithEmailController(this.userService);

  Future<void> searchUser(GlobalKey<FormState> formKey) async {

    if (!formKey.currentState!.validate()) {
      return;
    }

    DialogBuilder.loading();

    String email = emailController.text;

    try {
      User foundUser = await userService.getUserFromEmail(email);
      DialogBuilder.yesOrNo(
          "${foundUser.firstName} ${foundUser.lastName}",
          "L'adresse email que vous avez saisie correspond à ${foundUser.firstName} ${foundUser.lastName}. Voulez-vous lui envoyer une demande d'amis ?",
              () {
            Navigator.pop(context!);
          }
      );
      notifyListeners();
    } on NetworkException catch (e) {
      DialogBuilder.networkError(e.networkError,
          personalizedErrors: [
        (code: 404, title: "Utilisateur introuvable", message: "aucun utilisateur n'a été trouvé avec cet e-mail")
      ]);
    } catch (_) {
      DialogBuilder.appError();
    }
  }
}
