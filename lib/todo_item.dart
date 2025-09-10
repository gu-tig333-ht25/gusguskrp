import 'package:flutter/material.dart';

class TodoItem extends StatefulWidget {
  final String text;
  final bool done;
  const TodoItem({super.key, required this.text, this.done = false});

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  @override
  Widget build(BuildContext context) {
    Icon completedIcon = widget.done
        ? const Icon(Icons.check_box_outlined)
        : const Icon(Icons.check_box_outline_blank);
    TextStyle? textStyle = Theme.of(context).textTheme.headlineMedium?.copyWith(
      decoration: widget.done
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
          Expanded(child: Text(widget.text, style: textStyle)),
          Icon(Icons.close),
        ],
      ),
    );
  }
}
