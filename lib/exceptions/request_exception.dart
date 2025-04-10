class RequestException implements Exception {
  final int networkErrorCode;
  final String message;

  RequestException(this.networkErrorCode, this.message);
}