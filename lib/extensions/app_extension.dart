import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

extension PaddingExtension on num {
  SizedBox get ph => SizedBox(height: toDouble());
  SizedBox get pw => SizedBox(width: toDouble());
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

String generateUuidV4() {
  final Random random = Random.secure();
  final List<int> bytes = List<int>.generate(16, (_) => random.nextInt(256));

  // Set UUID version (0100 = version 4)
  bytes[6] = (bytes[6] & 0x0F) | 0x40;

  // Set UUID variant (10xx)
  bytes[8] = (bytes[8] & 0x3F) | 0x80;

  String byteToHex(int byte) => byte.toRadixString(16).padLeft(2, '0');

  final segments = [
    bytes.sublist(0, 4).map(byteToHex).join(),
    bytes.sublist(4, 6).map(byteToHex).join(),
    bytes.sublist(6, 8).map(byteToHex).join(),
    bytes.sublist(8, 10).map(byteToHex).join(),
    bytes.sublist(10, 16).map(byteToHex).join(),
  ];

  return segments.join('-');
}
