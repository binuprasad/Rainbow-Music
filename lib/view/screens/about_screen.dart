import 'package:flutter/material.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:get/get.dart';
import 'package:music_player/colors/colors.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen>with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabControllers =TabController(vsync: this,length: 2,);
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: appcolor)),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'About',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Get.back();
                // Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        body:  Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:10,vertical: 50,),
              child: TabBar(
                labelStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                indicator: const UnderlineTabIndicator(borderSide: BorderSide.none),
                controller: tabControllers,
                tabs: const [
                     Tab(text: 'app'),
                      Tab(text: 'Developer',),
                      ],
                      ),
                      ),
             CustomCard(
              color: const Color.fromARGB(255, 235, 239, 230),
              elevation: 15,
              shadowColor: Colors.green,
                borderRadius:30,
                height: MediaQuery.of(context).size.height/2,
                child: Padding(
                  padding:const EdgeInsets.all(8.0),
                  child: TabBarView(
                    controller: tabControllers,
                    children:const [
                    Center(
                      child: Text(
                      'Welcome to MusicMusca and enjoy listening offline music with better experience. If you have any suggestions you can inform me by clicking the feedback section in the settings,We will try to improve our app more better,thank you.',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                     ),
                    ),
                   Center(
                    child: Text(
                     "I am Binuprasad.Expertised in UI/UX Designing and Flutter development based on kerala,if you have any queries related to  musicapp or about me by taping 'Contact' on the settings. Once of all thank you for supporting me.",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ],
              )
            ),
           ),
          ],
        ),
      ),
    );
  }
}
