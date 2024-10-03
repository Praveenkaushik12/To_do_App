import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  final int index;
  final Map item;
  final Function(Map) navigateToEditPage; // Required function for editing
  final Function(String) deleteById; // Required function for deleting

  const TodoCard({
    super.key,
    required this.index,
    required this.item,
    required this.navigateToEditPage, // Add this line
    required this.deleteById, // Add this line
  });

  @override
  Widget build(BuildContext context) {
    final id = item['_id'] as String;
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Text('${index + 1}')),
        title: Text(item['title']),
        subtitle: Text(item['description']),
        trailing: PopupMenuButton(
          onSelected: (value) {
            if (value == 'edit') {
              navigateToEditPage(item); // Call edit function
            } else if (value == 'delete') {
              deleteById(id); // Call delete function
            }
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                child: Text('Edit'),
                value: 'edit',
              ),
              PopupMenuItem(
                child: Text('Delete'),
                value: 'delete',
              ),
            ];
          },
        ),
      ),
    );
  }
}
