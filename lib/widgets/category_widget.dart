import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payuung_pribadi_app/models/category_model.dart';

class CategoryWidget extends StatelessWidget {
  final Category category;

  CategoryWidget({required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(category.iconPath, height: 40, width: 40),
        SizedBox(height: 4),
        Text(
          category.name,
          style: TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
