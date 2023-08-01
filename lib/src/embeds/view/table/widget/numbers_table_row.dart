import 'package:flutter/material.dart';

import 'text.dart';

class NumbersTableRow extends TableRow {
  final int rowNumber;

  const NumbersTableRow({
    required this.rowNumber,
  });

  @override
  List<Widget> get children => List.generate(
        rowNumber + 2,
        (index) {
          return Builder(
            builder: (context) {
              if (index == 0 || (index > rowNumber)) {
                return const SizedBox();
              } else {
                return TextTable('$index');
              }
            },
          );
        },
      );
}
