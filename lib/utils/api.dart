class BaseUrl {
  static const String baseUrl = 'http://192.168.88.8:8000';
}

class Api {
  static const String api = '/api';
}

class ApiEndpoint {
  static const String login = '${BaseUrl.baseUrl}${Api.api}/login';
  static const String logout = '${BaseUrl.baseUrl}${Api.api}/logout';
  static const String register = '${BaseUrl.baseUrl}${Api.api}/register';

// Siswa
  static const String shopProducts = '${BaseUrl.baseUrl}${Api.api}/paket';
  static const String orderProduct = '${BaseUrl.baseUrl}${Api.api}/pesanan';
  static const String orderDataKeranjang =
      '${BaseUrl.baseUrl}${Api.api}/siswa/lihat-pesanan';
  static const String uploadBuktiPembayaran =
      '${BaseUrl.baseUrl}${Api.api}/pesanan/{id}/bukti';
  static const String addJadwal =
      '${BaseUrl.baseUrl}${Api.api}/siswa/add-jadwal/{id}';

// Instruktur
  static const String userStatus =
      '${BaseUrl.baseUrl}${Api.api}/instruktur/all-user';
}
