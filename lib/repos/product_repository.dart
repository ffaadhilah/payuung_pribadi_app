import 'package:payuung_pribadi_app/models/product_model.dart';

class ProductRepository {
  List<Product> getProducts() {
    return [
      Product(name: 'Urun', iconPath: 'assets/logo_image.png', isNew: true),
      Product(name: 'Porsi Haji', iconPath: 'assets/logo_image.png'),
      Product(
          name: 'Financial Check Up',
          iconPath: 'assets/financial_check_up.svg'),
      Product(name: 'Asuransi Mobil', iconPath: 'assets/logo_image.png'),
      Product(name: 'Asuransi Properti', iconPath: 'assets/logo_image.png'),
    ];
  }
}
