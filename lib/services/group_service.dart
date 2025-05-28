import 'dart:convert';

import 'package:projet_picsou/models/group.dart';

import '../core/provider.dart';
import '../models/user.dart';

class GroupService {

  Future<List<Group>> getAllGroups() async {
    final response = await Provider.sendRequestWithCookies(
        route : '/groups',
        method: HttpMethod.GET
    );
    return (jsonDecode(response) as List)
        .map((json) => Group.fromJson(json))
        .toList();
  }

  Future<void> createGroup(Group group) async {
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