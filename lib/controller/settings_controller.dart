import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/db/playlist_db.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsController extends GetxController {

  resetdialogue() {
    Get.defaultDialog(
        title: 'Reset App',
        content: const Text('Are you sure to reset?'),
        cancel: TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('NO')),
        confirm: TextButton(
            onPressed: () {
            appReset();
            },
            child: const Text('Yes')));
  }

  showContactBottomsheet() {
    Get.bottomSheet(
      elevation: 50,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(26))),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: 150,
          child: Column(
            children: [
              GestureDetector(
                onTap: (() async {
                  final Uri url = Uri.parse(
                      'https://instagram.com/_b__nu?igshid=YmMyMTA2M2Y=');
                  if (!await launchUrl(url)) {
                    throw 'could not launch $url';
                  }
                }),
                child: Row(
                  children: const [
                    CircleAvatar(
                      child: Image(
                        image: AssetImage('assets/image/Instagram.webp'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Instagram')
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: (() async {
                  final Uri url =
                      Uri.parse('https://www.facebook.com/binu.prasad.165');
                  if (!await launchUrl(url)) {
                    throw 'could not launch $url';
                  }
                }),
                child: Row(
                  children: const [
                    CircleAvatar(
                      child: Image(
                        image: AssetImage('assets/image/facebook.jpeg'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Facebook'),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: (() async {
                  final Uri url = Uri.parse(
                      'https://www.linkedin.com/in/binu-prasad-683a1b22a');
                  if (!await launchUrl(url)) {
                    throw 'could not launch $url';
                  }
                }),
                child: Row(
                  children: const [
                    CircleAvatar(
                      child: Image(
                        image: AssetImage('assets/image/linkedin.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Linkedin'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
