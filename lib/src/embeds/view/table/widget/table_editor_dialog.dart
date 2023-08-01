import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_quill_extensions_lite/flutter_quill_extensions_lite.dart';
import 'package:flutter_quill_extensions_lite/src/embeds/custom/table.dart';

import 'alphabet_letters_table_row.dart';
import 'editor_table_rows.dart';
import 'numbers_table_row.dart';

class TableAddEditValue extends StatefulWidget {
  final TableModel tableModel;
  final QuillController controller;

  const TableAddEditValue({
    Key? key,
    required this.tableModel,
    required this.controller,
  }) : super(key: key);

  @override
  TableAddEditValueState createState() => TableAddEditValueState();
}

class TableAddEditValueState extends State<TableAddEditValue> {
  late TableModel tableModel;

  late List<List<TextEditingController>> _table;

  final List<bool> tableLockStatus = [false];

  @override
  void initState() {
    super.initState();
    loadTable();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return AlertDialog(
      content: SizedBox(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: {0: FlexColumnWidth((size.height / size.width) / 6)},
            border: TableBorder.all(),
            children: [
              AlphabetLettersTableRow(rowNumber: tableModel.rowNumber),
              ...EditorTableRows(
                table: _table,
                tableLockStatus: tableLockStatus,
                tableModel: tableModel,
                addRow: _addRow,
                deleteRow: (index) => _removeRow(index),
                toggleLockRow: (index) => _toggleLockRow(index),
              ).buildEditorTableRows(),
              NumbersTableRow(rowNumber: tableModel.rowNumber),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: onTap, child: const Text('Add')),
        TextButton(
            onPressed: Navigator.of(context).pop, child: const Text('Cancel')),
      ],
    );
  }

  void onTap() {
    _saveData();
    Navigator.of(context).pop();
  }

  /// Adds a new row to the table.
  void _addRow() {
    setState(() {
      _table.add(
        List.generate(
          tableModel.rowNumber,
          (index) => TextEditingController(),
        ),
      );
      while (tableModel.data.length < _table.length) {
        tableModel.data.add(
          List.generate(tableModel.rowNumber, (index) => ''),
        );
      }
      tableLockStatus.add(false);
    });
  }

  /// Removes a row from the table.
  void _removeRow(int index) {
    if (index == 0) {
      widget.controller.moveCursorToPosition(widget.controller.utils.offset);
      widget.controller.utils.removeValue();
    }

    setState(() {
      _table.removeAt(index);
      tableLockStatus.removeAt(index);
    });
  }

  /// Toggles the lock status of a row.
  void _toggleLockRow(int index) {
    setState(() => tableLockStatus[index] = !tableLockStatus[index]);
  }

  /// Saves the changes made to the table data.
  void _saveData() {
    final List<List<String>> tableData = [];

    while (tableData.length < _table.length) {
      tableData.add(
        List.generate(tableModel.rowNumber, (index) => ''),
      );
    }

    for (var i = 0; i < _table.length; i++) {
      for (var j = 0; j < _table[i].length; j++) {
        tableData[i][j] =
            _table[i][j].text; // Updates the table data with the new changes
      }
    }

    try {
      if (tableModel.data.isNotEmpty) {
        widget.controller.utils.updateAttribute(
          TableModel(
            rowNumber: tableModel.rowNumber,
            columnsNumber: _table.length,
            data: tableData,
          ).toAttribute(),
        );
      } else {
        widget.controller.utils.addValue(
          CustomTableEmbeddable(),
          TableModel(
            rowNumber: tableModel.rowNumber,
            columnsNumber: _table.length,
            data: tableData,
          ).toAttribute(),
        );
      }
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('you must selected position to insert table'),
        ),
      );
    }
  }

  /// Loads the table data from attributes.
  void loadTable() {
    final tableModel = widget.tableModel;
    _table = [
      for (var i = 0; i < tableModel.columnsNumber; i++)
        List.generate(
          tableModel.rowNumber,
          (index) {
            tableLockStatus.add(false);
            return TextEditingController(
              text:
                  tableModel.data.isNotEmpty ? tableModel.data[i][index] : null,
            );
          },
        ),
    ];
    this.tableModel = tableModel;
  }
}
