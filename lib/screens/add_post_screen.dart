import 'package:facebookclone/controllers/add_post_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: GetBuilder<AddPostScreenController>(
          init: AddPostScreenController(),
          builder: (_) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _.postTextController,
                    maxLines: 1,
                    decoration: const InputDecoration(
                        hintText: "Enter Title", border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GetBuilder<AddPostScreenController>(
                      id: _.imageUpdateKey,
                      builder: (logic) {
                        return InkWell(
                          onTap: () async {
                            await logic.pickPostImage(context);
                          },
                          child: Container(
                            height: 200,
                            width: Get.width,
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 41, 40, 40),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            child: logic.imageFile != null
                                ? ClipRRect(
                                    borderRadius: const BorderRadius.all(
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
                        );
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                      onPressed: () async {
                        await _.addNewPost();
                      },
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.blue)),
                      child: const Text(
                        "Post",
                        style: TextStyle(color: Colors.white),
                      )),
                ],
              ),
            );
          }),
    );
  }
}
