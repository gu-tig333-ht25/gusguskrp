import 'package:flutter/material.dart';
import 'model.dart';

class TodoItemWidget extends StatefulWidget {
  final TodoItem item;
  const TodoItemWidget(this.item, {super.key});

  @override
  State<TodoItemWidget> createState() => _TodoItemWidgetState();
}

class _TodoItemWidgetState extends State<TodoItemWidget> {
  @override
  Widget build(BuildContext context) {
    Icon completedIcon = widget.item.done
        ? const Icon(Icons.check_box_outlined)
        : const Icon(Icons.check_box_outline_blank);
    TextStyle? textStyle = Theme.of(context).textTheme.headlineMedium?.copyWith(
      decoration: widget.item.done
          ? TextDecoration.lineThrough
          : TextDecoration.none,
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: completedIcon,
          ),
          Expanded(child: Text(widget.item.text, style: textStyle)),
          Icon(Icons.close),
        ],
      ),
    );
  }
}
