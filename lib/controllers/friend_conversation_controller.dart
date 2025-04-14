import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_picsou/exceptions/request_exception.dart';
import 'package:projet_picsou/services/friend_service.dart';
import 'package:projet_picsou/utils/token_utils.dart';
import 'package:restart_app/restart_app.dart';
import '../models/payment.dart';
import '../models/user.dart';

class FriendConversationController with ChangeNotifier {
  User? friend;
  double friendBalance = 0;
  bool showPopup = false;
  String? popupTitle;
  String? popupContent;
  String? popupImage;
  bool isLoading = false;
  String? error;
  List<Payment> payments = [];
  FriendService friendService;

  FriendConversationController(this.friendService);

  Future<void> getFriendBalance() async {
    isLoading = true;
    notifyListeners();
    try {
      friendBalance = await friendService.getFriendBalance(friend!.id);
    } on NetworkException catch (e) {
      error = e.message;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getLastPaymentFromFriend(int friendId) async {
    isLoading = true;
    notifyListeners();
    try {
      payments = await friendService.getLastPaymentFromFriend(friendId);
    } on NetworkException catch (e) {
      error = e.message;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
