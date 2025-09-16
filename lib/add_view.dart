import 'package:flutter/material.dart';
import 'model.dart';
import 'package:provider/provider.dart';

class AddView extends StatelessWidget {
  final String title;

  AddView(this.title, {super.key});
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "What are you going to do?",
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final String text = controller.text.trim();
              if (text.isEmpty) return;
              controller.clear();
              context.read<TodoItemsState>().add(TodoItem(text));
            },
            child: Text(
              "+ Add",
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
