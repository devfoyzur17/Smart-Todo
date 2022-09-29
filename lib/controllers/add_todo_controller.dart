import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:smart_todo/utils/helper_function.dart';

class AddTodoController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> saveData() async {
    if (formKey.currentState!.validate()) {
      final title = titleController.text;
      final description = descriptionController.text;
      final body = {
        "title": title,
        "description": description,
        "is_completed": false
      };
      final url = "https://api.nstack.in/v1/todos";
      final uri = Uri.parse(url);
      final response = await http.post(uri,
          body: jsonEncode(body),
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 201) {
        HelperFunction.showSuccessMessage("Todo save successfully");
        resetField();
      } else {
        HelperFunction.showErrorMessage("Todo not saved");
      }
    }
  }

  void resetField() {
    titleController.text = "";
    descriptionController.text = "";
  }

  Future<void> updateData(Map todo) async {
    final id = todo["_id"];
    if (formKey.currentState!.validate()) {
      final title = titleController.text;
      final description = descriptionController.text;
      final body = {
        "title": title,
        "description": description,
        "is_completed": false,
      };
      final url = "https://api.nstack.in/v1/todos/$id";
      final uri = Uri.parse(url);
      final response = await http.put(uri,
          body: jsonEncode(body),
          headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        HelperFunction.showSuccessMessage("Update successfully");
        resetField();
      } else {
        HelperFunction.showErrorMessage("Update failed");
      }
    }
  }
}
