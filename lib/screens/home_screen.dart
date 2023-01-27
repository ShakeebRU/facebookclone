import 'package:facebookclone/controllers/home_screen_controller.dart';
import 'package:facebookclone/screens/add_post_screen.dart';
import 'package:facebookclone/screens/all_post_screen.dart';
import 'package:facebookclone/screens/chat/rooms.dart';
import 'package:facebookclone/screens/chat/util.dart';
import 'package:facebookclone/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TextStyle unselectedLabelStyle = TextStyle(
      color: Colors.white.withOpacity(0.5),
      fontWeight: FontWeight.w500,
      fontSize: 15);

  final TextStyle selectedLabelStyle = const TextStyle(
      color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15);

  buildBottomNavigationMenu(context, landingPageController) {
    return Obx(() => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
          child: Container(
            height: 90,
            child: BottomNavigationBar(
              showUnselectedLabels: false,
              showSelectedLabels: false,
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
                    height: 37,
                    width: 37,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: landingPageController.tabIndex.value != 0
                            ? Color.fromRGBO(36, 54, 101, 1.0)
                            : Colors.white),
                    child: Icon(
                      Icons.home,
                      color: landingPageController.tabIndex.value == 0
                          ? Color.fromRGBO(36, 54, 101, 1.0)
                          : Colors.white,
                      size: 35.0,
                    ),
                  ),
                  label: '',
                  backgroundColor: const Color.fromRGBO(36, 54, 101, 1.0),
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: landingPageController.tabIndex.value != 1
                            ? Color.fromRGBO(36, 54, 101, 1.0)
                            : Colors.white),
                    child: Icon(
                      Icons.chat,
                      color: landingPageController.tabIndex.value == 1
                          ? Color.fromRGBO(36, 54, 101, 1.0)
                          : Colors.white,
                      size: 35.0,
                    ),
                  ),
                  label: '',
                  backgroundColor: const Color.fromRGBO(36, 54, 101, 1.0),
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: landingPageController.tabIndex.value != 2
                            ? Color.fromRGBO(36, 54, 101, 1.0)
                            : Colors.white),
                    child: Icon(
                      Icons.add_box_outlined,
                      color: landingPageController.tabIndex.value == 2
                          ? Color.fromRGBO(36, 54, 101, 1.0)
                          : Colors.white,
                      size: 35.0,
                    ),
                  ),
                  label: '',
                  backgroundColor: const Color.fromRGBO(36, 54, 101, 1.0),
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: landingPageController.tabIndex.value != 3
                            ? Color.fromRGBO(36, 54, 101, 1.0)
                            : Colors.white),
                    child: Icon(
                      Icons.person_2_rounded,
                      color: landingPageController.tabIndex.value == 3
                          ? Color.fromRGBO(36, 54, 101, 1.0)
                          : Colors.white,
                      size: 35.0,
                    ),
                  ),
                  label: '',
                  backgroundColor: const Color.fromRGBO(36, 54, 101, 1.0),
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: landingPageController.tabIndex.value != 4
                            ? Color.fromRGBO(36, 54, 101, 1.0)
                            : Colors.white),
                    child: Icon(
                      Icons.logout_rounded,
                      color: landingPageController.tabIndex.value == 4
                          ? Color.fromRGBO(36, 54, 101, 1.0)
                          : Colors.white,
                      size: 35.0,
                    ),
                  ),
                  label: '',
                  backgroundColor: const Color.fromRGBO(36, 54, 101, 1.0),
                ),
              ],
            ),
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
