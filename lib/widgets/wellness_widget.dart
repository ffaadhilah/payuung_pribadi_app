import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payuung_pribadi_app/models/wellness_model.dart';

class WellnessWidget extends StatelessWidget {
  final Wellness wellness;

  WellnessWidget({required this.wellness});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          SvgPicture.asset(wellness.iconPath, height: 60, width: 60),
          SizedBox(height: 8),
          Text(
            wellness.name,
            style: TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
          Text(
            wellness.price,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
