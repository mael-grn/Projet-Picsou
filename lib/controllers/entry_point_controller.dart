import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:projet_picsou/exceptions/token_exception.dart';
import '../enums/network_error_enum.dart';
import '../exceptions/request_exception.dart';
import '../models/user.dart';
import '../services/auth_service.dart';
import '../views/splash_screen_view.dart';
import '../widgets/global_layout.dart';

class EntryPointController with ChangeNotifier {
  String? error;
  String? errorImage;
  Widget? page;
  bool isLoading = false;
  AuthService authService;

  EntryPointController(this.authService);

  Future<void> checkToken() async {
    isLoading = true;
    notifyListeners();
    try {
      User user = await authService.validateToken();
      User.setCurrentUserInstance(user);
      page = GlobalLayout();
    } on NetworkException catch (e) {
      User.removeCurrentUserInstance();
      if (e.networkError == NetworkErrorEnum.notFound || e.networkError == NetworkErrorEnum.unauthorized) {
        page = SplashScreenView();
      } else {
        errorImage = "images/wondering.png";
        error = "Une erreur serveur est survenue. Merci de vérifier si l'application est à jour. Nous faisons tout notre possible pour résoudre le problème. (${e.networkError.code} - ${e.networkError.message})";
      }
    } on ClientException catch (_) {
      errorImage = "images/broken_server.png";
      error = "Tien, nous n'avons pas pu nous connecter au serveur. Merci de vérifier si l'application est à jour.";
    } catch (e) {
      errorImage = "images/broken_phone.png";
      error = "Une erreur est survenue dans l'application. Verifiez les mises a jour et réessayez. ($e)";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}