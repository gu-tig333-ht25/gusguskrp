import 'package:flutter/material.dart';

class AddView extends StatelessWidget {
  final String title;
  AddView(this.title, {super.key});

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
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "What are you going to do?",
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
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
