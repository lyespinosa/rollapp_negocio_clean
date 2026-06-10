abstract class AppException implements Exception {
  final String message;

  AppException(this.message);
}

class ServerException extends AppException {
  ServerException([super.message = 'Server Error']);
}

class CacheException extends AppException {
  CacheException([super.message = 'Cache Error']);
}

class InvalidCredentialsException extends AppException {
  InvalidCredentialsException([super.message = 'Invalid Credentials']);
}

class JsonParsingException extends AppException {
  JsonParsingException([super.message = 'Error parsing JSON']);
}

class ModelMappingException extends AppException {
  ModelMappingException([super.message = 'Error mapping model']);
}

class NetworkException extends AppException {
  NetworkException([super.message = 'Network Error']);
}
