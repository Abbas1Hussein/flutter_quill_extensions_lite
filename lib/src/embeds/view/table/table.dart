import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

import '../../../utils/utils.dart';
import 'widget/table_editor_dialog.dart';

const kEdgeInsets8 = EdgeInsets.all(8.0);

class TableView extends StatelessWidget {
  final bool readOnly;
  final TableBuilder? tableBuilder;
  final QuillController controller;
  final Map<String, Attribute<dynamic>> attributes;

  const TableView({
    super.key,
    required this.attributes,
    required this.tableBuilder,
    required this.controller,
    required this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    if (tableBuilder != null) {
      return tableBuilder!(
        attributesUtils,
        tableModel.data,
        () => _showTableAddEditValueDialog(context),
        readOnly,
      );
    } else {
      return Card(
        shape: const RoundedRectangleBorder(),
        color: attributesUtils.backgroundColor,
        child: GestureDetector(
          onLongPress: () => _showTableAddEditValueDialog(context),
          child: Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            border: TableBorder.all(
              color: attributesUtils.color ?? Colors.grey,
              width: attributesUtils.isBold ? 3.0 : 1.0,
            ),
            children: buildDataTableRows,
          ),
        ),
      );
    }
  }

  void _showTableAddEditValueDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => TableAddEditValue(tableModel: tableModel, controller: controller),
    ).then((value) {
      controller.moveCursorToPosition(controller.utils.offset);
    });
  }

  TableModel get tableModel {
    return TableModel.fromJson(attributes['tableAttribute']!.value);
  }

  List<TableRow> get buildDataTableRows {
    return tableModel.data.asMap().entries.map(
      (entry) {
        final rowData = entry.value;

        return TableRow(
          children: [
            ...rowData.map(
              (value) {
                return Padding(
                  padding: kEdgeInsets8,
                  child: Text(
                    value,
                    style: TextStyle(
                      fontWeight: attributesUtils.isBold ? FontWeight.bold : null,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ).toList(),
          ],
        );
      },
    ).toList();
  }

  AttributesUtils get attributesUtils => AttributesUtils(attributes);
}
