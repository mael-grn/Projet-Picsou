import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_picsou/dialogs/alert_dialog_builder.dart';
import 'package:projet_picsou/exceptions/request_exception.dart';
import 'package:projet_picsou/services/user_service.dart';
import '../main.dart';
import '../models/user.dart';

class EditPersonalDataController with ChangeNotifier {
  final UserService userService;
  final lastNameController = TextEditingController();
  final firstNameController = TextEditingController();
  final phoneController = TextEditingController();
  static final context = navigatorKey.currentContext;

  EditPersonalDataController(this.userService);

  Future<void> updateUser(GlobalKey<FormState> formKey) async {

    if (!formKey.currentState!.validate()) {
    return;
    }

    DialogBuilder.loading();

    HapticFeedback.mediumImpact();
    String lastName = lastNameController.text;
    String firstName = firstNameController.text;
    String phone = phoneController.text;

    final newUser = User(
      User.getCurrentUserInstance().id,
      firstName,
      lastName,
      User.getCurrentUserInstance().email,
      phone,
      User.getCurrentUserInstance().emailPaypal,
      User.getCurrentUserInstance().telWero,
      User.getCurrentUserInstance().rib,
      User.getCurrentUserInstance().profilPictureRef,
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
      DialogBuilder.networkError(e.networkError);
    } catch (_) {
      DialogBuilder.appError();
    }
  }
}
