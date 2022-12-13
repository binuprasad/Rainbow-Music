import 'package:flutter/material.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:get/get.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/controller/settings_controller.dart';
import 'package:music_player/view/screens/about_screen.dart';
import 'package:music_player/view/screens/feedback_url.dart';
import 'package:share/share.dart';

// ignore: must_be_immutable
class SettingsScreen extends GetView<SettingsController> {
  SettingsScreen({Key? key}) : super(key: key);
  final settingsController = Get.put(SettingsController());

  Urifunction feedback = Urifunction();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: appgradientcolor,),),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: black,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const Text(
            'Settings',
            style: TextStyle(color: black, fontWeight: FontWeight.bold,),
          ),
        ),
        body: Column(
          children: [
            CustomCard(
              color: Colors.transparent,
              borderRadius: 7.0,
              child: ListTile(
                onTap: () {
                  feedback.emailUriFunction();
                },
                leading: const Text(
                  'Feedback',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                trailing: const Icon(Icons.feedback),
              ),
            ),
            CustomCard(
              color: Colors.transparent,
              borderRadius: 7.0,
              child: ListTile(
                onTap: () {
                  settingsController.resetdialogue();
                },
                leading: const Text(
                  'ResetApp',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                trailing: const Icon(Icons.replay),
              ),
            ),
            CustomCard(
              color: Colors.transparent,
              borderRadius: 7.0,
              child: ListTile(
                onTap: () {},
                leading: const Text(
                  'RateApp',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                trailing: const Icon(Icons.star),
              ),
            ),
            CustomCard(
              color: Colors.transparent,
              borderRadius: 7.0,
              child: ListTile(
                onTap: () {
                  Get.to(AboutScreen());
                },
                leading: const Text(
                  'About',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                trailing: const Icon(
                  Icons.info_outline_rounded,
                  color: black,
                ),
              ),
            ),
            CustomCard(
              color: Colors.transparent,
              borderRadius: 7.0,
              child: ListTile(
                onTap: () {
                  Share.share(
                      'https://play.google.com/store/apps/details?id=in.binuprasad.music_player');
                },
                leading: const Text(
                  'Share',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                trailing: const Icon(Icons.share),
              ),
            ),
            CustomCard(
              onTap: () {
                settingsController.showContactBottomsheet();
              },
              color: Colors.transparent,
              borderRadius: 7.0,
              child: const ListTile(
                leading: Text(
                  'Contact',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                trailing: Icon(Icons.contact_page),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
