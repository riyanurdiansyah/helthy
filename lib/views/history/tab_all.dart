import 'package:flutter/material.dart';
import 'package:helthy/views/history/tab_card.dart';

class TabAll extends StatelessWidget {
  const TabAll({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(20, (i) {
        return TabCard(ontap: () {});
      }),
    );
  }
}
