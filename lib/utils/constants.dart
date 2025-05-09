class CoursePackage {
  final String type;
  final double price;
  final String duration;
  final String schedule;
  final List<String> cars;
  final List<String> learningMethods;

  CoursePackage({
    required this.type,
    required this.price,
    required this.duration,
    required this.schedule,
    required this.cars,
    required this.learningMethods,
  });
}

class Constants {
  static final List<String> cars = [
    'Toyota Avanza',
    'Toyota Agya Manual',
    'Daihatsu Terios',
    'Daihatsu Ayla',
    'Daihatsu Xenia',
  ];

  static final List<String> learningMethods = [
    'Mengenal alat-alat mobil',
    'Belajar maju mundur',
    'Tanjakan',
    'Turunan',
    'Belajar di jalan raya',
    'Di tempat keramaian',
    'Tikungan',
    'Jalan sempit',
    'Parkir',
    'Peraturan berlalu lintas',
  ];

  static final List<CoursePackage> packages = [
    CoursePackage(
      type: 'Regular (SIM A)',
      price: 2300000,
      duration: '15 x 60 menit',
      schedule: '08.00 - 16.00 WIB (Senin - Jumat)',
      cars: cars,
      learningMethods: learningMethods,
    ),
    CoursePackage(
      type: 'Privat (SIM A)',
      price: 2350000,
      duration: '15 x 60 menit',
      schedule: '08.00 - 20.00 WIB (Setiap Hari)',
      cars: cars,
      learningMethods: learningMethods,
    ),
  ];
}
