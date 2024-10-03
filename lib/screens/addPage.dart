import 'package:flutter/material.dart';
import 'package:todo_app/services/todo_services.dart';
import 'package:todo_app/utils/snackbar_helper.dart';

class AddTodoPage extends StatefulWidget {
  final Map? todo;
  const AddTodoPage({
    super.key,
    this.todo,
  });

  @override
  State<AddTodoPage> createState() => _AddTodopageState();
}

class _AddTodopageState extends State<AddTodoPage> {
  TextEditingController titleController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();
  bool isEdit=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final todo=widget.todo;
    if(todo!=null){
      isEdit=true;
      final title=todo['title'];
      final description=todo['description'];
      titleController.text=title;
      descriptionController.text=description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(isEdit ? 'Edit Todo':'Add Todo'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(hintText: 'Title'),
          ),
          SizedBox(height: 20),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(hintText: 'Description'),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: isEdit ? updateData : submitData,
            child: Text(isEdit ? 'Update' : 'Submit'),
          )

        ],
      ),
      );
    }

    Future<void> updateData() async{
      final todo=widget.todo;
      if(todo==null){
        print('You can not call update data without todo data'); 
        return ;
      }
      final id=todo['_id'];
      final isUpdated=await TodoServices.updateTodo(id, body);
  
      if (isUpdated) {
          showSuccessmsg(context,message:'Updated Successfully!');
      } else {
          showErrormsg(context,message:'Failed to update');
      }
    }

    Future<void> submitData() async{
      //submit data to the server
      
      final isAdded=await TodoServices.addTodo(body);
     
      //show success or fail message based on status
      if(isAdded){
        titleController.text='';
        descriptionController.text='';
        showSuccessmsg(context,message:'Added Successfully!');
      }else{
        showErrormsg(context,message:'Error');
      }
    }
    
    //getter method
    Map get body {
      final title=titleController.text;
      final description=descriptionController.text;
      return {
        "title": title,
        "description": description,
        "is_completed": false
      };
    }
 
  }

