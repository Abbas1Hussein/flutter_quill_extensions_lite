import 'package:flutter/material.dart';

import '../../../utils/table_utils.dart';
import '../../../utils/utils.dart';
import '../../custom/table.dart';

class TableSizeSelect extends StatefulWidget {
  final QuillControllerUtils quillController;

  const TableSizeSelect({
    super.key,
    required this.quillController,
  });

  @override
  State<TableSizeSelect> createState() => _TableSizeSelectState();
}

class _TableSizeSelectState extends State<TableSizeSelect> {
  int currentIndex = 0;
  TableModel? tableSizesModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final cardSize = size.height * 0.1;
    return AlertDialog(
      title: const Text('Select Table Size'),
      content: SizedBox(
        width: size.height * 0.5,
        height: size.height * 0.5,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Adjust the number of columns as needed
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 1.0,
          ),
          itemCount: 2 * 2,
          itemBuilder: (context, position) {
            final index = position + 2;
            return GestureDetector(
              onTap: () {
                tableSizesModel = TableModel(
                  rowNumber: index,
                  columnsNumber: index,
                  data: [],
                );
                setState(() => currentIndex = index);
              },
              child: SizedBox(
                width: cardSize,
                height: cardSize,
                child: Card(
                  color: index == currentIndex ? Colors.green : null,
                  child: Center(
                    child: Text('$index * $index'),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (tableSizesModel != null) {
              widget.quillController.addValue(
                CustomTableEmbeddable(),
                tableSizesModel?.toAttribute(),
              );
              Navigator.of(context).pop();
            }
          },
          child: const Text('Add'),
        ),
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
