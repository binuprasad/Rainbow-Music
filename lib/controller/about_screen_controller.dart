import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutScreenController extends GetxController with GetSingleTickerProviderStateMixin{

  late TabController controller;

  final List<Tab>myTap =[
    const Tab(
      text: 'About App',
    ),
    const Tab(text: "About Developer",)
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