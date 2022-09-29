import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_todo/controllers/todo_controller.dart';
import 'package:smart_todo/widgets/show_loading.dart';

import '../routes/routes.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final fatchTodoController = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        title: Text("Todo List"),
      ),

      body: Obx(
        () => fatchTodoController.isLoading.value
            ? Center(
                child: ShowLoading(),
              )
            : RefreshIndicator(
                onRefresh: fatchTodoController.fatchTodo,
                child: Visibility(
                  visible: fatchTodoController.todoList.isNotEmpty,
                  replacement: Center(
                    child: Text("No todo item found"),
                  ),
                  child: ListView.builder(
                    itemCount: fatchTodoController.todoList.length,
                    itemBuilder: (context, index) {
                      final item = fatchTodoController.todoList[index];
                      final id = item["_id"] as String;
                      return Container(
                        decoration: BoxDecoration(border: Border.all()),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 25,
                            child: Text("${index + 1}"),
                          ),
                          title: Text("${item["title"]}"),
                          subtitle: Text("${item["description"]}"),
                          trailing: PopupMenuButton(
                            onSelected: (value) {
                              if (value == "edit") {
                                navigateToEditPage(item);
                              } else if (value == "delete") {
                                fatchTodoController
                                    .deleteTodoById(id)
                                    .then((value) {
                                  setState(() {});
                                });
                              }
                            },
                            itemBuilder: (BuildContext context) => [
                              PopupMenuItem(child: Text("Edit"), value: "edit"),
                              PopupMenuItem(
                                child: Text("Delete"),
                                value: "delete",
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
      ),

      //todo this is floatting action button section

      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToAddPage,
        label: Text(
          "+ Add Task",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepOrange.shade800,
      ),
    );
  }

  Future<void> navigateToAddPage() async {
    await Get.toNamed(Routes.addTodoPage);
    setState(() {
      fatchTodoController.fatchTodo();
    });
  }

  Future<void> navigateToEditPage(Map item) async {
    await Get.toNamed(Routes.addTodoPage, arguments: item);
    setState(() {
      fatchTodoController.fatchTodo();
    });
  }
}
