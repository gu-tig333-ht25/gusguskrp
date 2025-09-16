//Imutable with safe copy todo item
class TodoItem{
  final bool _done;
  final String _text;
  TodoItem(String text, {bool done = false}): this._text = "$text", _done = done;
  bool get done => _done;
  String get text => "$_text";
}

class TodoItemsState{
  final List<TodoItem> items = const [];
  int get length => items.length;

  void add(TodoItem item){
    items.add(item);
  }
  void remove(int index){
    items.remove(index);
  }

  TodoItem get_item(int index){
    return items[index];
  }

}