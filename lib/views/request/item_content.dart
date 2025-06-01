import 'package:flutter/material.dart';
import 'package:helthy/extensions/app_extension.dart';
import 'package:helthy/styles/text_styles.dart';

class ItemContent extends StatelessWidget {
  const ItemContent({super.key, required this.title, required this.content});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Calibri400.copyWith(fontSize: 9.5)),
        2.ph,
        Text(content, style: Calibri700.copyWith(fontSize: 14)),
      ],
    );
  }
}
