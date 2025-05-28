import 'package:flutter/material.dart';
import 'package:projet_picsou/dialogs/alert_dialog_builder.dart';
import 'package:projet_picsou/exceptions/request_exception.dart';
import 'package:projet_picsou/services/user_service.dart';
import 'package:projet_picsou/widgets/user/user_glance_widget.dart';
import '../main.dart';
import '../models/user.dart';
import '../services/friend_service.dart';
import '../widgets/ui/button_widget.dart';

class SearchUserWithEmailController with ChangeNotifier {
  final UserService userService;
  final FriendService friendService;
  final emailController = TextEditingController();
  static final context = navigatorKey.currentContext;

  SearchUserWithEmailController(this.userService, this.friendService);

  Future<void> searchUser(GlobalKey<FormState> formKey) async {

    if (!formKey.currentState!.validate()) {
      return;
    }

    if (emailController.text == User.getCurrentUserInstance().email) {
      DialogBuilder.warning("Attention !", "Il semble que vous essayer de vous ajouter vous-même en ami. Malheureseusement, cela n'est pas possible.");
      return;
    }

    DialogBuilder.loading();

    String email = emailController.text;

    try {
      User foundUser = await userService.getUserFromEmail(email);
      DialogBuilder.customDialog(
          UserGlanceWidget(
            user: foundUser,
          ),
          [
            ButtonWidget(
              backgroundColor: Colors.redAccent,
                message: "Annuler",
                icon: Icons.cancel,
                onPressed: () {
                  DialogBuilder.closeCurrentDialog();
                }
            ),
            ButtonWidget(
                message: "Ajouter",
                icon: Icons.add_circle_outlined,
                onPressed: () async {
                  DialogBuilder.closeCurrentDialog();
                  DialogBuilder.loading();
                  try {
                    await friendService.sendFriendRequest(foundUser.id);
                    DialogBuilder.success("Bravo !",
                        "Vous avez envoyé une demande d'ami. Attendez que l'utilisateur accepte votre demande pour devenir amis.");
                  } on NetworkException catch (e) {
                    DialogBuilder.networkError(
                        e.networkError,
                      personalizedErrors: [
                        (code: 404, title: "Utilisateur introuvable", message: "aucun utilisateur n'a été trouvé avec cet e-mail"),
                        (code: 409, title: "Demande d'ami déjà envoyée", message: "Vous avez déjà envoyé une demande d'ami à cet utilisateur, ou alors celui-ci vous à déjà envoyé une demande d'amis.")
                      ]
                    );
                  } catch (e) {
                    DialogBuilder.appError();
                  }
                }
            )
          ]
      );
      notifyListeners();
    } on NetworkException catch (e) {
      DialogBuilder.networkError(e.networkError,
          personalizedErrors: [
        (code: 404, title: "Utilisateur introuvable", message: "aucun utilisateur n'a été trouvé avec cet e-mail")
      ]);
    } catch (e) {
      DialogBuilder.appError();
    }
  }
}

