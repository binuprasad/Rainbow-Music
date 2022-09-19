import 'dart:async';

import 'package:get/get.dart';
import 'package:music_player/view/screens/bottom_navigatio_screen.dart';

class SplashscreenController extends GetxController{
  @override
  void onInit() {
    gotologin();

    super.onInit();
  }

   Future<void> gotologin() async {
    Timer(
        const Duration(seconds: 3),
        (() => Get.off(const BottomNavigationScreen())
            ),
            );
        }


   
}