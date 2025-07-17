class BaseUrl {
  // static const String baseUrl =
  // 'https://1be-mobile.virtualtouralamayangpku.my.id';
  static const String baseUrl =
      'https://1be-mobile.virtualtouralamayangpku.my.id';

  static const String storage = '$baseUrl/storage/';
}

class Api {
  static const String api = '/api';
}

class ApiEndpoint {
  // Auth
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
  static const String ubahJadwal =
      '${BaseUrl.baseUrl}${Api.api}/instruktur/update-jadwal-status/{id}';

  // Kasir
  static const String allPesanan = '${BaseUrl.baseUrl}${Api.api}/pesanan';
  static const String detailPesanan =
      '${BaseUrl.baseUrl}${Api.api}/pesanan/{id}';
  static const String updatePesanan =
      '${BaseUrl.baseUrl}${Api.api}/pesanan/{id}';

  // paket kasir
  static const String allPaket = '${BaseUrl.baseUrl}${Api.api}/paket';
  static const String detailPaket = '${BaseUrl.baseUrl}${Api.api}/paket/{id}';
  static const String createPaket = '${BaseUrl.baseUrl}${Api.api}/paket';
  static const String editPaket = '${BaseUrl.baseUrl}${Api.api}/paket/{id}';
  static const String deletePaket = '${BaseUrl.baseUrl}${Api.api}/paket/{id}';

  // user setting
  static const String allUsers = '${BaseUrl.baseUrl}${Api.api}/users';
  static const String addUser = '${BaseUrl.baseUrl}${Api.api}/users';
  static const String deleteUser = '${BaseUrl.baseUrl}${Api.api}/users/{id}';

  // kasir jadwal
  static const String allJadwalKasir =
      '${BaseUrl.baseUrl}${Api.api}/jadwal-siswa';
  static const String changeStatusJadwalKasir =
      '${BaseUrl.baseUrl}${Api.api}/jadwal-siswa/{id}/status';

  // owner
  static const String dataOwner = '${BaseUrl.baseUrl}${Api.api}/owner/data';
}
