import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutScreenController extends GetxController with GetSingleTickerProviderStateMixin{

  late TabController controller;

  final List<Tab>myTap =[
    const Tab(
      text: 'Welcome to MusicMusca and enjoy listening offline music with better experience. If you have any suggestions you can inform me by clicking the feedback section in the settings,We will try to improve our app more better,thank you.',
    ),
    const Tab(text: "I am Binuprasad.Expertised in UI/UX Designing and Flutter development based on kerala,if you have any queries related to  musicapp or about me by taping 'Contact' on the settings. Once of all thank you for supporting me.",)
  ];
  @override
  void onInit() {
    controller=TabController(length: 2,vsync: this);
    super.onInit();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}