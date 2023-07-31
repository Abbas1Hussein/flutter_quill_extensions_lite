import 'package:flutter_quill/flutter_quill.dart';

import 'quill_controller_utils.dart';

class TableUtils {
  final QuillControllerUtils _quillControllerUtils;

  TableUtils(this._quillControllerUtils);

  /// Updates the image attributes of the currently selected image in the [controller].
  void updateTableAttribute({
    required TableModel tableModel,
  }) {
    _quillControllerUtils.controller.document.format(
      _quillControllerUtils.offset,
      1,
      tableModel.toAttribute(),
    );
  }
}

class TableModel {
  final int rowNumber;
  final int columnsNumber;
  final List<List<String>> data;

  TableModel({
    required this.rowNumber,
    required this.columnsNumber,
    required this.data,
  });

  /// Creates an [TableModel] from a JSON map.
  factory TableModel.fromJson(Map<String, dynamic> json) {
    final List<List<String>> table = [];

    for (var element in json['data']) {
      table.add(List.from(element));
    }

    return TableModel(
      rowNumber: json['rowNumber'],
      columnsNumber: json['columnsNumber'],
      data: table.isNotEmpty ? table : [],
    );
  }

  /// Converts the [TableModel] to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'rowNumber': rowNumber,
      'columnsNumber': columnsNumber,
      'data': data
    };
  }

  /// Converts the [TableModel] to a [Attribute] object for formatting in the editor.
  Attribute toAttribute() {
    return Attribute('tableAttribute', AttributeScope.INLINE, toJson());
  }
}
