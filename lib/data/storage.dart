import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageData {
  // Creates an instance of FirebaseStorage to interact with the Firebase Storage service.
  final FirebaseStorage _storage = FirebaseStorage.instance;
  // Creates an instance of FirebaseAuth to interact with the Firebase Authentication service.
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Method to upload an image to Firebase Storage.
  Future<String> uploadImage(
      String
          childName, // The name of the storage directory (folder) where the image will be stored.
      Uint8List file,
      bool isPost // A boolean flag indicating whether the image is a post
      ) async {
    // Creates a reference to the path where the image will be stored.
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);
    // Starts the upload task with the provided image file.
    UploadTask uploadTask = ref.putData(file);

    // Waits for the upload task to complete and stores the snapshot of the task.
    TaskSnapshot snap = await uploadTask;
    // Retrieves the download URL of the uploaded image from the snapshot.
    String downloadUrl = await snap.ref.getDownloadURL();
    // Returns the download URL of the image.
    return downloadUrl;
  }
}
