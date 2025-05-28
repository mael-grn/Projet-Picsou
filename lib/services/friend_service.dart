

import 'dart:convert';

import 'package:projet_picsou/models/friend_request.dart';

import '../core/provider.dart';
import '../models/friend.dart';
import '../models/user.dart';

class FriendService {

  Future<void> sendFriendRequest(int userId) async {
    await Provider.sendRequestWithCookies(
        route : '/me/friends/requests',
        method: HttpMethod.POST,
      body: {
        'from_user_id': User.getCurrentUserInstance().id,
        'to_user_id': userId,
      }
    );
  }

  Future<void> acceptFriendRequest(int requestId) async {
    print(requestId);
    await Provider.sendRequestWithCookies(
        route : '/me/friends/requests/$requestId',
        method: HttpMethod.PATCH
    );
  }

  Future<void> rejectFriendRequest(int requestId) async {
    await Provider.sendRequestWithCookies(
        route : '/me/friends/requests/$requestId',
        method: HttpMethod.DELETE
    );
  }

  Future<void> deleteFriend(int friendId) async {
    await Provider.sendRequestWithCookies(
        route : '/me/friends/$friendId',
        method: HttpMethod.DELETE
    );
  }

  Future<List<FriendRequest>> getAllFriendRequests() async {
    final response = await Provider.sendRequestWithCookies(
        route : '/me/friends/requests',
        method: HttpMethod.GET
    );
    return (jsonDecode(response) as List)
        .map((json) => FriendRequest.fromJson(json))
        .toList();
  }

  Future<List<Friend>> getAllFriends() async {
    final response = await Provider.sendRequestWithCookies(
        route : '/me/friends',
        method: HttpMethod.GET
    );
    return (jsonDecode(response) as List)
        .map((json) => Friend.fromJson(json))
        .toList();
  }
}