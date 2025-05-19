import 'package:flutter/material.dart';

class DeleteConfirmationDialog {
  static Future<bool?> show(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Note'),
        content: Text('Are you sure you want to delete this note?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancel'),
          ),
          TextButton(onPressed:()=> Navigator.of(context).pop(true), 
          child: Text('Delete',style: TextStyle(color: Colors.red),)),
        ],
      ),
    );
  }
}
