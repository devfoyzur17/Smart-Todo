import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TodoController extends GetxController {
  var isLoading = false.obs;
  var todoList = [];

  @override
  onInit() {
    fatchTodo();
    super.onInit();
  }

  Future<void> fatchTodo() async {
    isLoading(true);
    final url = "https://api.nstack.in/v1/todos?page=1&limit=10";
    final uri = Uri.parse(url);
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map;
        final result = json["items"] as List;
        todoList = result;
        print(todoList.length);
      }
    } catch (error) {
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteTodoById(String id) async {
    final url = "https://api.nstack.in/v1/todos/$id";
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    if (response.statusCode == 200) {
      todoList.removeWhere((element) => element["_id"]==id);
    } else {}
  }
}
