import 'package:facebookclone/screens/home_screen.dart';
import 'package:facebookclone/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreenController extends GetxController {
  FocusNode? focusNode;
  TextEditingController? emailController;
  TextEditingController? passwordController;
  final String hintEmail = "Please Enter your Email";
  final String hintPassword = "Please Enter your Password";

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter Your Email";
    }
    if (GetUtils.isEmail(value)) {
      return "Enter a valid Email";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter Your Password";
    }
    if (value.length < 6) {
      return "Enter a valid Password";
    }
    return null;
  }

  onRegisterPressed() {
    Get.to(const SignUpScreen());
  }

  // onLoginPressed() {
  //   Auth.loginUser(
  //           email: emailController!.text, password: passwordController!.text)
  //       .then((value) => {
  //             Get.snackbar("Login Status", "Successfully Logged in",
  //                 backgroundColor: Colors.blue, colorText: Colors.white),
  //             Get.defaultDialog(
  //                 title: "Status",
  //                 content: const Text("Successfully Logged in")),
  //             Get.to(HomeScreen()),
  //           })
  //       .catchError((err) {
  //     Get.snackbar("Login Failed", "Enter a Valid Email or Password",
  //         backgroundColor: Colors.blue, colorText: Colors.white);
  //   });
  // }

  onLoginPressed() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: emailController!.text,
        password: passwordController!.text,
      )
          .then((value) {
        Get.snackbar("Login Status", "Successfully Logged in",
            backgroundColor: Colors.blue, colorText: Colors.white);
        Get.defaultDialog(
            title: "Status", content: const Text("Successfully Logged in"));
        Get.to(HomeScreen());
      });
      // if (!mounted) return;
      // Get.back();
    } catch (e) {
      // await showDialog(
      //   context: context,
      //   builder: (context) => AlertDialog(
      //     actions: [
      //       TextButton(
      //         onPressed: () {
      //           Get.back();
      //         },
      //         child: const Text('OK'),
      //       ),
      //     ],
      //     content: Text(
      //       e.toString(),
      //     ),
      //     title: const Text('Error'),
      //   ),
      // );
    }
  }

  @override
  void disposeId(Object id) {
    // TODO: implement disposeId
    emailController?.dispose();
    passwordController?.dispose();
    super.disposeId(id);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    focusNode = FocusNode();
    if (kDebugMode) {
      passwordController = TextEditingController(text: '12345678');
    }
    emailController = TextEditingController(text: '');
  }
}
