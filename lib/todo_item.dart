import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model.dart';
import 'add_view.dart';

class TodoItemWidget extends StatelessWidget {
  final TodoItem item;
  final String appTitle;
  const TodoItemWidget(this.item, {required this.appTitle, super.key});

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
              mainAxisAlignment: MainAxisAlignment.start,
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
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        child: Text(item.text, style: textStyle),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EditView(appTitle, item: item),
                            ),
                          );
                        },
                      ),
                  
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          context.read<TodoItemsState>().remove(item);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
