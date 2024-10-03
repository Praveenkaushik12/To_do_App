import 'package:flutter/material.dart';
import 'package:todo_app/screens/addPage.dart';
import 'package:todo_app/services/todo_services.dart';
import 'package:todo_app/utils/snackbar_helper.dart';
import 'package:todo_app/widget/todo_card.dart';


class Todolist extends StatefulWidget{
  const Todolist({super.key});

  @override
  State<Todolist>createState()=>_ToDoListPageState();
}

class _ToDoListPageState extends State<Todolist>{
  bool isloading=true;
  @override
  void initState(){
    super.initState();
    fetchTodo();

  }

  List items=[];
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title:Text('Todo List'), 
      ),
      body:Visibility( 
        visible: isloading,
        child:Center(child:CircularProgressIndicator()),
        replacement:
        RefreshIndicator(
          onRefresh: fetchTodo,
          child: Visibility(
            visible: items.isNotEmpty,
            replacement: Center(
              child: Text(
                'No Todo Item',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: items.length,
              itemBuilder: (context,index){
                final item=items[index] as Map;
                final id=item['_id'] as String;
                return TodoCard(
                  index: index,
                  deleteById: deleteById,
                  navigateToEditPage: navigateToEditPage, // Corrected this line
                  item: item,
                );

              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: navigateToAddPage,
      label: Text('Add Todo'), ),
    );
  }

  void navigateToEditPage(Map item){
    final route=MaterialPageRoute(
      builder: (context)=>AddTodoPage(todo:item),
    );
    Navigator.push(context,route);
  }

  Future<void> navigateToAddPage() async{
    final route=MaterialPageRoute(
      builder: (context)=>AddTodoPage(),
    );
    await Navigator.push(context,route);
    setState(() {
      isloading=true;
    });
    fetchTodo();
  }

  Future<void> deleteById(String id) async{
    final isSuccess=await TodoServices.deleteById(id);
    if(isSuccess){
      final filtered=items.where((element)=>element['_id']!=id).toList();
      setState((){
        items=filtered;
      });
    }else{
       showErrormsg(context,message:"Error");
    }
  }

  Future<void>fetchTodo() async{
    final response= await TodoServices.fetchTodo();
    if(response!=null){
      setState(() {
        items=response;
      });
    }else{
      showErrormsg(context,message:"Error while fetching!");
    }
    setState(() {
      isloading=false;
    });
  }


}

