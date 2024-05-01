import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/app_data/firebase_FirestoreMeth.dart';
import 'package:instagram_clone/methods/methods_Util.dart';
import 'package:instagram_clone/models/userModel.dart';
import 'package:instagram_clone/providers/userProvider.dart';
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
  void createPost(String uid, String username, String userImg) async {
    setState(() {
      _isLoading = true;
    });

    try {
      String resp = await FirestoreMethode()
          .addPost(uid, _captionController.text, username, userImg, _file!);

      if (resp == "success") {
        setState(() {
          _isLoading = false;
        });
        if (context.mounted) {
          showSnackBar(context, 'New Post Created!');
        }
        clearImage();
      } else {
        if (context.mounted) {
          showSnackBar(context, resp);
        }
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // ignore: use_build_context_synchronously
      showSnackBar(
        context,
        e.toString(),
      );
    }
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

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
    final String userPhotoUrl = user?.photoUrl ??
        'https://i.pinimg.com/564x/53/d0/0e/53d00e92639824cc33c05ae8c7b1dbc3.jpg';

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
              padding: const EdgeInsets.all(14.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _isLoading
                      ? const LinearProgressIndicator()
                      : const Padding(padding: EdgeInsets.only(top: 0.0)),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: user?.photoUrl != null &&
                              user!.photoUrl!.isNotEmpty
                          ? NetworkImage(user.photoUrl!)
                          : const NetworkImage(
                              'https://i.pinimg.com/564x/53/d0/0e/53d00e92639824cc33c05ae8c7b1dbc3.jpg'),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(user!.username)
                  ]),
                  const SizedBox(height: 20), // Add space between elements
                  AspectRatio(
                    aspectRatio: 400 / 380,
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
                  const SizedBox(height: 16),
                  TextField(
                    controller: _captionController,
                    decoration: const InputDecoration(
                      hintText: 'Write a Caption...',
                      border: InputBorder.none,
                    ),
                    maxLines: 3,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: _toggleLocation,
                        icon: Icon(
                          _locationAdded
                              ? Icons.location_on
                              : Icons.add_location,
                          color: _locationAdded ? Colors.red : Colors.red,
                        ),
                        tooltip:
                            _locationAdded ? 'Location Added' : 'Add Location',
                      ),
                      IconButton(
                        onPressed: _toggleSong,
                        icon: Icon(
                          _songAdded
                              ? Icons.music_note
                              : Icons.music_note_outlined,
                          color: _songAdded
                              ? const Color.fromARGB(255, 127, 3, 243)
                              : const Color.fromARGB(255, 127, 3, 243),
                        ),
                        tooltip: _songAdded ? 'Song Added' : 'Add Song',
                      ),
                      IconButton(
                        onPressed: _toggleTag,
                        icon: Icon(
                          _taggedSomeone ? Icons.person : Icons.person_add,
                          color: _locationAdded ? Colors.blue : Colors.blue,
                        ),
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
                      onPressed: () =>
                          createPost(user.uid, user.username, user.photoUrl!),

                      child: const Text('Post'),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
