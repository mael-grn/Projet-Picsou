import 'package:flutter/material.dart';
import 'package:projet_picsou/services/session_service.dart';
import 'package:projet_picsou/services/user_service.dart';
import 'package:projet_picsou/views/error_screen_view.dart';
import '../core/theme/custom_navigator.dart';
import '../enums/network_error_enum.dart';
import '../exceptions/request_exception.dart';
import '../models/user.dart';
import '../views/select_profile_picture_view.dart';
import '../views/splash_screen_view.dart';
import '../widgets/global_layout.dart';

class EntryPointController with ChangeNotifier {
  String? error;
  String? errorImage;
  Widget? page;
  bool isLoading = false;
  UserService userService;
  EntryPointController(this.userService);

  Future<void> recover() async {
    isLoading = true;
    notifyListeners();
    try {
      User user = await userService.getConnectedUser();
      if (user.id < 0 || user.profilPictureRef.isEmpty) {
        await SessionService.closeSession();
        CustomNavigator.pushReplacement(SelectProfilePictureView());
      } else {
        CustomNavigator.pushReplacement(GlobalLayout());
      }
    } on NetworkException catch (e) {
      if (e.networkError == NetworkErrorEnum.notFound || e.networkError == NetworkErrorEnum.unauthorized) {
        CustomNavigator.pushReplacement(SplashScreenView());
      } else {
        rethrow;
      }
    } catch (e) {
      CustomNavigator.pushReplacement(ErrorScreenView());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}