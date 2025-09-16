import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model.dart';
import 'home_page.dart';

void main() {
  TodoItemsState state = TodoItemsState();

  for (var element in List.generate(20, (index) => "Item nr $index")) {
    state.add(TodoItem(element));
  }

  runApp(ChangeNotifierProvider(create: (_) => state, child: MyApp()));
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
      home: MyHomePage(title: 'TIG333 TODO'),
    );
  }
}
