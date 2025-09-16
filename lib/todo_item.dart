import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model.dart';

class TodoItemWidget extends StatelessWidget {
  final TodoItem item;
  const TodoItemWidget(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: item,
      child: Consumer<TodoItem>(
        builder: (_, item, __) {
          Icon completedIcon = item.done
              ? const Icon(Icons.check_box_outlined)
              : const Icon(Icons.check_box_outline_blank);
          TextStyle? textStyle = Theme.of(context).textTheme.headlineMedium
              ?.copyWith(
                decoration: item.done
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              );
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                    icon: completedIcon,
                    onPressed: () {
                      item.done = !item.done;
                    },
                  ),
                ),
                Expanded(child: Text(item.text, style: textStyle)),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    context.read<TodoItemsState>().remove(item);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
