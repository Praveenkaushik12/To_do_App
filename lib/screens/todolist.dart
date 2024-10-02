import 'package:flutter/material.dart';
import 'package:todo_app/screens/addPage.dart';

class Todolist extends StatefulWidget{
  const Todolist({super.key});

  @override
  State<Todolist>createState()=>_ToDoListPageState();
}

class _ToDoListPageState extends State<Todolist>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title:Text('Todo List'),
        
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: navigateToAddPage,
      label: Text('Add Todo'), ),
    );
  }

  void navigateToAddPage(){
    final route=MaterialPageRoute(
      builder: (context)=>AddTodoPage(),
    );
    Navigator.push(context,route);
  }
}

