import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_view.dart';
import 'todo_item.dart';
import 'popup_menu.dart';
import 'model.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key, required this.title});
  final String title;

  

  @override
  Widget build(BuildContext context) {
    TodoItemsState items = context.watch<TodoItemsState>();
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        actions: [
          PopupMenu()
    ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return TodoItemWidget(items[index]); 
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
