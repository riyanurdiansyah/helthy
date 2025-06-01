import 'package:flutter/material.dart';
import 'package:helthy/controllers/request_controller.dart';
import 'package:helthy/styles/color_styles.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class ItemSectionRequestBuilder extends StatelessWidget {
  final RequestController controller;
  final int step;
  final Map<String, dynamic> itemSection;
  final int index;
  const ItemSectionRequestBuilder({
    super.key,
    required this.controller,
    required this.step,
    required this.itemSection,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return AutoScrollTag(
      key: ValueKey(index),
      controller: controller.autoScrollController,
      index: index,
      child: Container(
        width: MediaQuery.of(context).size.width * .5,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          // step == itemSection['id']
          //     ? Colors.white
          //     : ColorStyles.disableLight,
          border: Border(
            bottom: BorderSide(
              color:
                  step == itemSection['id']
                      ? ColorStyles.primary
                      : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Row(
          children: [
            SizedBox(width: 10),
            Container(
              alignment: Alignment.center,
              child: Container(
                // padding: EdgeInsets.all(5),
                width: 20,
                height: 20,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color:
                      step == itemSection['id']
                          ? ColorStyles.atlantis100
                          : ColorStyles.disableBold,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  itemSection['id'].toString(),
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                itemSection['step'],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color:
                      step == itemSection['id']
                          ? Colors.black
                          : ColorStyles.disableBold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
