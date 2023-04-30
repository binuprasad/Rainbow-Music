import 'package:flutter/material.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:get/get.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/controller/about_screen_controller.dart';

class AboutScreen extends GetView<AboutScreenController> {
  AboutScreen({Key? key}) : super(key: key);

  final aboutcontroller = Get.put(AboutScreenController());
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: appgradientcolor),
      ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: white,
          centerTitle: true,
          title: const Text(
            'About',
            style: TextStyle(fontWeight: FontWeight.bold, color: black),
          ),
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
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 50,
              ),
              child: TabBar(
                labelStyle:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                indicator:
                    const UnderlineTabIndicator(borderSide: BorderSide.none),
                controller: aboutcontroller.controller,
                tabs: aboutcontroller.myTap,
              ),
            ),
            CustomCard(
              color: const Color.fromARGB(255, 235, 239, 230),
              elevation: 15,
              shadowColor: green,
              borderRadius: 30,
              height: MediaQuery.of(context).size.height / 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TabBarView(
                  controller: aboutcontroller.controller,
                  children: const [
                    Center(
                      child: Text(
                        'Welcome to MusicMusca and enjoy listening offline music with better experience. If you have any suggestions you can inform me by clicking the feedback section in the settings,We will try to improve our app more better,thank you.',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    Center(
                      child: Text(
                        "I am Binuprasad.Expertised in UI/UX Designing and Flutter development based on kerala,if you have any queries related to  musicapp or about me by taping 'Contact' on the settings. Once of all thank you for supporting me.",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
