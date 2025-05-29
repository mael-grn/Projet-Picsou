import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_picsou/dialogs/alert_dialog_builder.dart';
import 'package:projet_picsou/exceptions/request_exception.dart';
import 'package:projet_picsou/services/friend_service.dart';
import 'package:projet_picsou/services/user_service.dart';
import '../../main.dart';
import '../../models/friend_request.dart';
import '../../models/user.dart';

class SentFriendRequestController with ChangeNotifier {
  final FriendService friendService;
  List<FriendRequest> friendRequests = [];
  SentFriendRequestController(this.friendService);

  Future<void> initFriends() async {
    try {
      friendRequests = await friendService.getAllFriendRequests();
      friendRequests = friendRequests.where((request) => request.fromUser.id == User.getCurrentUserInstance().id).toList();
      notifyListeners();
    } on NetworkException catch (e) {
      DialogBuilder.networkError(e.networkError);
    } catch (_) {
      DialogBuilder.appError();
    }
    return;
  }

  Future<void> declineFriendRequest(FriendRequest friendRequest) async {
    try {
      await friendService.rejectFriendRequest(friendRequest.id);
      friendRequests.remove(friendRequest);
      notifyListeners();
    } on NetworkException catch (e) {
      DialogBuilder.networkError(e.networkError);
    } catch (_) {
      DialogBuilder.appError();
    }
  }

}
