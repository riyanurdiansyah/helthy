import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helthy/controllers/request_controller.dart';
import 'package:helthy/extensions/app_extension.dart';
import 'package:helthy/styles/color_styles.dart';
import 'package:helthy/styles/text_styles.dart';
import 'package:helthy/views/request/item_training_card.dart';
import 'package:helthy/widgets/custom_container_shadow.dart';

class ItemTrainingRequest extends GetView<RequestController> {
  const ItemTrainingRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      children: [
        Text(
          'Create a new request Training',
          style: Calibri700.copyWith(fontSize: 16),
        ),
        4.ph,
        Text(
          '2 of 2 Completed Item Info',
          style: Calibri400.copyWith(fontSize: 16),
        ),
        14.ph,
        CustomContainerShadow(
          onTap: () {
            controller.showItem(nameColumn3: "Keterangan");
          },
          backgroundColor: ColorStyles.atlantis30,
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Create Item',
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
            children: List.generate(controller.items.length, (i) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ItemTrainingCard(
                  data: controller.items[i],
                  onDetail:
                      () => controller.showItem(
                        data: controller.items[i],
                        nameColumn3: "Keterangan",
                      ),
                  onDelete:
                      () => controller.doDeleteItem(controller.items[i].id),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
