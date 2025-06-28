import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helthy/controllers/request_controller.dart';
import 'package:helthy/extensions/app_extension.dart';
import 'package:helthy/styles/color_styles.dart';
import 'package:helthy/styles/text_styles.dart';
import 'package:helthy/views/request/item_card.dart';
import 'package:helthy/widgets/custom_container_shadow.dart';

class AccesoriesInfoRequest extends GetView<RequestController> {
  const AccesoriesInfoRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      children: [
        Text(
          'Create a new request Instalasi',
          style: Calibri700.copyWith(fontSize: 16),
        ),
        4.ph,
        Text(
          '2 of 4 Completed Accesories Info',
          style: Calibri400.copyWith(fontSize: 16),
        ),
        14.ph,
        CustomContainerShadow(
          onTap: () {
            controller.showAccesory();
          },
          backgroundColor: ColorStyles.atlantis30,
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Create Accesories',
                  style: Calibri700.copyWith(fontSize: 16),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: ColorStyles.genoa,
                ),
                child: Icon(Icons.add_rounded, color: Colors.white, size: 26),
              ),
            ],
          ),
        ),
        14.ph,
        Obx(
          () => Column(
            children: List.generate(controller.accecories.length, (i) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ItemCard(
                  data: controller.accecories[i],
                  onDetail:
                      () => controller.showAccesory(
                        data: controller.accecories[i],
                      ),
                  onDelete:
                      () =>
                          controller.doDeleteItem(controller.accecories[i].id),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
