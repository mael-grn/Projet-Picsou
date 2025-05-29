import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_picsou/dialogs/alert_dialog_builder.dart';
import 'package:projet_picsou/exceptions/request_exception.dart';
import 'package:projet_picsou/services/user_service.dart';
import '../../main.dart';
import '../../models/user.dart';

class EditPaiementDataController with ChangeNotifier {
  final UserService userService;
  final paypalController = TextEditingController();
  final weroController = TextEditingController();
  final ribController = TextEditingController();
  static final context = navigatorKey.currentContext;

  EditPaiementDataController(this.userService);

  Future<void> updateUser(GlobalKey<FormState> formKey) async {

    if (!formKey.currentState!.validate()) {
    return;
    }

    DialogBuilder.loading();

    HapticFeedback.mediumImpact();
    String paypal = paypalController.text;
    String wero = weroController.text;
    String rib = ribController.text;

    final newUser = User(
      User.getCurrentUserInstance().id,
      User.getCurrentUserInstance().firstName,
      User.getCurrentUserInstance().lastName,
      User.getCurrentUserInstance().email,
      User.getCurrentUserInstance().tel,
      paypal,
      wero,
      rib,
      User.getCurrentUserInstance().profilPictureRef,
      User.getCurrentUserInstance().password,
    );

    try {
      await userService.updateUser(newUser);
      DialogBuilder.success(
          "Succès",
          "Vos données de paiement ont été mises à jour.",
            onCLose:  () {
            Navigator.pop(context!);
          }
      );
      notifyListeners();
    } on NetworkException catch (e) {
      DialogBuilder.networkError(e.networkError,);
    } catch (_) {
      DialogBuilder.appError();
    }
  }
}
