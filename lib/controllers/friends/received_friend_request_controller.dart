import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_picsou/dialogs/alert_dialog_builder.dart';
import 'package:projet_picsou/exceptions/request_exception.dart';
import 'package:projet_picsou/services/friend_service.dart';
import 'package:projet_picsou/services/user_service.dart';
import 'package:provider/provider.dart';
import '../../main.dart';
import '../../models/friend_request.dart';
import '../../models/user.dart';
import 'friends_controller.dart';

class ReceivedFriendRequestController with ChangeNotifier {
  final FriendService friendService;
  List<FriendRequest> friendRequests = [];
  ReceivedFriendRequestController(this.friendService);

  Future<void> initFriends() async {
    DialogBuilder.loading();
    try {
      friendRequests = await friendService.getAllFriendRequests();
      friendRequests = friendRequests.where((request) => request.toUser.id == User.getCurrentUserInstance().id).toList();
      DialogBuilder.closeCurrentDialog();
      notifyListeners();
    } on NetworkException catch (e) {
      DialogBuilder.networkError(e.networkError);
    } catch (_) {
      DialogBuilder.appError();
    }
    return;
  }

  Future<void> acceptFriendRequest(FriendRequest friendRequest) async {
    DialogBuilder.loading();
    try {
      await friendService.acceptFriendRequest(friendRequest.id);
      friendRequests.remove(friendRequest);
      DialogBuilder.closeCurrentDialog();
      notifyListeners();
    } on NetworkException catch (e) {
      DialogBuilder.networkError(e.networkError);
    } catch (_) {
      DialogBuilder.appError();
    }
  }

  Future<void> declineFriendRequest(FriendRequest friendRequest) async {
    DialogBuilder.loading();
    try {
      await friendService.rejectFriendRequest(friendRequest.id);
      friendRequests.remove(friendRequest);
      DialogBuilder.closeCurrentDialog();
      notifyListeners();
    } on NetworkException catch (e) {
      DialogBuilder.networkError(e.networkError);
    } catch (_) {
      DialogBuilder.appError();
    }
  }

}
