import 'package:flutter/material.dart';
import 'add_view.dart';
import 'todo_item.dart';
import 'popup_menu.dart';
import 'model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> items = List.generate(20, (index) => "Item nr $index");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
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
            return TodoItemWidget(TodoItem(items[index], done: index % 2 == 0));  //Temporary done value to show the two states
          },
          separatorBuilder: (context, index) =>
              const Divider(color: Colors.grey, thickness: 1),
        ),
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddView(widget.title)),
        ),
        tooltip: 'Add a TODO',
        child: const Icon(Icons.add),
      ),
    );
  }
}
