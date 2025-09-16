import 'package:flutter/material.dart';

//Imutable with safe copy todo item
class TodoItem extends ChangeNotifier{
  bool _done;
  String _text;
  TodoItem(String text, {bool done = false}) : _text = "$text", _done = done;
  bool get done => _done;
  set done(bool value){
    _done = value;
    notifyListeners();
  }
  String get text => "$_text";
  set text(String value){
    _text = "$value";
    notifyListeners();
  }
}

class TodoItemsState extends ChangeNotifier {
  final List<TodoItem> _items = [];
  int get length => _items.length;

  void add(TodoItem item) {
    _items.add(item);
    notifyListeners();
  }

  void remove(TodoItem item) {
    _items.remove(item);
    notifyListeners();
  }

  void removeAt(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  TodoItem getItem(int index) {
    return _items[index];
  }

  TodoItem operator [](int index) => _items[index];

  void operator []=(int index, TodoItem item) {
    _items[index] = item;
  }
}
