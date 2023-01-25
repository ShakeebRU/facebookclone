import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebookclone/controllers/profile_screen_controller.dart';
import 'package:facebookclone/db/firestore_db.dart';
import 'package:facebookclone/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/post_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ProfileScreenController>(
          init: ProfileScreenController(),
          builder: (_) {
            return ListView(
              children: [
                FutureBuilder<DocumentSnapshot>(
                    future: FirestoreDB.userReference.doc(_.user!.uid).get(),
                    builder:
                        ((context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Row(
                          children: [
                            Center(
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.replay_outlined,
                                    size: 30,
                                  )),
                            ),
                          ],
                        );
                      }
                      if (snapshot.hasData && !snapshot.data!.exists) {
                        return Row(
                          children: [
                            Center(
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.replay_outlined,
                                    size: 30,
                                  )),
                            ),
                          ],
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.done) {
                        print(snapshot.data);
                        UserModel details = UserModel.fromJson(
                            snapshot.data!.data() as Map<String, dynamic>);
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 40,
                            ),
                            Stack(alignment: Alignment.bottomLeft, children: [
                              GestureDetector(
                                onTap: () {
                                  _.pickUserCoverImage(context);
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 30),
                                  height: 200,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: const BoxDecoration(
                                    color: Colors.grey,
                                  ),
                                  child: (details.metadata.coverImageUrl != "")
                                      ? ClipRRect(
                                          child: Image.network(
                                            details.metadata.coverImageUrl,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const Icon(
                                          Icons.person,
                                          color: Colors.white,
                                          size: 80,
                                        ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _.pickUserProfileImage(context);
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(left: 30),
                                  height: 150,
                                  width: 150,
                                  decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 41, 40, 40),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100))),
                                  child: details.imageUrl != ""
                                      ? ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(100)),
                                          child: Image.network(
                                            details.imageUrl,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const Icon(
                                          Icons.person,
                                          color: Colors.white,
                                          size: 80,
                                        ),
                                ),
                              ),
                            ]),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // const Text("Name :"),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  details.firstName,
                                  style: const TextStyle(fontSize: 30),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     const Text("Email :"),
                            //     Text(details.email)
                            //   ],
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     const Text("Gender :"),
                            //     Text(details.gender)
                            //   ],
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     const Text("DOB :"),
                            //     Text(details.dob)
                            //   ],
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     const Text("Address :"),
                            //     Text(details.education)
                            //   ],
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     const Text("Phone # :"),
                            //     Text(details.phoneNumber)
                            //   ],
                            // ),
                          ],
                        );
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CircularProgressIndicator(),
                        ],
                      );
                    })),
                Container(
                  width: Get.width,
                  height: 10,
                  color: Colors.grey,
                ),
                FutureBuilder<List<PostModel>>(
                    future: _.postList,
                    builder:
                        ((context, AsyncSnapshot<List<PostModel>> snapshot) {
                      if (snapshot.hasError) {
                        return Row(
                          children: [
                            Center(
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.replay_outlined,
                                    size: 30,
                                  )),
                            ),
                          ],
                        );
                      }

                      if (snapshot.connectionState == ConnectionState.done) {
                        return ListView.separated(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Container(
                              width: Get.width,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                            const BorderRadius
                                                                    .all(
                                                                Radius.circular(
                                                                    50)),
                                                        child: Image.network(
                                                          snapshot.data![index]
                                                              .userImage,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(snapshot
                                                            .data![index]
                                                            .userName),
                                                        Text(snapshot
                                                            .data![index]
                                                            .dateTime)
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
                                        Text(snapshot.data![index].postText),
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
                                      snapshot.data![index].postImage,
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
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          CircularProgressIndicator(),
                        ],
                      );
                    })),
              ],
            );
          }),
    );
  }
}
