import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/app_data/firebase_storageMeth.dart';
import 'package:instagram_clone/models/postModel.dart';

import 'package:uuid/uuid.dart';

class FirestoreMethode {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> addPost(
    String uid,
    String caption,
    String username,
    String userImg,
    Uint8List file,
  ) async {
    String response = "error occurred";

    try {
      String postUrl =
          await StorageDataMeth().addImageToStorage('posts', file, true);

      String postId = const Uuid().v1();
      PostModel post = PostModel(
        caption: caption,
        postId: postId,
        uid: uid,
        postUrl: postUrl,
        location: '',
        songUrl: '',
        postedDate: DateTime.now(),
        likes: [],
        comments: [],
        userImg: userImg,
        isShared: false,
        username: username,
      );

      await _firestore.collection('posts').doc(postId).set(post.toJson());
      response = "success";
    } catch (e) {
      response = e.toString();
    }
    return response;
  }
}
