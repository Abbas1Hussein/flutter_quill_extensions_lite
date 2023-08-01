import 'package:flutter_quill/flutter_quill.dart';

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
      'data': data,
    };
  }

  /// Converts the [TableModel] to a [Attribute] object for formatting in the editor.
  Attribute toAttribute() {
    return Attribute('tableAttribute', AttributeScope.INLINE, toJson());
  }
}
