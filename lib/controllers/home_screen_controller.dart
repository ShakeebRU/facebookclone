import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebookclone/auth/firebase_auth.dart';
import 'package:facebookclone/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  var tabIndex = 0.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
    if (index == 4) {
      FirebaseAuth.instance.signOut();
      Get.offAll(const LoginScreen());
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
