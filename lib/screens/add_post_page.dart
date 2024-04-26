import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/variablesUtil.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({Key? key}) : super(key: key);

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  Uint8List? _file;
  bool isLoading = false;

  void _showImageOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Take a photo from camera'),
                onTap: () async {
                  Navigator.pop(context);
                  final image = await ImagePicker().pickImage(
                    source: ImageSource.camera,
                  );
                  if (image != null) {
                    setState(() {
                      _file = File(image.path).readAsBytesSync();
                    });
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Select image from gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  try {
                    final image = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                    );
                    if (image != null) {
                      final bytes = await File(image.path).readAsBytes();
                      setState(() {
                        _file = bytes;
                      });
                    }
                  } catch (e) {
                    // Handle the error, e.g., show an error message
                    print('Failed to pick image: $e');
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.cancel),
                title: const Text('Cancel'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _file == null
        ? Center(
            child: ElevatedButton(
              onPressed: () {
                _showImageOptions(context);
              },
              child: const Text('Create a Post'),
            ),
          )
        : Scaffold(
            body: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1713283547186-ef7fadbd4ee6?q=80&w=1922&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width *
                          0.4, // 40% of screen width
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: 'Write a Caption...', // Placeholder text
                          border: InputBorder.none, // No border
                        ),
                        maxLines: 10, // Up to 10 lines
                      ),
                    ),
                    SizedBox(
                      height: 45,
                      width: 45,
                      child: AspectRatio(
                        aspectRatio: 487 / 451,
                        child: Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                            image: NetworkImage(
                                'https://images.unsplash.com/photo-1713283547186-ef7fadbd4ee6?q=80&w=1922&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                            fit: BoxFit.fill,
                            alignment: FractionalOffset.topCenter,
                          )),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ));
  }
}
