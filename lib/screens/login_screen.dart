import 'package:facebookclone/controllers/login_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<LoginScreenController>(
          init: LoginScreenController(),
          builder: (_) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  const ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    child: Icon(
                      Icons.login,
                      size: 50,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    autocorrect: false,
                    autofocus: true,
                    controller: _.emailController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      labelText: 'Email',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.cancel),
                        onPressed: () => _.emailController?.clear(),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onEditingComplete: () {
                      _.focusNode?.requestFocus();
                    },
                    textCapitalization: TextCapitalization.none,
                    textInputAction: TextInputAction.next,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: TextField(
                      autocorrect: false,
                      controller: _.passwordController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.cancel),
                          onPressed: () => _.passwordController?.clear(),
                        ),
                      ),
                      focusNode: _.focusNode,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: true,
                      textCapitalization: TextCapitalization.none,
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: _.onRegisterPressed,
                      child:
                          const Text("Not have an Account yet? Register Here"),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.blue),
                              minimumSize:
                                  MaterialStatePropertyAll(Size(120, 60))),
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            _.onLoginPressed();
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          )),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}
