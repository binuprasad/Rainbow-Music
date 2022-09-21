import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/controller/splash_screen_controller.dart';

class SpalshScreen extends GetView<SplashscreenController> {
   const SpalshScreen({Key? key}) : super(key: key);
    @override
  Widget build(BuildContext context) {
 Get.put(SplashscreenController());
   return const Scaffold(
      backgroundColor: Colors.black,
        body: Center(
           child:Image(image: 
           AssetImage('assets/image/appicon copy.jpeg',),
           fit: BoxFit.fill,),)
    );
  }
}
