

import 'package:get/get.dart';
import 'package:smart_todo/views/add_todo_page.dart';
import 'package:smart_todo/views/home_page.dart';

class Routes{

  static const String homePage = "/homePage";
  static const String addTodoPage = "/addTodoPage";

  static var pageList=[
    GetPage(name: homePage, page:()=> HomePage()),
    GetPage(name: addTodoPage, page:()=> AddTodoPage()),
  ];


}