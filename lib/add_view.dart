import 'package:flutter/material.dart';
import 'model.dart';
import 'package:provider/provider.dart';

class TextFieldView extends StatelessWidget {
  final String title;
  final String textFieldtext;
  final String labelText;
  final String buttonText;
  final void Function(String text) onSubmitt;
  TextFieldView(
    this.title, {
    required this.labelText,
    required this.buttonText,
    required this.onSubmitt,
    super.key,
    this.textFieldtext = "",
  }) : controller = TextEditingController(text: textFieldtext);
  final TextEditingController controller;

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
                labelText: labelText,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final String text = controller.text.trim();
              if (text.isEmpty) return;
              controller.clear();
              onSubmitt(text);
            },
            child: Text(
              buttonText,
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

class AddView extends StatelessWidget {
  final String title;
  const AddView(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextFieldView(
      title,
      labelText: "What are you going to do?",
      buttonText: "+ Add",
      onSubmitt: (text) {
        context.read<TodoItemsState>().add(TodoItem(text));
      },
    );
  }
}

class EditView extends StatelessWidget {
  final String title;
  final TodoItem item;
  const EditView(this.title, {super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return TextFieldView(title, textFieldtext: item.text, labelText: "Change ToDo", buttonText: "Edit", onSubmitt: (text) {
          item.text = text;
          Navigator.pop(context);
      },);
  }
}
