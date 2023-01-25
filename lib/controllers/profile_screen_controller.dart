import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebookclone/auth/firebase_auth.dart';
import 'package:facebookclone/db/firestore_db.dart';
import 'package:facebookclone/models/post_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreenController extends GetxController {
  User? user = FirebaseAuth.instance.currentUser;

  late Future<List<PostModel>> postList;

  Future<List<PostModel>> getAllPostOfUser() async {
    List<PostModel> userPostsList = [];
    await FirestoreDB.postReference
        .where("uid", isEqualTo: user!.uid)
        .get()
        .then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        Map<String, dynamic> docdata = doc.data() as Map<String, dynamic>;
        userPostsList.add(PostModel.fromJson(docdata, doc.id));
      }
    }).catchError((error, stackTrace) {
      print(error);
    });
    return userPostsList;
  }

  CroppedFile? imageFile1;
  CroppedFile? imageFile2;
  pickUserProfileImage(BuildContext context) async {
    try {
      final ImagePicker _picker = ImagePicker();
      // Pick an image
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        // imageFile2 = File(image.path);
        imageFile2 = await ImageCropper().cropImage(
          sourcePath: image.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          uiSettings: [
            AndroidUiSettings(
                toolbarTitle: 'Profile Photo',
                toolbarColor: Colors.deepOrange,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.square,
                lockAspectRatio: false),
            IOSUiSettings(
              title: 'Profile Photo',
            ),
            WebUiSettings(
              context: context,
            ),
          ],
        );
      }
    } catch (err) {
      print(err);
    }
  }

  pickUserCoverImage(BuildContext context) async {
    try {
      final ImagePicker _picker = ImagePicker();
      // Pick an image
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        // imageFile1 = File(image.path);
        imageFile1 = await ImageCropper().cropImage(
          sourcePath: image.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          uiSettings: [
            AndroidUiSettings(
                toolbarTitle: 'Cover Photo',
                toolbarColor: Colors.deepOrange,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.ratio16x9,
                lockAspectRatio: false),
            IOSUiSettings(
              title: 'Cover Photo',
            ),
            WebUiSettings(
              context: context,
            ),
          ],
        );
        uploadCoverImageToFirebaseStorage();
      }
    } catch (err) {
      print(err);
    }
  }

  uploadCoverImageToFirebaseStorage() async {
    try {
      String uniqueName = DateTime.now().microsecondsSinceEpoch.toString();
      firebase_storage.UploadTask? uploadTask;
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child("images/CoverImages")
          .child('/' + uniqueName);
      uploadTask = ref.putFile(File(imageFile1!.path));
      await uploadTask.whenComplete(() => print("Error"));
      String imageUrl = await ref.getDownloadURL();
      // print("image url : " + user!.uid);
      await Auth.userReference
          .doc(user!.uid)
          .update({"metadata.coverImageUrl": imageUrl});
      Get.snackbar("Cover Image", "Updated");
      update();
    } catch (err) {
      print("error is big" + err.toString());
    }
  }

//profile screen update

  updateUserProfileImage(BuildContext context) async {
    try {
      final ImagePicker _picker = ImagePicker();
      // Pick an image
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        // imageFile1 = File(image.path);
        imageFile1 = await ImageCropper().cropImage(
          sourcePath: image.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          uiSettings: [
            AndroidUiSettings(
                toolbarTitle: 'Cover Photo',
                toolbarColor: Colors.deepOrange,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.ratio16x9,
                lockAspectRatio: false),
            IOSUiSettings(
              title: 'Cover Photo',
            ),
            WebUiSettings(
              context: context,
            ),
          ],
        );
        uploadProfileImageToFirebaseStorage();
      }
    } catch (err) {
      print(err);
    }
  }

  uploadProfileImageToFirebaseStorage() async {
    try {
      String uniqueName = DateTime.now().microsecondsSinceEpoch.toString();
      firebase_storage.UploadTask? uploadTask;
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child("images/ProfileImages")
          .child('/' + uniqueName);
      uploadTask = ref.putFile(File(imageFile1!.path));
      await uploadTask.whenComplete(() => print("Error"));
      String imageUrl = await ref.getDownloadURL();
      // print("image url : " + user!.uid);
      await Auth.userReference
          .doc(user!.uid)
          .update({"profileimage": imageUrl});
      Get.snackbar("Profile Image", "Updated");
    } catch (err) {
      print("error is big" + err.toString());
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    postList = getAllPostOfUser();
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
