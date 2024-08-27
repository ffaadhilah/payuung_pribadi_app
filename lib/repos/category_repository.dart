import 'package:payuung_pribadi_app/models/category_model.dart';

class CategoryRepository {
  List<Category> getCategories() {
    return [
      Category(name: 'Hobi', iconPath: 'assets/hobi.png'),
      Category(name: 'Merchandise', iconPath: 'assets/logo_image.png'),
      Category(name: 'Gaya Hidup Sehat', iconPath: 'assets/logo_image.png'),
      Category(name: 'Konseling & Rohani', iconPath: 'assets/logo_image.png'),
      Category(name: 'Self Development', iconPath: 'assets/logo_image.png'),
      Category(
          name: 'Perencanaan Keuangan',
          iconPath: 'assets/perencanaan_keuangan.svg'),
      Category(name: 'Konsultasi Medis', iconPath: 'assets/logo_image.png'),
      Category(name: 'Lihat Semua', iconPath: 'assets/logo_image.png'),
    ];
  }
}
