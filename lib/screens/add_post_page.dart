import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/models/userModel.dart';
import 'package:instagram_clone/providres/userProvider.dart';
import 'package:provider/provider.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({Key? key}) : super(key: key);

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  Uint8List? _file;
  bool _isLoading = false;
  bool _locationAdded = false;
  bool _songAdded = false;
  bool _taggedSomeone = false;
  final TextEditingController _captionController = TextEditingController();

// Function to add a post
  void addPost() {}
// Function to toggle location added
  void _toggleLocation() {
    setState(
      () {
        _locationAdded = !_locationAdded;
      },
    );
  }

// Function to toggle song added
  void _toggleSong() {
    setState(() {
      _songAdded = !_songAdded;
    });
  }

// Function to toggle tagging someone
  void _toggleTag() {
    setState(() {
      _taggedSomeone = !_taggedSomeone;
    });
  }

// Function to show Options when select Image
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
                  try {
                    final image = await ImagePicker().pickImage(
                      source: ImageSource.camera,
                    );
                    if (image != null) {
                      setState(() {
                        _file = File(image.path).readAsBytesSync();
                      });
                    }
                  } catch (e) {
                    // Handle the error, e.g., show an error message
                    print('Failed to open camera: $e');
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

  void dispose() {
    super.dispose();
    _captionController.dispose;
  }

  @override
  Widget build(BuildContext context) {
    final UserModel? user = Provider.of<UserProvider>(context).fetchUser;

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
              padding: const EdgeInsets.all(
                  14.0), // Add padding to the entire scroll view
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment:
                    MainAxisAlignment.start, // Adjust alignment as needed
                crossAxisAlignment: CrossAxisAlignment
                    .stretch, // Stretch widgets across the screen width
                children: [
                  const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://images.unsplash.com/photo-1713283547186-ef7fadbd4ee6?q=80&w=1922&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Abir.ch')
                      ]),
                  const SizedBox(height: 20), // Add space between elements
                  AspectRatio(
                    aspectRatio: 450 / 450,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: MemoryImage(_file!),
                          fit: BoxFit.fill,
                          alignment: FractionalOffset.topCenter,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal:
                            16.0), // Add horizontal padding to the text field
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Write a Caption...', // Placeholder text
                        border: InputBorder.none, // No border
                      ),
                      maxLines: 3, // Up to 10 lines
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: _toggleLocation,
                        icon: Icon(_locationAdded
                            ? Icons.location_on
                            : Icons.add_location),
                        tooltip:
                            _locationAdded ? 'Location Added' : 'Add Location',
                      ),
                      IconButton(
                        onPressed: _toggleSong,
                        icon: Icon(_songAdded
                            ? Icons.music_note
                            : Icons.add_circle_outline),
                        tooltip: _songAdded ? 'Song Added' : 'Add Song',
                      ),
                      IconButton(
                        onPressed: _toggleTag,
                        icon: Icon(
                            _taggedSomeone ? Icons.person : Icons.person_add),
                        tooltip:
                            _taggedSomeone ? 'Tagged Someone' : 'Tag Someone',
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0), // Add vertical padding to the button
                    child:
                        // Modify the post method to include additional features based on user selection
                        ElevatedButton(
                      // Post method logic
                      // Include additional features based on _locationAdded, _songAdded, _taggedSomeone flags
                      onPressed: addPost,

                      child: Text('Post'),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
