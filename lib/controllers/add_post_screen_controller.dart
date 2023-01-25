import 'dart:io';

import 'package:facebookclone/db/firestore_db.dart';
import 'package:facebookclone/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class AddPostScreenController extends GetxController {
  TextEditingController postTextController = TextEditingController();

  File? imageFile;
  String imageUpdateKey = "imageupdateKey";

  pickPostImage(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          // CropAspectRatioPreset.ratio3x2,
          // CropAspectRatioPreset.original,
          // CropAspectRatioPreset.ratio4x3,
          // CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Profile Image',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Profile Image',
          ),
          WebUiSettings(
            context: context,
          ),
        ],
      );
      if (croppedFile != null) {
        imageFile = File(croppedFile.path);

        print("image.path: ${croppedFile.path}");
        update([imageUpdateKey]);
      }
    }
  }

  addNewPost() async {
    try {
      if (imageFile != null) {
        String uniqueName = DateTime.now().microsecondsSinceEpoch.toString();
        firebase_storage.UploadTask? uploadTask;
        firebase_storage.Reference ref = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child("images")
            .child('/' + uniqueName);
        uploadTask = ref.putFile(File(imageFile!.path));
        await uploadTask.whenComplete(() => print("Error"));

        String imageUrl = await ref.getDownloadURL();
        // print("image Url is" + imageUrl);
        Map<String, dynamic> data = {
          "postText": postTextController.text,
          "postImage": imageUrl,
        };
        FirestoreDB.addNewPost(data);
        postTextController.clear();
        imageFile = null;
        update([imageUpdateKey]);
        Get.snackbar("New Post", "Added");
      }
      postTextController.clear();
    } catch (err) {
      // print("error is big" + err.toString());
      Get.snackbar("Error On Uploading",
          "Having some issue while uploading try latter...!");
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
