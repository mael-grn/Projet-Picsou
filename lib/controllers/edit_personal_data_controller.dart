import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_picsou/dialogs/alert_dialog_builder.dart';
import 'package:projet_picsou/exceptions/request_exception.dart';
import 'package:projet_picsou/services/user_service.dart';
import '../main.dart';
import '../models/user.dart';

class EditPersonalDataController with ChangeNotifier {
  final UserService userService;
  User? user;
  bool userUpdated = false;
  final lastNameController = TextEditingController();
  final firstNameController = TextEditingController();
  final phoneController = TextEditingController();
  static final context = navigatorKey.currentContext;

  EditPersonalDataController(this.userService);

  void initUser() {
    try {
      DialogBuilder.loading();

      user = User.getCurrentUserInstance();
      lastNameController.text = user!.lastName;
      firstNameController.text = user!.firstName;
      phoneController.text = user!.tel;
    } catch (e) {
      user = null;
    } finally {
      DialogBuilder.closeCurrentDialog();
    }
  }

  Future<void> updateUser(GlobalKey<FormState> formKey) async {

    if (!formKey.currentState!.validate()) {
    return;
    }

    DialogBuilder.loading();

    HapticFeedback.mediumImpact();
    String lastName = lastNameController.text;
    String firstName = firstNameController.text;
    String phone = phoneController.text;

    if (user != null) {
      final newUser = User(
        user!.id,
        firstName,
        lastName,
        user!.email,
        phone,
        user!.emailPaypal,
        user!.telWero,
        user!.rib,
        user!.profilPictureRef,
        user!.password,
      );

      try {
        user = await userService.updateUser(newUser);
        DialogBuilder.success(
          "Succès",
          "Vos données personnelles ont été mises à jour.",
            () {
              Navigator.pop(context!);
            }
        );
        userUpdated = true;
        notifyListeners();
      } on NetworkException catch (e) {
        DialogBuilder.networkError(e.networkError);
      } catch (_) {
        DialogBuilder.appError();
      }
    }
  }
}
