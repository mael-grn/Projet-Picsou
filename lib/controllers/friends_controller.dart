import 'package:flutter/material.dart';
import 'package:projet_picsou/models/friend.dart';
import 'package:projet_picsou/models/friend_request.dart';
import 'package:projet_picsou/services/friend_service.dart';
import '../dialogs/alert_dialog_builder.dart';
import '../exceptions/request_exception.dart';

class FriendsController with ChangeNotifier {
  final FriendService friendService;
  List<FriendRequest> friendRequests = [];
  List<Friend> friends = [];

  FriendsController(this.friendService);

  Future<void> initFriends() async {
    DialogBuilder.loading();
    try {
      friendRequests = await friendService.getAllFriendRequests();
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

  Future<void> acceptFriendRequest(FriendRequest friendRequest) async {
    DialogBuilder.loading();
    try {
      await friendService.acceptFriendRequest(friendRequest.id);
      friendRequests.remove(friendRequest);
      friends = await friendService.getAllFriends();
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
    } catch (e) {
      print(e);
      DialogBuilder.appError();
    }
  }

}
