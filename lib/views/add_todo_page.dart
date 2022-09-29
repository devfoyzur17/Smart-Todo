import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_todo/controllers/add_todo_controller.dart';

class AddTodoPage extends StatefulWidget {
  AddTodoPage({Key? key}) : super(key: key);

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final addTodoController = Get.put(AddTodoController());
  bool isEdit = false;
  final Map? todo = Get.arguments;

  @override
  void initState() {
    super.initState();
    if (todo != null) {
      isEdit = true;
      final title = todo!["title"];
      final description = todo!["description"];
      addTodoController.titleController.text = title;
      addTodoController.descriptionController.text = description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(isEdit ? "Edit Todo" : "Add Todo"),
      ),
      body: Form(
          key: addTodoController.formKey,
          child: ListView(
            padding: EdgeInsets.all(15),
            children: [
              TextFormField(
                controller: addTodoController.titleController,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey, width: 0.6)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey, width: 1)),
                    filled: true,
                    fillColor: const Color(0xffe6e6e6).withOpacity(0.1),
                    contentPadding: const EdgeInsets.only(left: 10),
                    focusColor: Colors.white,
                    hintText: "Enter the title",
                    hintStyle: TextStyle(
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.normal),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field must not be empty';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                maxLines: 6,
                minLines: 4,
                controller: addTodoController.descriptionController,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey, width: 0.6)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey, width: 1)),
                    filled: true,
                    fillColor: const Color(0xffe6e6e6).withOpacity(0.1),
                    contentPadding: const EdgeInsets.all(10),
                    focusColor: Colors.white,
                    hintText: "Enter the description",
                    hintStyle: TextStyle(
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.normal),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field must not be empty';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 25,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.deepOrange.shade800,
                      onPrimary: Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () {
                    isEdit
                        ? addTodoController.updateData(todo!)
                        : addTodoController.saveData();
                  },
                  child: Text(
                    isEdit ? "Update" : "Save",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ))
            ],
          )),
    );
  }
}
