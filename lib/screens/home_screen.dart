import 'package:facebookclone/controllers/home_screen_controller.dart';
import 'package:facebookclone/screens/add_post_screen.dart';
import 'package:facebookclone/screens/all_post_screen.dart';
import 'package:facebookclone/screens/chat/rooms.dart';
import 'package:facebookclone/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TextStyle unselectedLabelStyle = TextStyle(
      color: Colors.white.withOpacity(0.5),
      fontWeight: FontWeight.w500,
      fontSize: 12);

  final TextStyle selectedLabelStyle = const TextStyle(
      color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12);

  buildBottomNavigationMenu(context, landingPageController) {
    return Obx(() => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: SizedBox(
          height: 54,
          child: BottomNavigationBar(
            showUnselectedLabels: true,
            showSelectedLabels: true,
            onTap: landingPageController.changeTabIndex,
            currentIndex: landingPageController.tabIndex.value,
            backgroundColor: const Color.fromRGBO(36, 54, 101, 1.0),
            unselectedItemColor: Colors.white.withOpacity(0.5),
            selectedItemColor: Colors.white,
            unselectedLabelStyle: unselectedLabelStyle,
            selectedLabelStyle: selectedLabelStyle,
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.only(bottom: 7),
                  child: const Icon(
                    Icons.home,
                    size: 20.0,
                  ),
                ),
                label: 'Home',
                backgroundColor: const Color.fromRGBO(36, 54, 101, 1.0),
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.only(bottom: 7),
                  child: const Icon(
                    Icons.chat,
                    size: 21.0,
                  ),
                ),
                label: 'Chat',
                backgroundColor: const Color.fromRGBO(36, 54, 101, 1.0),
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.only(bottom: 7),
                  child: const Icon(
                    Icons.add_box_outlined,
                    size: 21.0,
                  ),
                ),
                label: 'Add New Post',
                backgroundColor: const Color.fromRGBO(36, 54, 101, 1.0),
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.only(bottom: 7),
                  child: const Icon(
                    Icons.person_2_rounded,
                    size: 20.0,
                  ),
                ),
                label: 'Profile',
                backgroundColor: const Color.fromRGBO(36, 54, 101, 1.0),
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.only(bottom: 7),
                  child: const Icon(
                    Icons.logout_rounded,
                    size: 20.0,
                  ),
                ),
                label: 'LogOut',
                backgroundColor: const Color.fromRGBO(36, 54, 101, 1.0),
              ),
            ],
          ),
        )));
  }

  @override
  Widget build(BuildContext context) {
    final HomeScreenController homeScreenController =
        Get.put(HomeScreenController(), permanent: false);
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar:
          buildBottomNavigationMenu(context, homeScreenController),
      body: Obx(() => IndexedStack(
            index: homeScreenController.tabIndex.value,
            children: const [
              AllPostScreen(),
              RoomsPage(),
              AddPostScreen(),
              ProfileScreen(),
            ],
          )),
    ));
  }
}
