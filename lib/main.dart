import 'package:flutter/material.dart';
import 'add_view.dart';
import 'todo_item.dart';
import 'popup_menu.dart';
import 'model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO APP',
      theme: ThemeData(
        // Base colors
        scaffoldBackgroundColor: Colors.white, // background of pages
        primaryColor: Colors.grey, // general primary color
        colorScheme: const ColorScheme.light(
          primary: Colors.grey, // AppBar and primary elements
          onPrimary: Colors.white70, // text/icons on primary elements
          secondary: Colors.black, // accents, buttons
        ),

        // AppBar theme
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.grey, // gray banner
          foregroundColor: Colors.black, // black title & icons
          centerTitle: true,
        ),

        // FloatingActionButton theme
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.grey, // black FAB
          foregroundColor: Colors.white,
          iconSize: 50,
          shape: CircleBorder(),
        ),
      ),
      home: const MyHomePage(title: 'TIG333 TODO'),
    );
  }
}

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
