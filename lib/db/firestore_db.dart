import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebookclone/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreDB {
  static CollectionReference postReference =
      FirebaseFirestore.instance.collection("posts");
  static CollectionReference commentsReference =
      FirebaseFirestore.instance.collection("comments");
  static CollectionReference userReference =
      FirebaseFirestore.instance.collection("users");
  static CollectionReference chatReference =
      FirebaseFirestore.instance.collection("chats");

  static Future<bool> addUserProfile(
      {required Map<String, dynamic> data, required String uid}) async {
    User? user = FirebaseAuth.instance.currentUser;

    try {
      DocumentReference currentUserReference = userReference.doc(data["uid"]);
      await currentUserReference.set(data);
      return true;
    } on Exception catch (e) {
      return false;
    }
  }

  //data={"title":"dasdsa","body":"dasda"};
  static addNewPost(Map<String, dynamic> data) async {
    User? user = FirebaseAuth.instance.currentUser;
    String uid = "";
    if (user != null) {
      uid = user.uid;
    }
    DocumentSnapshot userData = await userReference.doc(uid).get();
    // print("snapshot :" + userData.data().toString());
    UserModel users =
        // UserModel.fromDocumentSnapshot(documentSnapshot: userData.data());
        UserModel.fromJson(userData.data() as Map<String, dynamic>);
    // print("users :" + users.toString());
    data["uid"] = uid;
    data['userImage'] = users.imageUrl;
    data['userName'] = users.firstName;
    data["dateTime"] = DateTime.now().toString();
    //data={"text":"dasdsa","imageUrl":"dasda","uid":"qwrdqwwqwqdeqwfdewfew"};
    postReference.add(data);
  }

  //data={"postId":"dasdsa","text":"usr typed text"};
  static addNewCommentToPost(Map<String, dynamic> data) async {
    User? user = FirebaseAuth.instance.currentUser;
    String uid = "";
    if (user != null) {
      uid = user.uid;
    }

    data["uid"] = uid;
    //data={"postId":"dasdsa","text":"usr typed text",uid":"qwrdqwwqwqdeqwfdewfew"};
    postReference.add(data);
  }
}
