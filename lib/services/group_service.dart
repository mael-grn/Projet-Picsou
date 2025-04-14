import '../core/provider.dart';
import '../models/group.dart';

class GroupService {

  Future<Group> createGroup(Group group) async {
    final response = await Provider.postSecure('/groups', group.toJson());
    return Group.fromJson(response['group']);
  }

  Future<Group> getGroupFromId(int groupId) async {
    final response = await Provider.getSecure('/groups/$groupId');
    return Group.fromJson(response['group']);
  }

  Future<void> updateGroup(Group group) async {
    await Provider.putSecure('/groups/${group.id}', group.toJson());
  }

  Future<void> deleteGroup(int groupId) async {
    await Provider.deleteSecure('/groups/$groupId', {});
  }

  Future<List<Group>> getGroupsForUser() async {
    return [];
    final response = await Provider.getSecure('/groups');
    return response['groups'].map<Group>((json) => Group.fromJson(json)).toList();
  }
}