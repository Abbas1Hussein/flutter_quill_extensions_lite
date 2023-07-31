import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

import '../custom/table.dart';
import '../view/table/table.dart';

/// This class is an implementation of the [EmbedBuilder] interface specific
/// to rendering Table in the Quill editor.
class TableEmbedBuilder extends EmbedBuilder {
  @override
  String get key => CustomTableEmbeddable.tableType;

  @override
  bool get expanded => false;

  @override
  Widget build(
    BuildContext context,
    QuillController controller,
    Embed node,
    bool readOnly,
    bool inline,
    TextStyle textStyle,
  ) {
    return TableView(
      attributes: node.style.attributes,
      controller: controller,
      isReadOnly: readOnly,
    );
  }
}
