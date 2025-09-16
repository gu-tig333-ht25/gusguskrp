import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model.dart';

class PopupMenu extends StatelessWidget {
  const PopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Filters>(
        
        onSelected: (value)  {
          context.read<TodoItemsState>().current_filter = value;
        },

        itemBuilder: (context) =>
          Filters.values.map((element) {
            return PopupMenuItem(value: element, child: Text(element.name));
          },).toList()
         
      );
  }
}