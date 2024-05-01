import 'package:flutter/material.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final Function onDeleteConfirmed;

  const DeleteConfirmationDialog({Key? key, required this.onDeleteConfirmed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Delete Post"),
      content: Text("Are you sure you want to delete this post?"),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            onDeleteConfirmed();
            Navigator.of(context).pop();
          },
          child: Text("Delete"),
        ),
      ],
    );
  }
}

class DeleteSuccessDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Success"),
      content: Text("Post deleted successfully!"),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("OK"),
        ),
      ],
    );
  }
}
