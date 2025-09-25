import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:template/model.dart';

class Network {
  final String baseUrl;
  final String apiKey;

  Network({required this.baseUrl, required this.apiKey});

  static Future<Network> registerNetwork(String baseUrl) async {
    final key = await Network.register(baseUrl);
    if (key != null) {
      return Network(baseUrl: baseUrl, apiKey: key);
    }
    throw Exception('API key could not be retrieved');
  }

  // Register and get API key
  static Future<String?> register(String baseUrl) async {
    final response = await http.get(Uri.parse('$baseUrl/register'));
    if (response.statusCode == 200) {
      // Assuming API key is returned as plain text or JSON string
      return response.body;
    }
    return null;
  }

  // Get all todos
  Future<List<TodoItem>> getTodos() async {
    final response = await http.get(Uri.parse('$baseUrl/todos?key=$apiKey'));
    if (response.statusCode == 200) {
      final List<dynamic> todos = jsonDecode(response.body);
      return todos.map<TodoItem>((element) {
        return TodoItem(element["title"], element["id"], this, done: element["done"] == "true");
      }).toList();
    }
    throw Exception('Failed to load todos');
  }

  // Add a new todo
  Future<List<TodoItem>> addTodo(
    String text) async {
    final response = await http.post(
      Uri.parse('$baseUrl/todos?key=$apiKey'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'title': text, 'done': true}),
    );
    if (response.statusCode == 200) {
      final List<dynamic> todos = jsonDecode(response.body);
      return todos.map<TodoItem>((element) {
        return TodoItem(element["title"], element["id"], this, done: element["done"] == "true");
      }).toList();
    }
    throw Exception('Failed to add todo');
  }

  // Update a todo
  Future<void> updateTodo(String oldId, String newtext, bool newDone
  ) async {
    final response = await http.put(
      Uri.parse('$baseUrl/todos/$oldId?key=$apiKey'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'title': newtext, 'done': newDone.toString()}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update todo');
    }
    
  }

  // Delete a todo
  Future<void> deleteTodo(TodoItem todo) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/todos/${todo.id}?key=$apiKey'),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete todo');
    }
    
  }
}

class NetworkConnectionState extends ChangeNotifier {
  Network? _network;
  Network? get connection => _network;

  set connection(Network? network) {
    _network = network;
    notifyListeners();
  }

  Future<void> initialize(String baseUrl) async {
    _network = await Network.registerNetwork(baseUrl);
    notifyListeners();
  }
}
