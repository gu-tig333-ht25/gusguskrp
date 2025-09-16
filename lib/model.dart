import 'package:flutter/material.dart';
//Imutable with safe copy todo item
class TodoItem{
  final bool _done;
  final String _text;
  // ignore: unnecessary_string_interpolations
  TodoItem(String text, {bool done = false}): _text = "$text", _done = done;
  bool get done => _done;
  // ignore: unnecessary_string_interpolations
  String get text => "$_text";
}

class TodoItemsState extends ChangeNotifier{
  final List<TodoItem> _items = [];
  int get length => _items.length;

  void add(TodoItem item){
    _items.add(item);
    notifyListeners();
  } 

  void remove(TodoItem item){
    _items.remove(item);
    notifyListeners();
  }

  void removeAt(int index){
    _items.removeAt(index);
    notifyListeners();
  }

  TodoItem getItem(int index){
    return _items[index];
  }

  TodoItem operator [](int index) => _items[index];
}

