import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_picsou/exceptions/request_exception.dart';
import 'package:projet_picsou/services/user_service.dart';
import '../models/user.dart';

class EditPersonalDataController with ChangeNotifier {
  final UserService userService;
  User? user;
  bool isLoading = false;
  String? error;
  bool userUpdated = false;
  final lastNameController = TextEditingController();
  final firstNameController = TextEditingController();
  final phoneController = TextEditingController();

  EditPersonalDataController(this.userService);

  void initUser() {
    try {
      isLoading = true;
      notifyListeners();

      user = User.getCurrentUserInstance();
      lastNameController.text = user!.lastName;
      firstNameController.text = user!.firstName;
      phoneController.text = user!.tel;
    } catch (e) {
      user = null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateUser() async {

    isLoading = true;
    notifyListeners();

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
        userUpdated = true;
      } on NetworkException catch (e) {
        error = e.networkError.message;
      } catch (_) {
        error = "Une erreur est survenue lors de la mise à jour de l'utilisateur.";
      } finally {
        isLoading = false;
        notifyListeners();
      }
    }
  }
}
