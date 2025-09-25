import 'package:flutter/material.dart';
import 'Network.dart';

//Imutable with safe copy todo item
class TodoItem extends ChangeNotifier {
  final String id;
  final Network network;
  bool _done;
  String _text;
  TodoItem(String text, this.id, this.network, {bool done = false})
    : _text = "$text",
      _done = done;
  bool get done => _done;
  set done(bool value) {
    network.updateTodo(id, _text, value).catchError((e, stack) {
      debugPrint('Error in addTodo: $e');
      debugPrintStack(stackTrace: stack);
    });
    _done = value;
    notifyListeners();
  }

  String get text => "$_text";
  set text(String value) {
    network.updateTodo(id, value, _done).catchError((e, stack) {
      debugPrint('Error in addTodo: $e');
      debugPrintStack(stackTrace: stack);
    });
    _text = "$value";
    notifyListeners();
  }
}

enum Filters { all, done, undone }

class TodoItemsState extends ChangeNotifier {
  List<TodoItem> _items = [];
  final Network connection;
  Filters _current_filter = Filters.values.first;

  TodoItemsState({required this.connection}) {
    connection
        .getTodos()
        .then((value) {
          _items = value;
          notifyListeners();
        })
        .catchError((e, stack) {
          debugPrint('Error in addTodo: $e');
          debugPrintStack(stackTrace: stack);
        });
  }

  Filters get current_filter => _current_filter;

  set current_filter(Filters filter) {
    _current_filter = filter;
    notifyListeners();
  }

  int get length => _items.length;

  void add(String text) {
    print("add() called, connection: ${connection}");
    connection
        .addTodo(text)
        .then((value) {
          print("model got items");
          _items = value;
          notifyListeners();
        })
        .catchError((e, stack) {
          debugPrint('Error in addTodo: $e');
          debugPrintStack(stackTrace: stack);
        });
  }

  void remove(TodoItem item) {
    connection
        .deleteTodo(item)
        .then((value) {
          connection.getTodos().then((value) {
            _items = value;
            notifyListeners();
          });
        })
        .catchError((e, stack) {
          debugPrint('Error in deleteTodo: $e');
          debugPrintStack(stackTrace: stack);
        });
  }

  TodoItem getItem(int index) {
    return _items[index];
  }

  TodoItem operator [](int index) => _items[index];

  void operator []=(int index, TodoItem item) {
    connection
        .updateTodo(_items[index].id, item.text, item.done)
        .then((value) {
          connection.getTodos().then((value) {
            _items = value;
            notifyListeners();
          });
        })
        .catchError((e, stack) {
          debugPrint('Error in updateTodo: $e');
          debugPrintStack(stackTrace: stack);
        });
  }
}
