class BaseUrl {
  static const String baseUrl = 'http://192.168.192.110:8000';
}

class Api {
  static const String api = '/api';
}

class ApiEndpoint {
  static const String login = '${BaseUrl.baseUrl}${Api.api}/login';
  static const String logout = '${BaseUrl.baseUrl}${Api.api}/logout';
  static const String register = '${BaseUrl.baseUrl}${Api.api}/register';

  static const String shopProducts = '${BaseUrl.baseUrl}${Api.api}/paket';
}
