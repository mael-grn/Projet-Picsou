import '../enums/network_error_enum.dart';

class NetworkException implements Exception {
  final NetworkErrorEnum networkError;
  final String? message;
  NetworkException(this.networkError, [this.message]);
}