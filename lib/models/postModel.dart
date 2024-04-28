import 'package:cloud_firestore/cloud_firestore.dart';


class PostModel {
  String? caption;
  String? uid;
  String? username;
  String? postId;
  String? postUrl;
  String? userImg;
  String? location;
  String? songUrl;
  DateTime? postedDate;
  List? likes;
  List? comments;
  bool? isShared;

  PostModel({
    required this.caption,
    required this.postId,
    required this.uid,
    required this.username,
    required this.postUrl,
    required this.userImg,
    required this.location,
    required this.songUrl,
    required this.postedDate,
    required this.likes,
    required this.comments,
    required this.isShared,
  });

  static PostModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return PostModel(
        caption: snapshot["caption"],
        postId: snapshot["postId"],
        uid: snapshot["uid"],
        username: snapshot["username"],
        postUrl: snapshot["postUrl"],
        userImg: snapshot["userImg"],
        location: snapshot["location"],
        songUrl: snapshot["songUrl"],
        postedDate: snapshot["postedDate"],
        likes: List.from(snapshot['likes'] ?? []),
        comments: List.from(snapshot['comments'] ?? []),
        isShared: snapshot["isShared"]);
  }

  Map<String, dynamic> toJson() => {
        "caption": caption,
        "postId": postId,
        "uid": uid,
        "username": username,
        "postUrl": postUrl,
        "userImg": userImg,
        "location": location,
        "songUrl": songUrl,
        "postedDate": postedDate,
        "likes": likes,
        "comments": comments,
        "isShared": isShared
      };
}
