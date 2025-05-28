import 'package:flutter/material.dart';
import 'package:projet_picsou/core/custom_navigator.dart';
import 'package:projet_picsou/services/friend_service.dart';
import '../dialogs/alert_dialog_builder.dart';
import '../exceptions/request_exception.dart';

class FriendWidgetController with ChangeNotifier {
  final FriendService friendService;

  FriendWidgetController(this.friendService);

  Future<void> deleteFriend(int friendId) async {
    DialogBuilder.yesOrNo(
        "Voulez-vous vraiment supprimer cet ami ?",
        "Cette action est irréversible.",
        () async {
          DialogBuilder.loading();
          try {
            await friendService.deleteFriend(friendId);
            DialogBuilder.closeCurrentDialog();
            CustomNavigator.back();
            notifyListeners();
          } on NetworkException catch (e) {
            DialogBuilder.networkError(e.networkError);
          } catch (_) {
            DialogBuilder.appError();
          }
        }
    );
  }



}
