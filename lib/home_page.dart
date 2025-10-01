import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'TextFieldView.dart';
import 'todo_item.dart';
import 'popup_menu.dart';
import 'model.dart';
import 'package:flutter/services.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    TodoItemsState items = context.watch<TodoItemsState>();

    List<TodoItem> filteredItems =
        List.generate(items.length, (index) => items[index]).where((element) {
          switch (items.current_filter) {
            case Filters.all:
              return true;
            case Filters.done:
              return element.done;
            case Filters.undone:
              return !element.done;
          }
        }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(title, style: Theme.of(context).textTheme.headlineLarge),
             InkWell(
      onTap: () => Clipboard.setData(ClipboardData(text: items.connection.apiKey)),
      child: Text(
        "Copy API key",
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
      ),
    )
          ],
        ),
        actions: [PopupMenu()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          itemCount: filteredItems.length,
          itemBuilder: (context, index) {
            return TodoItemWidget(filteredItems[index], appTitle: title);
          },
          separatorBuilder: (context, index) =>
              const Divider(color: Colors.grey, thickness: 1),
        ),
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddView(title)),
        ),
        tooltip: 'Add a TODO',
        child: const Icon(Icons.add),
      ),
    );
  }
}
