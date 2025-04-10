import 'dart:convert';

import 'package:http/http.dart' as http;

import '../utils/token_utils.dart';

class ProviderResponse {
  final int statusCode;
  final Map<String, dynamic> data;

  ProviderResponse(this.statusCode, this.data);
}

class Provider {
  static const String baseUrl = 'http://picsou.zapto.org:8000';

  /// Sends a POST request to the server, without token.
  Future<ProviderResponse> postUnsecure(String route, Object data) async {
    final response = await  http.post(
      Uri.parse('$baseUrl$route'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    return ProviderResponse(response.statusCode, jsonDecode(response.body));
  }

  /// Sends a GET request to the server, without token.
  Future<ProviderResponse> getUnsecure(String route) async {
    final response = await  http.get(
      Uri.parse('$baseUrl$route'),
      headers: {'Content-Type': 'application/json'},
    );

    return ProviderResponse(response.statusCode, jsonDecode(response.body));
  }

  /// Sends a GET request to the server, with the token in the header.
  /// If the token is not found, throws a TokenException.
  Future<ProviderResponse> getSecure(String route) async {
    final token = await TokenUtils.loadToken();

    final response = await  http.get(
      Uri.parse('$baseUrl$route'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
    );

    return ProviderResponse(response.statusCode, jsonDecode(response.body));
  }
}
