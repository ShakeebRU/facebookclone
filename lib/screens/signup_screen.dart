import 'package:facebookclone/controllers/signup_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: GetBuilder<SignupScreenController>(
          init: SignupScreenController(),
          builder: (_) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _.formKey,
                child: ListView(
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        GetBuilder<SignupScreenController>(
                            id: _.imageUpdateKey,
                            builder: (logic) {
                              return Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 100,
                                      decoration: const BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 41, 40, 40),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50))),
                                      child: logic.imageFile != null
                                          ? ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(50)),
                                              child: Image.file(
                                                logic.imageFile!,
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : const Icon(
                                              Icons.person,
                                              color: Colors.white,
                                              size: 80,
                                            ),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        await logic
                                            .pickUserProfileImage(context);
                                      },
                                      child: Container(
                                        height: 27,
                                        width: 27,
                                        decoration: const BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(50))),
                                        child: const Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 27,
                                        ),
                                      ),
                                    )
                                  ]);
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Name:",
                              style: TextStyle(fontSize: 17),
                            )),
                        TextFormField(
                          controller: _.nameController,
                          maxLines: 1,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Email:",
                              style: TextStyle(fontSize: 17),
                            )),
                        TextFormField(
                          controller: _.emailController,
                          maxLines: 1,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Password:",
                              style: TextStyle(fontSize: 17),
                            )),
                        TextFormField(
                          obscureText: _.showPassword,
                          controller: _.passwordController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              suffix: InkWell(
                                onTap: () {
                                  _.showPassword = !_.showPassword;
                                },
                                child: Icon(
                                  _.showPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                              ),
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Re-Type Password:",
                              style: TextStyle(fontSize: 17),
                            )),
                        TextFormField(
                          obscureText: _.showPassword,
                          controller: _.rePasswordController,
                          maxLines: 1,
                          decoration: InputDecoration(
                              suffix: InkWell(
                                onTap: () {
                                  _.showPassword = !_.showPassword;
                                },
                                child: Icon(
                                  _.showPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                              ),
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Phone Number:",
                              style: TextStyle(fontSize: 17),
                            )),
                        TextFormField(
                          controller: _.phoneController,
                          maxLines: 1,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Phone Number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Date of Birth:",
                              style: TextStyle(fontSize: 17),
                            )),
                        TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)))),
                          controller: _.dateController,
                          onTap: () {
                            _.datePicker();
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Education:",
                              style: TextStyle(fontSize: 17),
                            )),
                        TextFormField(
                          controller: _.educationController,
                          maxLines: 1,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Address';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Gender:",
                                  style: TextStyle(fontSize: 17),
                                )),
                            GetBuilder<SignupScreenController>(
                                id: _.dropDownUpadteKey,
                                builder: (logic) {
                                  return DropdownButton<String>(
                                    value: logic.genderValue,
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                      size: 35,
                                    ),
                                    elevation: 16,
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 53, 52, 52),
                                        fontSize: 25),
                                    underline: Container(
                                      height: 1,
                                      color: Colors.black,
                                    ),
                                    onChanged: (String? value) {
                                      // This is called when the user selects an item.
                                      logic.selectedDropDownValue(value!);
                                    },
                                    items: SignupScreenController.gender
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  );
                                }),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Already have account? Sign In")),
                        const SizedBox(
                          height: 10,
                        ),
                        TextButton(
                            style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.blue),
                                minimumSize:
                                    MaterialStatePropertyAll(Size(80, 60))),
                            onPressed: () {
                              _.formValidateCheck();
                            },
                            child: const Text(
                              "Sign up",
                              style:
                                  TextStyle(fontSize: 22, color: Colors.white),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
