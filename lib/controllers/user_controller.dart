
import 'package:flutter/cupertino.dart';

import '../models/friend.dart';

class UserController extends ChangeNotifier {

  /// Returns all the friends of the user.
  Future<List<Friend>> getAllFriends() async {
    await Future.delayed(Duration(seconds: 2));
    return Future.value([
      ]);

  }

  /// Returns the friend with the given id.
  Future<Friend> getFriend(friendId) async {
    await Future.delayed(Duration(seconds: 2));
    return Future.value();
  }
}