import '../core/provider.dart';
import '../exceptions/request_exception.dart';
import '../models/user.dart';
import '../utils/token_utils.dart';

class AuthService {
  /// Returns the user with the given email and password.
  /// Store the token in the shared preferences.
  Future<User> login(String email, String password) async {
    final response = await Provider().postUnsecure('/auth/login', {
      'email': email,
      'password': password,
    });

    switch (response.statusCode) {
      case 200:
        await TokenUtils.saveToken(response.data['token']);
        return User.fromJson(response.data['user']);
      case 401:
        return throw RequestException(
          response.statusCode,
          'Mauvais mot de passe',
        );
      case 404:
        return throw RequestException(
          response.statusCode,
          'Utilisateur introuvable',
        );
      default:
        return throw RequestException(response.statusCode, 'Erreur serveur');
    }
  }

  /// Create the user in the database for the given user.
  Future<User> register(
    String firstName,
    String lastName,
    String email,
    String password,
    String tel,
    String emailPaypal,
    String telWero,
    String rib,
    String profilPictureRef,
  ) async {
    final response = await Provider().postUnsecure('/auth/register', {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
      'tel': tel,
      'email_paypal': emailPaypal,
      'tel_wero': telWero,
      'rib': rib,
      'profil_pict_ref': profilPictureRef,
    });

    switch (response.statusCode) {
      case 200:
        await TokenUtils.saveToken(response.data['token']);
        return User.fromJson(response.data['new_user']);
      case 401:
        return throw RequestException(
          response.statusCode,
          'Mauvais mot de passe',
        );
      case 409:
        return throw RequestException(
          response.statusCode,
          'Cet utilisateur existe déjà',
        );
      default:
        return throw RequestException(response.statusCode, 'Erreur serveur');
    }
  }

  /// Returns true if the token is valid, false otherwise.
  /// May throw a RequestException.
  Future<User> verifyToken() async {
    final response = await Provider().getSecure('/auth/validate');

    switch (response.statusCode) {
      case 200:
        return User.fromJson(response.data['user']);
      case 401:
        return throw RequestException(response.statusCode, 'Token invalide.');
      case 404:
        return throw RequestException(
          response.statusCode,
          'Utilisateur introuvable.',
        );
      default:
        return throw RequestException(response.statusCode, 'Erreur serveur.');
    }
  }
}
