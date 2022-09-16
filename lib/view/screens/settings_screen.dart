import 'package:flutter/material.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:music_player/view/screens/about_screen.dart';
import 'package:music_player/view/screens/feedback_url.dart';
import 'package:music_player/db/playlist_db.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Urifunction feedback = Urifunction();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.yellow, Colors.white])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                setState(() {});
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const Text(
            'Settings',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
                trailing: const Icon(Icons.feedback)
                    
              ),
            ),
            CustomCard(
              color: Colors.transparent,
              borderRadius: 7.0,
              child: ListTile(
                onTap: () {
                  showdialogue(context: context);
                },
                leading: const Text(
                  'ResetApp',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                trailing:const Icon(Icons.replay),
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
                  trailing: const Icon(Icons.star)),
            ),
            CustomCard(
              color: Colors.transparent,
              borderRadius: 7.0,
              child: ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AboutScreen()));
                  },
                  leading: const Text(
                    'About',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  trailing: const Icon(
                    Icons.info_outline_rounded,
                    color: Colors.black,
                  )),
            ),
            CustomCard(
              color: Colors.transparent,
              borderRadius: 7.0,
              child: ListTile(
                onTap: () {},
                leading: const Text(
                  'Share',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                trailing: const Icon(Icons.share),
              ),
            ),
            CustomCard(
                onTap: () {
                  showContactBottomsheet(context: context);
                },
                color: Colors.transparent,
                borderRadius: 7.0,
                child: const ListTile(
                    leading: Text(
                      'Contact',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    trailing: Icon(
                      Icons.contact_page,
                    ))),
          ],
        ),
      ),
    );
  }

  showContactBottomsheet({required BuildContext context}) {
    return showModalBottomSheet(
        elevation: 50,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(26)) ),
        context: context,
        builder: (builder) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 4,
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
          );
        });
  }

  showdialogue({required BuildContext context}) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Reset App'),
            content: const Text('Are you sure to reset?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('NO')),
              TextButton(
                  onPressed: () {
                    appReset(context);
                  },
                  child: const Text('Yes'))
            ],
          );
        });
  }
}
