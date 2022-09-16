import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/view/screens/bottom_navigatio_screen.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({Key? key}) : super(key: key);

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  @override
  void initState() {
    gotologin(context);
    super.initState();
    }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
        body: Center(
           child:Image(image: 
           AssetImage('assets/image/appicon copy.jpeg',),
           fit: BoxFit.fill,),)
    );
  }

  Future<void> gotologin(BuildContext context) async {
    Timer(
        const Duration(seconds: 3),
        (() => Get.off(const BottomNavigationScreen())
            ));
        }
      }
