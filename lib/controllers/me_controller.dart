import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_picsou/services/user_service.dart';
import 'package:projet_picsou/utils/token_utils.dart';
import 'package:projet_picsou/widgets/user/edit_field_form_widget.dart';
import 'package:restart_app/restart_app.dart';
import '../enums/network_error_enum.dart';
import '../exceptions/request_exception.dart';
import '../models/user.dart';

class MeController with ChangeNotifier {
  final UserService userService;
  User? user;
  bool showPopup = false;
  Widget? popupContent;
  bool showFastPopup = false;
  String? fastPopupTitle;
  String? fastPopupContent;
  String? fastPopupImage;
  bool isLoading = false;
  String? error;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final paypalController = TextEditingController();
  late AnimationController animationsController;
  late Animation<Offset> offsetAnimation;

  MeController(this.userService);

  void initAnimations(TickerProvider vsync) {
    animationsController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: vsync,
    );

    offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animationsController,
      curve: Curves.decelerate,
    ));
  }

  void initUser() {
    try {
      user = User.getCurrentUserInstance();
    } catch (e) {
      user = null;
      logout();
    } finally {
      notifyListeners();
    }
  }

  String? firstNameValidator(String? value) {
    if (User.checkNameFormat(value)) {
      return null;
    } else {
      return 'Veuillez entrer un email valide';
    }
  }

  String? lastNameValidator(String? value) {
    if (User.checkNameFormat(value)) {
      return null;
    } else {
      return 'Veuillez entrer un email valide';
    }
  }

  String? emailValidator(String? value) {
    if (User.checkEmailFormat(value)) {
      return null;
    } else {
      return 'Veuillez entrer un email valide';
    }
  }

  void onEditFirstNameClick() {

    if (user == null) {
      showFastPopup = true;
      fastPopupTitle = "Erreur";
      fastPopupContent = "Vous devez être connecté pour modifier vos informations";
      fastPopupImage = "images/error.png";
      notifyListeners();
      return;
    }

    showPopup = true;

    firstNameController.text = user?.firstName ?? "";

    popupContent = EditFieldFormWidget(
        validator: firstNameValidator,
        controller: firstNameController,
        label: "Prénom",
        validate: () async {
          showPopup = false;
          popupContent = null;

          User tempUser = User(
              user!.id,
              firstNameController.text,
              user!.lastName,
              user!.email,
              user!.tel,
              user!.emailPaypal,
              user!.telWero,
              user!.rib,
              user!.profilPictureRef,
              user!.password
          );

          try {
            await userService.updateUser(tempUser);
            initUser();
          } on NetworkException catch (e) {
            if (e.networkError == NetworkErrorEnum.unauthorized) {
              showFastPopup = true;
              fastPopupTitle = "Erreur";
              fastPopupContent = "Vous devez être connecté pour modifier vos informations";
              fastPopupImage = "images/error.png";
            } else {
              showFastPopup = true;
              fastPopupTitle = "Erreur";
              fastPopupContent = "${e.networkError.message} (${e.networkError.code})";
              fastPopupImage = "images/error.png";
            }
          } catch (e) {
            showFastPopup = true;
            fastPopupTitle = "Erreur";
            fastPopupContent = "Erreur de l'application : ${e.toString()}";
            fastPopupImage = "images/error.png";
          } finally {
            notifyListeners();
          }

          notifyListeners();
        });
    notifyListeners();
  }

  void onEditLastNameClick() {

    if (user == null) {
      showFastPopup = true;
      fastPopupTitle = "Erreur";
      fastPopupContent = "Vous devez être connecté pour modifier vos informations";
      fastPopupImage = "images/error.png";
      notifyListeners();
      return;
    }

    showPopup = true;

    lastNameController.text = user?.lastName ?? "";

    popupContent = EditFieldFormWidget(
        label: "Nom",
        validator: lastNameValidator,
        controller: lastNameController,
        validate: () async {
          showPopup = false;
          popupContent = null;

          User tempUser = User(
              user!.id,
              user!.firstName,
              lastNameController.text,
              user!.email,
              user!.tel,
              user!.emailPaypal,
              user!.telWero,
              user!.rib,
              user!.profilPictureRef,
              user!.password
          );

          try {
            await userService.updateUser(tempUser);
            initUser();
          } on NetworkException catch (e) {
            if (e.networkError == NetworkErrorEnum.unauthorized) {
              showFastPopup = true;
              fastPopupTitle = "Erreur";
              fastPopupContent = "Vous devez être connecté pour modifier vos informations";
              fastPopupImage = "images/error.png";
            } else {
              showFastPopup = true;
              fastPopupTitle = "Erreur";
              fastPopupContent = "${e.networkError.message} (${e.networkError.code})";
              fastPopupImage = "images/error.png";
            }
          } catch (e) {
            showFastPopup = true;
            fastPopupTitle = "Erreur";
            fastPopupContent = "Erreur de l'application : ${e.toString()}";
            fastPopupImage = "images/error.png";
          } finally {
            notifyListeners();
          }
          notifyListeners();
        });
    notifyListeners();
  }

  void onEditEmailClick() {
    showFastPopup = true;
    fastPopupTitle = "Oups";
    fastPopupContent =
    "Vous ne pouvez pas encore modifier votre email";
    fastPopupImage = "images/warning.png";
    notifyListeners();
  }

  void onEditTelClick() {
    showFastPopup = true;
    fastPopupTitle = "Oups";
    fastPopupContent =
    "Vous ne pouvez pas encore modifier votre téléphone";
    fastPopupImage = "images/warning.png";
    notifyListeners();
  }

  void onEditPaypalClick() {
    if (user == null) {
      showFastPopup = true;
      fastPopupTitle = "Erreur";
      fastPopupContent = "Vous devez être connecté pour modifier vos informations";
      fastPopupImage = "images/error.png";
      notifyListeners();
      return;
    }

    showPopup = true;

    paypalController.text = user?.emailPaypal ?? "";

    popupContent = EditFieldFormWidget(
        label: "Paypal",
        validator: emailValidator,
        controller: paypalController,
        validate: () async {
          showPopup = false;
          popupContent = null;

          User tempUser = User(
              user!.id,
              user!.firstName,
              user!.lastName,
              user!.email,
              user!.tel,
              paypalController.text,
              user!.telWero,
              user!.rib,
              user!.profilPictureRef,
              user!.password
          );

          try {
            await userService.updateUser(tempUser);
            initUser();
          } on NetworkException catch (e) {
            if (e.networkError == NetworkErrorEnum.unauthorized) {
              showFastPopup = true;
              fastPopupTitle = "Erreur";
              fastPopupContent = "Vous devez être connecté pour modifier vos informations";
              fastPopupImage = "images/error.png";
            } else {
              showFastPopup = true;
              fastPopupTitle = "Erreur";
              fastPopupContent = "${e.networkError.message} (${e.networkError.code})";
              fastPopupImage = "images/error.png";
            }
          } catch (e) {
            showFastPopup = true;
            fastPopupTitle = "Erreur";
            fastPopupContent = "Erreur de l'application : ${e.toString()}";
            fastPopupImage = "images/error.png";
          } finally {
            notifyListeners();
          }
          notifyListeners();
        });
    notifyListeners();
  }

  void onEditWeroClick() {
    showFastPopup = true;
    fastPopupTitle = "Oups";
    fastPopupContent =
    "Vous ne pouvez pas encore modifier votre téléphone Wero";
    fastPopupImage = "images/warning.png";
    notifyListeners();
  }

  void onEditRibClick() {
    showFastPopup = true;
    fastPopupTitle = "Oups";
    fastPopupContent =
    "Vous ne pouvez pas encore modifier votre RIB";
    fastPopupImage = "images/warning.png";
    notifyListeners();
  }

  void closeFastPopup() {
    showFastPopup = false;
    fastPopupTitle = null;
    fastPopupContent = null;
    fastPopupImage = null;
    notifyListeners();
  }

  void closePopup() {
    showPopup = false;
    popupContent = null;
    notifyListeners();
  }

  Future<void> logout() async {
    HapticFeedback.mediumImpact();
    await TokenUtils.removeToken();
    User.removeCurrentUserInstance();
    Restart.restartApp();
  }

}
