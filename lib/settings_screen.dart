import 'package:flutter/material.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:music_player/about_screen.dart';
import 'package:music_player/feedback_url.dart';
import 'package:music_player/playlist/playlist_db.dart';
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
    return Scaffold(
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
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          CustomCard(
            color: Colors.white,
            borderRadius: 7.0,
            child: ListTile(
              leading: const Text(
                'Feedback',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              trailing: IconButton(
                  onPressed: () {
                    feedback.emailUriFunction();
                  },
                  icon: const Icon(Icons.feedback)),
            ),
          ),
          CustomCard(
            color: Colors.white,
            borderRadius: 7.0,
            child: ListTile(
              leading: const Text(
                'ResetApp',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              trailing: IconButton(
                onPressed: () {
                  showDialog(
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
                },
                icon: const Icon(Icons.replay),
              ),
            ),
          ),
          CustomCard(
            color: Colors.white,
            borderRadius: 7.0,
            shadowColor: Colors.green,
            hoverColor: Colors.green,
            child: ListTile(
              leading: const Text(
                'RateApp',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              trailing:
                  IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
            ),
          ),
          CustomCard(
            color: Colors.white,
            borderRadius: 7.0,
            child: ListTile(
              leading: const Text(
                'About',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              trailing: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AboutScreen()));
                  },
                  icon: const Icon(
                    Icons.info_outline_rounded,
                    color: Colors.black,
                  )),
            ),
          ),
          CustomCard(
            color: Colors.white,
            borderRadius: 7.0,
            shadowColor: Colors.green,
            hoverColor: Colors.green,
            child: ListTile(
              leading: const Text(
                'Share',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              trailing:
                  IconButton(onPressed: () {}, icon: const Icon(Icons.star)),
            ),
          ),
          CustomCard(
            onTap: () {
              showContactBottomsheet(context: context);
            },
            color: Colors.white,
            borderRadius: 7.0,
            shadowColor: Colors.green,
            hoverColor: Colors.green,
            child: ListTile(
                leading: const Text(
                  'Contact',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.contact_page,
                    ))),
          ),
        ],
      ),
    );
  }

  showContactBottomsheet({required BuildContext context}) {
    return showModalBottomSheet(
      
      elevation: 50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
        context: context,
        builder: (builder) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: MediaQuery.of(context).size.height/2,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: (() async {
                      final Uri url = Uri.parse('https://instagram.com/_b__nu?igshid=YmMyMTA2M2Y=');
                      if (!await launchUrl(url)) {
                        throw 'could not launch $url';
                      }
                    }),
                    child: Row(
                      children: const [CircleAvatar(), Text('Instagram')],
                    ),
                  ),
                  GestureDetector(
                    onTap: (() async {
                      final Uri url = Uri.parse('https://www.facebook.com/binu.prasad.165');
                      if (!await launchUrl(url)) {
                        throw 'could not launch $url';
                      }
                    }),
                    child: Row(
                      children: const [
                        CircleAvatar(),
                        Text('Facebook'),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: (() async {
                      final Uri url = Uri.parse('https://www.linkedin.com/in/binu-prasad-683a1b22a');
                      if (!await launchUrl(url)) {
                        throw 'could not launch $url';
                      }
                    }),
                    child: Row(
                      children: const [
                        CircleAvatar(),
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
}
