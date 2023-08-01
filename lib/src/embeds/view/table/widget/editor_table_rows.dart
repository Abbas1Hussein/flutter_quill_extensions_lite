import 'package:flutter/material.dart';

import '../../../../utils/table_utils.dart';
import 'text.dart';

class EditorTableRows {
  final TableModel _tableModel;

  final List<List<TextEditingController>> _table;
  final List<bool> _tableLockStatus;

  final VoidCallback _addRow;
  final ValueChanged<int>? _deleteRow;
  final ValueChanged<int>? _toggleLockRow;

  const EditorTableRows({
    required List<List<TextEditingController>> table,
    required TableModel tableModel,
    required List<bool> tableLockStatus,
    required VoidCallback addRow,
    required ValueChanged<int> toggleLockRow,
    required ValueChanged<int> deleteRow,
  })  : _addRow = addRow,
        _toggleLockRow = toggleLockRow,
        _deleteRow = deleteRow,
        _tableLockStatus = tableLockStatus,
        _table = table,
        _tableModel = tableModel;

  List<TableRow> buildEditorTableRows() {
    return _table.asMap().entries.map(
      (entry) {
        final index = entry.key;
        final rowData = entry.value;
        final isRowLocked = _tableLockStatus[index];

        return TableRow(
          children: [
            TextTable(('${index + 1}')),
            ...rowData.map(
              (controller) {
                final j = rowData.indexOf(controller);
                final data = _tableModel.data.isNotEmpty
                    ? _tableModel.data[index][j]
                    : '';
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Builder(builder: (context) {
                    if (_tableModel.data.isNotEmpty &&
                        controller.text.isEmpty) {
                      controller.text = data;
                    }
                    return TextField(
                      controller: controller,
                      enabled: !isRowLocked,
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      decoration: const InputDecoration(
                          border: InputBorder.none, filled: true),
                      mouseCursor: SystemMouseCursors.click,
                    );
                  }),
                );
              },
            ).toList(),
            _buildButtonsOption(index, isRowLocked),
          ],
        );
      },
    ).toList();
  }

  Widget _buildButtonsOption(int index, bool isRowLocked) {
    return FittedBox(
      fit: _tableModel.rowNumber <= 2 ? BoxFit.scaleDown : BoxFit.contain,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButton(() => _deleteRow?.call(index), Icons.remove),
          _buildButton(
            () => _toggleLockRow?.call(index),
            isRowLocked ? Icons.lock_open : Icons.lock,
          ),
          _buildButton(_addRow, Icons.add),
        ],
      ),
    );
  }

  Widget _buildButton(VoidCallback? onPressed, IconData? icon) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: IconButton.outlined(
        onPressed: onPressed,
        icon: Icon(icon),
      ),
    );
  }
}
