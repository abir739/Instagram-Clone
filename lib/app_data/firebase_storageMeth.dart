import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageDataMeth {
  // Creates an instance of FirebaseStorage to interact with the Firebase Storage service.
  final FirebaseStorage _storage = FirebaseStorage.instance;
  // Creates an instance of FirebaseAuth to interact with the Firebase Authentication service.
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Method to upload an image to Firebase Storage.
  // Method to upload an image to Firebase Storage.
  Future<String> addImageToStorage(
    String childName,
    Uint8List file,
    bool isPost,
  ) async {
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);

    if (isPost) {
      String id = Uuid().v1();
      ref = ref.child(id);
    }

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
