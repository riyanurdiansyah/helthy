import 'package:flutter/material.dart';
import 'package:helthy/extensions/app_extension.dart';
import 'package:helthy/styles/color_styles.dart';
import 'package:helthy/styles/text_styles.dart';

class TabCard extends StatelessWidget {
  const TabCard({super.key, this.ontap});

  final Function()? ontap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.amber.shade200,
                    ),
                    child: Text(
                      'History',
                      textAlign: TextAlign.center,
                      style: Calibri700.copyWith(
                        fontSize: 12.5,
                        color: ColorStyles.disable,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0.0),
                    child: Text(
                      'Wed, 6 Dec 2025',
                      textAlign: TextAlign.center,
                      style: Calibri700.copyWith(
                        fontSize: 12.5,
                        color: ColorStyles.disable,
                      ),
                    ),
                  ),
                ],
              ),
              8.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Wed, 6 Dec 2025',
                        textAlign: TextAlign.center,
                        style: Calibri700.copyWith(
                          fontSize: 16.5,
                          color: ColorStyles.black,
                        ),
                      ),

                      Text(
                        'Permintaan Instalasi',
                        textAlign: TextAlign.center,
                        style: Calibri700.copyWith(
                          fontSize: 16.5,
                          color: ColorStyles.atlantis100,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.shade300,
                    ),
                    child: Icon(Icons.arrow_forward_ios_rounded, size: 16),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
