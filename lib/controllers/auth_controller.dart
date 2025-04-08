import 'package:flutter/material.dart';
import 'package:projet_picsou/exceptions/request_exception.dart';
import '../exceptions/token_exception.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class AuthController with ChangeNotifier {
  final AuthService authService;
  User? user;
  bool isLoading = false;
  String? error;

  AuthController({required this.authService});

  Future<void> login(String email, String password) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      user = await authService.login(email, password);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();

    }
  }

  Future<void> loadUser() async {

    isLoading = true;
    notifyListeners();

    try {
      user = await authService.verifyToken();
    } on TokenException catch (_) {
      // cas ou il n'y a pas de token
      error = null;
      user = null;
    } on RequestException catch (e) {
      error = e.message;
    } finally {
      isLoading = false;
      notifyListeners();

    }
  }
}
