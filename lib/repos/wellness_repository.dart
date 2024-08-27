import 'package:payuung_pribadi_app/models/wellness_model.dart';

class WellnessRepository {
  List<Wellness> getWellnessItems() {
    return [
      Wellness(
          name: 'Indomaret',
          iconPath: 'assets/logo_imag.png',
          price: 'Rp 25.000'),
      Wellness(
          name: 'Grab', iconPath: 'assets/logo_imag.png', price: 'Rp 20.000'),
    ];
  }
}
