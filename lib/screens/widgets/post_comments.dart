import 'package:flutter/material.dart';

class CommentsScreen extends StatefulWidget {
  final List<dynamic> comments;

  const CommentsScreen({Key? key, required this.comments}) : super(key: key);

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          // AppBar
          Container(
            color: Colors.grey[200],
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  'Comments',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 40),
              ],
            ),
          ),
          // Comments list
          Expanded(
            child: ListView.builder(
              itemCount: widget.comments.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                      // You can customize the avatar here
                      ),
                  title: Text(widget.comments[index]['username']),
                  subtitle: Text(widget.comments[index]['comment']),
                );
              },
            ),
          ),
          // Comment input field
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Add a comment...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // Add comment logic here
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
