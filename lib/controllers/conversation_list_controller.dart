import 'package:flutter/material.dart';
import 'package:projet_picsou/services/group_service.dart';
import '../enums/network_error_enum.dart';
import '../exceptions/request_exception.dart';
import '../models/group.dart';

class ConversationListController with ChangeNotifier {
  String? error;
  bool isLoading = false;
  List<Group> groups = [];
  GroupService groupService;

  ConversationListController(this.groupService);

  Future<void> getAllGroups() async {
    isLoading = true;
    notifyListeners();

    try {
      groups = await groupService.getGroupsForUser();
    } on NetworkException catch (e) {
      if (e.networkError == NetworkErrorEnum.unauthorized) {
        error = "Vous devez être connecté pour accéder à cette page.";
      } else {
        error = "Une erreur serveur est survenue. Merci de vérifier si l'application est à jour. Nous faisons tout notre possible pour résoudre le problème.";
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

}