import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_quill_extensions_lite/flutter_quill_extensions_lite.dart';

import '../../../utils/table_utils.dart';


const kMargin = EdgeInsets.all(8.0);

class TableView extends StatefulWidget {
  final Map<String, Attribute<dynamic>> attributes;
  final bool isReadOnly;
  final QuillController controller;

  const TableView({
    Key? key,
    required this.attributes,
    required this.controller,
    required this.isReadOnly,
  }) : super(key: key);

  @override
  TableViewState createState() => TableViewState();
}

class TableViewState extends State<TableView> {
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
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    return Card(
      shape: const RoundedRectangleBorder(),
      color: toolbarUtils.backgroundColor,
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: const {0: FlexColumnWidth(0.1)},
        border:
            TableBorder.all(color: toolbarUtils.color ?? theme.primaryColor),
        children: [
          if (!widget.isReadOnly) _buildAlphabetLettersTableRow(),
          ..._buildEditorTableRows(),
          if (!widget.isReadOnly) buildNumbersTableRow(),
        ],
      ),
    );
  }

  TableRow _buildAlphabetLettersTableRow() {
    return TableRow(
      children: List.generate(
        tableModel.rowNumber + 2,
        (index) {
          if (index == 0) return const SizedBox();
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              index <= tableModel.rowNumber
                  ? String.fromCharCode(65 + index - 1)
                  : "options",
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          );
        },
      ),
    );
  }

  List<TableRow> _buildEditorTableRows() {
    return _table.asMap().entries.map(
      (entry) {
        final index = entry.key;
        final rowData = entry.value;
        final isRowLocked = tableLockStatus[index];

        return TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  (index + 1).toString(), // Generate numbers 1, 2, 3, ...
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ...rowData.map(
              (controller) {
                final j = rowData.indexOf(controller);
                final data =
                    tableModel.data.isNotEmpty ? tableModel.data[index][j] : '';
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Builder(
                    builder: (context) {
                      if (widget.isReadOnly) {
                        return Text(data.isNotEmpty ? data : '');
                      } else {
                        if (tableModel.data.isNotEmpty &&
                            controller.text.isEmpty) {
                          controller.text = data;
                        }
                        return TextField(
                          controller: controller,
                          enabled: !isRowLocked,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          mouseCursor: SystemMouseCursors.click,
                        );
                      }
                    },
                  ),
                );
              },
            ).toList(),
            if (!widget.isReadOnly)
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                        child: _buildButton(
                            () => _removeRow(index), Icons.remove)),
                    Flexible(
                      child: _buildButton(
                        () => _toggleLockRow(index),
                        isRowLocked ? Icons.lock_open : Icons.lock,
                      ),
                    ),
                    Flexible(child: _buildButton(_addRow, Icons.add)),
                  ],
                ),
              ),
          ],
        );
      },
    ).toList();
  }

  TableRow buildNumbersTableRow() {
    return TableRow(
      children: List.generate(
        tableModel.rowNumber + 2,
        (index) {
          return Builder(
            builder: (context) {
              if (index == 0) return const SizedBox();
              if (index <= tableModel.rowNumber) {
                return Text(
                  (index).toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                );
              } else {
                return TextButton(
                  onPressed: _saveData,
                  child: const Text('save'),
                );
              }
            },
          );
        },
      ),
    );
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

    widget.controller.moveCursorToPosition(widget.controller.utils.offset);
    widget.controller.utils.tableUtils.updateTableAttribute(
      tableModel: TableModel(
        rowNumber: tableModel.rowNumber,
        columnsNumber: _table.length,
        data: tableData,
      ),
    );
  }

  /// Loads the table data from attributes.
  void loadTable() {
    if (widget.attributes.isNotEmpty) {
      final tableModel = TableModel.fromJson(
        widget.attributes['tableAttribute']!.value,
      );
      _table = [
        for (var i = 0; i < tableModel.columnsNumber; i++)
          List.generate(
            tableModel.rowNumber,
            (index) {
              tableLockStatus.add(false);
              return TextEditingController();
            },
          ),
      ];
      this.tableModel = tableModel;
    }
  }

  Widget _buildButton(VoidCallback onPressed, IconData? icon) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: IconButton.outlined(onPressed: onPressed, icon: Icon(icon)),
    );
  }

  ToolbarUtils get toolbarUtils => ToolbarUtils(widget.attributes);
}
