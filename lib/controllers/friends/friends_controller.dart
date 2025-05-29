import 'package:flutter/material.dart';
import 'package:projet_picsou/models/friend.dart';
import 'package:projet_picsou/models/friend_request.dart';
import 'package:projet_picsou/services/friend_service.dart';
import '../../core/custom_navigator.dart';
import '../../dialogs/alert_dialog_builder.dart';
import '../../exceptions/request_exception.dart';

class FriendsController with ChangeNotifier {
  final FriendService friendService;
  List<FriendRequest> friendRequests = [];
  List<Friend> friends = [];

  FriendsController(this.friendService);

  Future<void> initFriends() async {
    DialogBuilder.loading();
    try {
      friends = await friendService.getAllFriends();
      DialogBuilder.closeCurrentDialog();
      notifyListeners();
    } on NetworkException catch (e) {
      DialogBuilder.networkError(e.networkError);
    } catch (_) {
      DialogBuilder.appError();
    }
    return;
  }

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
