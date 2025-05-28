import 'package:flutter/material.dart';
import 'package:projet_picsou/services/session_service.dart';
import 'package:projet_picsou/services/user_service.dart';
import 'package:projet_picsou/views/error_screen_view.dart';
import '../core/custom_navigator.dart';
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
        CustomNavigator.pushReplacementFromBottom(SelectProfilePictureView());
      } else {
        CustomNavigator.pushReplacementFromBottom(GlobalLayout());
      }
    } on NetworkException catch (e) {
      if (e.networkError == NetworkErrorEnum.notFound || e.networkError == NetworkErrorEnum.unauthorized) {
        CustomNavigator.pushReplacementFromBottom(SplashScreenView());
      } else {
        rethrow;
      }
    } catch (e) {
      CustomNavigator.pushReplacementFromBottom(ErrorScreenView());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}