class BaseUrl {
  static const String baseUrl = 'http://192.168.88.10:8000';
}

class Api {
  static const String api = '/api';
}

class ApiEndpoint {
  static const String login = '${BaseUrl.baseUrl}${Api.api}/login';
  static const String logout = '${BaseUrl.baseUrl}${Api.api}/logout';
  static const String register = '${BaseUrl.baseUrl}${Api.api}/register';

  static const String shopProducts = '${BaseUrl.baseUrl}${Api.api}/paket';
  static const String orderProduct = '${BaseUrl.baseUrl}${Api.api}/pesanan';
  static const String orderData = '${BaseUrl.baseUrl}${Api.api}/siswa/lihat-pesanan';
}
