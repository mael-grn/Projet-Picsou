import 'dart:convert';

import 'package:projet_picsou/models/group.dart';

import '../core/provider.dart';
import '../models/user.dart';

class GroupService {

  Future<bool> isGroupDiscussion(int groupId) async {
    List<UserWithStatus> users = await getUserFromGroup(groupId);
    return users.length == 2;
  }

  Future<Group> tryGetGroupDataFromDiscussion(Group group) async {
    List<UserWithStatus> users = await getUserFromGroup(group.id!);
    if (users.length != 2) {
      return group;
    }
    User user = users.firstWhere(
      (user) => user.user.id != User.getCurrentUserInstance().id
    ).user;
    return Group(
        group.id,
      "${user.firstName} ${user.lastName}",
      user.profilPictureRef
    );
  }

  Group groupDataFromDiscussion(group, List<UserWithStatus> users)  {
    if (users.length != 2) {
      return group;
    }
    User user = users.firstWhere(
            (user) => user.user.id != User.getCurrentUserInstance().id
    ).user;
    return Group(
        group.id,
        "${user.firstName} ${user.lastName}",
        user.profilPictureRef
    );
  }

  Future<List<UserWithStatus>> getUserFromGroup(int groupId) async {
    final response = await Provider.sendRequestWithCookies(
        route : '/groups/$groupId/users',
        method: HttpMethod.GET
    );
    return (jsonDecode(response) as List)
        .map((json) => UserWithStatus.fromJson(json))
        .toList();
  }

  Future<List<Group>> getAllGroups() async {
    final response = await Provider.sendRequestWithCookies(
        route : '/me/groups',
        method: HttpMethod.GET
    );
    return (jsonDecode(response) as List)
        .map((json) => Group.fromJson(json))
        .toList();
  }

  Future<void> createGroup(GroupWithUser group) async {
    await Provider.sendRequestWithCookies(
        route : '/groups',
        method: HttpMethod.POST,
        body: group.toJson()
    );
  }

  Future<List<User>> getGroupWithUser(int groupId) async {
    final response = await Provider.sendRequestWithCookies(
        route : '/groups/$groupId/users',
        method: HttpMethod.GET
    );
    return (jsonDecode(response) as List)
        .map((json) => User.fromJson(json))
        .toList();
  }

}