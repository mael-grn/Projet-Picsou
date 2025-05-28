import 'package:flutter/material.dart';
import 'package:projet_picsou/core/custom_navigator.dart';
import 'package:projet_picsou/dialogs/alert_dialog_builder.dart';
import 'package:projet_picsou/exceptions/request_exception.dart';
import 'package:projet_picsou/models/friend_request.dart';
import 'package:projet_picsou/services/user_service.dart';
import 'package:projet_picsou/views/user_profile_view.dart';
import 'package:projet_picsou/widgets/user/user_glance_widget.dart';
import '../main.dart';
import '../models/friend.dart';
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
      DialogBuilder.warning(
        "Attention !",
        "Il semble que vous essayer de vous ajouter vous-même en ami. Malheureseusement, cela n'est pas possible.",
      );
      return;
    }

    DialogBuilder.loading();

    String email = emailController.text;

    try {
      User foundUser = await userService.getUserFromEmail(email);
      List<Friend> friends = await friendService.getAllFriends();
      List<FriendRequest> friendRequests =
          await friendService.getAllFriendRequests();
      if (friends.any(
            (friend) =>
                friend.user1.id == foundUser.id ||
                friend.user2.id == foundUser.id,
          ) ||
          friendRequests.any(
            (request) =>
                request.fromUser.id == foundUser.id ||
                request.toUser.id == foundUser.id,
          )) {
        DialogBuilder.warning(
          "Attention !",
          "Vous êtes déjà amis avec cet utilisateur ou vous avez déjà envoyé une demande d'ami.",
        );
        return;
      }

      DialogBuilder.closeCurrentDialog();
      CustomNavigator.pushFromRight(
        UserProfileView(
          user: foundUser,
          showSensitive: false,
          actions: [
            ButtonWidget(
              backgroundColor: Colors.redAccent,
              message: "Annuler",
              icon: Icons.cancel,
              onPressed: () {
                CustomNavigator.back();
              },
            ),
            SizedBox(width: 10),
            ButtonWidget(
              message: "Ajouter",
              icon: Icons.add_circle_outlined,
              onPressed: () async {
                DialogBuilder.loading();
                try {
                  await friendService.sendFriendRequest(foundUser.id);
                  DialogBuilder.closeCurrentDialog();
                  DialogBuilder.success(
                    "Bravo !",
                    "Vous avez envoyé une demande d'ami. Attendez que l'utilisateur accepte votre demande pour devenir amis.",
                    onCLose: () {
                      CustomNavigator.back();
                      CustomNavigator.back();
                    },
                  );
                } on NetworkException catch (e) {
                  DialogBuilder.networkError(
                    e.networkError,
                    personalizedErrors: [
                      (
                        code: 404,
                        title: "Utilisateur introuvable",
                        message:
                            "aucun utilisateur n'a été trouvé avec cet e-mail",
                      ),
                      (
                        code: 409,
                        title: "Demande d'ami déjà envoyée",
                        message:
                            "Vous avez déjà envoyé une demande d'ami à cet utilisateur, ou alors celui-ci vous à déjà envoyé une demande d'amis.",
                      ),
                    ],
                  );
                } catch (e) {
                  DialogBuilder.appError();
                }
              },
            ),
          ],
        ),
      );
      notifyListeners();
    } on NetworkException catch (e) {
      DialogBuilder.networkError(
        e.networkError,
        personalizedErrors: [
          (
            code: 404,
            title: "Utilisateur introuvable",
            message: "aucun utilisateur n'a été trouvé avec cet e-mail",
          ),
        ],
      );
    } catch (e) {
      DialogBuilder.appError();
    }
  }
}
