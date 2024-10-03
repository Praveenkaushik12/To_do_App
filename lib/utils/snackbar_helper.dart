import 'package:flutter/material.dart';

void showSuccessmsg(BuildContext context,{
  required String message
  }){
  final snackBar=SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showErrormsg(BuildContext context,{
  required String message
  }){
      final snackBar=SnackBar(
        content: Text(message,style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.red,);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
}