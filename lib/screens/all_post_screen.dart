import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:facebookclone/controllers/all_post_screen_controller.dart';
import 'package:facebookclone/db/firestore_db.dart';
import 'package:facebookclone/models/post_model.dart';
import 'package:facebookclone/screens/add_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllPostScreen extends StatelessWidget {
  const AllPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        foregroundColor: Colors.grey,
        elevation: 0,
        title: Container(
          alignment: Alignment.centerLeft,
          child: AnimatedTextKit(
            animatedTexts: [
              ColorizeAnimatedText(
                'FaceBook',
                textStyle: const TextStyle(
                    fontSize: 30.0,
                    fontFamily: 'Horizon',
                    fontWeight: FontWeight.bold),
                colors: [
                  const Color.fromRGBO(36, 54, 101, 1.0),
                  Colors.blue,
                  Colors.yellow,
                  const Color.fromARGB(255, 39, 53, 176),
                ],
              ),
            ],
            isRepeatingAnimation: true,
            totalRepeatCount: 10,
            // animatedTexts: [
            //   TyperAnimatedText('FaceBook',
            //       textStyle: const TextStyle(color: Colors.blue, fontSize: 27)),
            // ],
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Get.to(const AddPostScreen());
              },
              icon: const Icon(
                Icons.add_circle_outline_rounded,
                color: Colors.black,
              ))
        ],
      ),
      body: GetBuilder(
        init: AllPostScreenContoller(),
        builder: (_) {
          return FutureBuilder(
              future: FirestoreDB.postReference.get(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Something went wrong"),
                  );
                }
                if (snapshot.hasData) {
                  if (snapshot.data != null) {
                    return ListView.separated(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> doc = snapshot.data!.docs[index]
                            .data() as Map<String, dynamic>;
                        String docId = snapshot.data!.docs[index].id;
                        PostModel detail = PostModel.fromJson(doc, docId);

                        return Container(
                          width: Get.width,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.white,
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                50)),
                                                    child: Image.network(
                                                      detail.userImage,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(detail.userName),
                                                    Text(detail.dateTime)
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.share,
                                              color: Colors.red,
                                            ))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(detail.postText),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: Get.width,
                                // height: 150,
                                child: Image.network(
                                  detail.postImage,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("12 Likes"),
                                        Text("12 Comments"),
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.thumb_up_alt_outlined,
                                              color: Colors.red,
                                            )),
                                        Text("12 Comments"),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Container(
                          width: Get.width,
                          height: 10,
                          color: Colors.grey,
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text("Nothing to show"),
                    );
                  }
                }
                return const Center(
                  child: Text("Loading...."),
                );
              });
        },
      ),
    );

    // return Scaffold(
    //   body: FutureBuilder(
    //       future: FirestoreDB.postReference.get(),
    //       builder: (BuildContext context, AsyncSnapshot snapshot) {
    //         if (snapshot.hasError) {
    //           return const Center(
    //             child: Text("Something went wrong"),
    //           );
    //         }
    //         if (snapshot.hasData) {
    //           if (snapshot.data != null) {
    //             return ListView.builder(
    //               itemCount: snapshot.data!.docs.length,
    //               itemBuilder: (context, index) {
    //                 Map<String, dynamic> doc = snapshot.data!.docs[index].data()
    //                     as Map<String, dynamic>;
    //                 String docId = snapshot.data!.docs[index].id;
    //                 PostModel detail = PostModel.fromJson(doc, docId);
    //                 return ListTile(
    //                   title: Text(detail.title),
    //                   subtitle: Text(detail.body),
    //                   onTap: () {
    //                     Navigator.of(context).push(MaterialPageRoute(
    //                         builder: (context) => PostScreen(detail: detail)));
    //                   },
    //                 );
    //               },
    //             );
    //           } else {
    //             return const Center(
    //               child: Text("Nothing to show"),
    //             );
    //           }
    //         }
    //         return const Center(
    //           child: Text("Loading...."),
    //         );
    //       }),
    // );
  }
}
