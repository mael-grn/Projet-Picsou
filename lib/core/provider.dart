import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projet_picsou/exceptions/request_exception.dart';
import '../enums/network_error_enum.dart';
import '../utils/token_utils.dart';

class ProviderResponse {
  final int statusCode;
  final Map<String, dynamic> data;

  ProviderResponse(this.statusCode, this.data);
}

class Provider {

  static const String baseUrl = 'http://picsou.zapto.org:8000';
  static const int timeout = 10;

  /// Sends a POST request to the server, without token.
  static Future<Map<String, dynamic>> postUnsecure(String route, Object data) async {
    try {
      final response = await  http.post(
        Uri.parse('$baseUrl$route'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      ).timeout(const Duration(seconds: timeout));
      if (response.statusCode.toString().startsWith('2')) {
        return jsonDecode(response.body);
      } else {
        throw NetworkException(NetworkErrorEnum.fromCode(response.statusCode));
      }
    } on TimeoutException catch (_) {
      throw NetworkException(NetworkErrorEnum.requestTimeout);
    }
  }

  /// Sends a GET request to the server, without token.
  static Future<Map<String, dynamic>> getUnsecure(String route) async {
    try {
      final response = await  http.get(
        Uri.parse('$baseUrl$route'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: timeout));
      if (response.statusCode.toString().startsWith('2')) {
        return jsonDecode(response.body);
      } else {
        throw NetworkException(NetworkErrorEnum.fromCode(response.statusCode));
      }
    } on TimeoutException catch (_) {
      throw NetworkException(NetworkErrorEnum.requestTimeout);
    }
  }

  /// Sends a GET request to the server, with the token in the header.
  /// If the token is not found, throws a TokenException.
  static Future<Map<String, dynamic>> getSecure(String route) async {
    final token = await TokenUtils.loadToken();
    try {
      final response = await  http.get(
        Uri.parse('$baseUrl$route'),
        headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
      ).timeout(const Duration(seconds: timeout));
      if (response.statusCode.toString().startsWith('2')) {
        return jsonDecode(response.body);
      } else {
        throw NetworkException(NetworkErrorEnum.fromCode(response.statusCode));
      }
    } on TimeoutException catch (_) {
      throw NetworkException(NetworkErrorEnum.requestTimeout);
    }
  }

  /// Sends a POST request to the server, with the token in the header.
  /// If the token is not found, throws a TokenException.
  static Future<Map<String, dynamic>> postSecure(String route, Object data) async {
    final token = await TokenUtils.loadToken();
    try {
      final response = await  http.post(
        Uri.parse('$baseUrl$route'),
        headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
        body: jsonEncode(data),
      ).timeout(const Duration(seconds: timeout));
      if (response.statusCode.toString().startsWith('2')) {
        return jsonDecode(response.body);
      } else {
        throw NetworkException(NetworkErrorEnum.fromCode(response.statusCode));
      }
    } on TimeoutException catch (_) {
      throw NetworkException(NetworkErrorEnum.requestTimeout);
    }
  }

  /// Sends a PUT request to the server, with the token in the header.
  /// If the token is not found, throws a TokenException.
  static Future<Map<String, dynamic>> putSecure(String route, Object data) async {
    final token = await TokenUtils.loadToken();
    try {
      final response = await  http.put(
        Uri.parse('$baseUrl$route'),
        headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
        body: jsonEncode(data),
      ).timeout(const Duration(seconds: timeout));
      if (response.statusCode.toString().startsWith('2')) {
        return jsonDecode(response.body);
      } else {
        throw NetworkException(NetworkErrorEnum.fromCode(response.statusCode));
      }
    } on TimeoutException catch (_) {
      throw NetworkException(NetworkErrorEnum.requestTimeout);
    }
  }

  /// Sends a DELETE request to the server, with the token in the header.
  /// If the token is not found, throws a TokenException.
  static Future<Map<String, dynamic>> deleteSecure(String route, Object data) async {
    final token = await TokenUtils.loadToken();
    try {
      final response = await  http.delete(
        Uri.parse('$baseUrl$route'),
        headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
        body: jsonEncode(data),
      ).timeout(const Duration(seconds: timeout));
      if (response.statusCode.toString().startsWith('2')) {
        return jsonDecode(response.body);
      } else {
        throw NetworkException(NetworkErrorEnum.fromCode(response.statusCode));
      }
    } on TimeoutException catch (_) {
      throw NetworkException(NetworkErrorEnum.requestTimeout);
    }
  }
}
