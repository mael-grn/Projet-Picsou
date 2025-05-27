import 'package:flutter/material.dart';
import 'package:projet_picsou/dialogs/alert_dialog_builder.dart';
import 'package:projet_picsou/exceptions/request_exception.dart';
import 'package:projet_picsou/services/user_service.dart';
import 'package:projet_picsou/views/welcom_screen_view.dart';
import '../core/theme/custom_navigator.dart';
import '../models/user.dart';

class SelectProfilePictureController with ChangeNotifier {
  final UserService userService;
  String selectedProfilePicture = "";
  final profilePictureList = [
    "https://6q7xemamt4xekhet.public.blob.vercel-storage.com/1-IvHGkdEmlE4R9xy8xxxHVBUD3R7Y4U.png",
    "https://6q7xemamt4xekhet.public.blob.vercel-storage.com/2-zJBSjydpEFU3fZyRx9OTaXjE2x4pwS.png",
    "https://6q7xemamt4xekhet.public.blob.vercel-storage.com/3-hhmhism9G9RGUOSxW8hpv1LAjkrMuV.png",
    "https://6q7xemamt4xekhet.public.blob.vercel-storage.com/4-RMemqi6ybWeMWG8tyceq3QbNUQL7hJ.png",
    "https://6q7xemamt4xekhet.public.blob.vercel-storage.com/5-RKMWbv7QktBuJwI4XlRMmNz4H6RmK6.png",
    "https://6q7xemamt4xekhet.public.blob.vercel-storage.com/6-vqXuNlcTnPomsvNBFCwBgaGH3jKCq6.png"
  ];

  SelectProfilePictureController(this.userService);

  void setSelectedProfilePicture(String url) {
    selectedProfilePicture = url;
    notifyListeners();
  }

  Future<void> updateUser() async {

    if (!profilePictureList.contains(selectedProfilePicture)) {
      DialogBuilder.warning("Attention !", "Vous n'avez sélectionné aucune image de profil. Cette étape est obligatoire.");
      return;
    }

    DialogBuilder.loading();

    final newUser = User(
      User.getCurrentUserInstance().id,
      User.getCurrentUserInstance().firstName,
      User.getCurrentUserInstance().lastName,
      User.getCurrentUserInstance().email,
      User.getCurrentUserInstance().tel,
      User.getCurrentUserInstance().emailPaypal,
      User.getCurrentUserInstance().telWero,
      User.getCurrentUserInstance().rib,
      selectedProfilePicture,
      User.getCurrentUserInstance().password,
    );

    try {
      await userService.updateUser(newUser);
      DialogBuilder.closeCurrentDialog();
      CustomNavigator.push(WelcomScreenView());
    } on NetworkException catch (e) {
      DialogBuilder.networkError(e.networkError);
    } catch (_) {
      DialogBuilder.appError();
    }
  }
}
