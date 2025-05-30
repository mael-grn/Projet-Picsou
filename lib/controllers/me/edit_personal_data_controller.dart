import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_picsou/dialogs/alert_dialog_builder.dart';
import 'package:projet_picsou/exceptions/request_exception.dart';
import 'package:projet_picsou/services/user_service.dart';
import '../../main.dart';
import '../../models/user.dart';

class EditPersonalDataController with ChangeNotifier {
  final UserService userService;
  final lastNameController = TextEditingController();
  final firstNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  String profilePict = "";
  static final context = navigatorKey.currentContext;

  EditPersonalDataController(this.userService);

  void editProfilePicture(String profilePict) {
    this.profilePict = profilePict;
    notifyListeners();
  }

  Future<void> updateUser(GlobalKey<FormState> formKey) async {

    if (!formKey.currentState!.validate()) {
    return;
    }

    DialogBuilder.loading();

    HapticFeedback.mediumImpact();
    String lastName = lastNameController.text;
    String firstName = firstNameController.text;
    String email = emailController.text;
    String phone = phoneController.text;

    final newUser = User(
      User.getCurrentUserInstance().id,
      firstName,
      lastName,
      email,
      phone,
      User.getCurrentUserInstance().emailPaypal,
      User.getCurrentUserInstance().telWero,
      User.getCurrentUserInstance().rib,
      profilePict.isEmpty ? User.getCurrentUserInstance().profilPictureRef : profilePict,
      User.getCurrentUserInstance().password,
    );

    try {
      await userService.updateUser(newUser);
      DialogBuilder.success(
          "Succès",
          "Vos données personnelles ont été mises à jour.",
            onCLose:  () {
            Navigator.pop(context!);
          }
      );
      notifyListeners();
    } on NetworkException catch (e) {
      DialogBuilder.networkError(
          e.networkError,
        personalizedErrors: [
          (code: 409, message: "Un compte avec cette adresse email existe déjà.", title: "Erreur"),
        ]
      );
    } catch (_) {
      DialogBuilder.appError();
    }
  }
}
