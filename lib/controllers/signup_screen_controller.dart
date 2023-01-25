import 'dart:io';
import 'package:facebookclone/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class SignupScreenController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController educationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  bool showPassword = false;
  List<String> choices = <String>["Male", "Female", "Others"];
  var date;
  static const List<String> gender = <String>[
    'Male',
    'Female',
    'Others',
  ];
  String? genderValue = gender.first;
  String dropDownUpadteKey = "dropDownUpadteKey";
  final formKey = GlobalKey<FormState>();

  void datePicker() async {
    date = await showDatePicker(
        context: Get.context!,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());

    if (date != null) {
      dateController.text = date.toString();
      dateController.text = dateController.text.substring(0, 10);
    }
  }

  selectedDropDownValue(String value) {
    genderValue = value;
    update([dropDownUpadteKey]);
  }

  formValidateCheck() {
    if (formKey.currentState!.validate()) {
      uploadToFirebaseStorage();
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(content: Text("Done......!")),
      );
    }
  }

  File? imageFile;
  String imageUpdateKey = "imageupdateKey";

  pickUserProfileImage(BuildContext context) async {
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

  uploadToFirebaseStorage() async {
    try {
      String uniqueName = DateTime.now().microsecondsSinceEpoch.toString();
      firebase_storage.UploadTask? uploadTask;
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child("images")
          .child('/' + uniqueName);
      uploadTask = ref.putFile(File(imageFile!.path));
      await uploadTask.whenComplete(() => print("Error"));

      String imageUrl = await ref.getDownloadURL();
      if (imageFile == null) {
        imageUrl = "";
      }
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        User? currentUser = credential.user;
        if (currentUser != null) {
          Map<String, dynamic> userMetaData = {
            "phone": phoneController.text,
            "email": emailController.text,
            "gender": genderValue,
            "education": educationController.text,
          };
          await FirebaseChatCore.instance.createUserInFirestore(
            types.User(
                firstName: nameController.text,
                id: credential.user!.uid,
                imageUrl: imageUrl,
                metadata: userMetaData),
          );
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          debugPrint('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          debugPrint('The account already exists for that email.');
        }
      } catch (e) {
        debugPrint(e.toString());
        Get.snackbar("Error", e.toString());
      }
      nameController.clear();
      emailController.clear();
      passwordController.clear();
      rePasswordController.clear();
      educationController.clear();
      phoneController.clear();
      dateController.clear();
      Get.to(const LoginScreen());
    } catch (err) {
      print("error is big" + err.toString());
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
