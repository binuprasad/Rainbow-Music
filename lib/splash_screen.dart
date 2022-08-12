import 'dart:async';

import 'package:flutter/material.dart';
import 'package:music_player/bottom_navigatio_screen.dart';

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
        body: Center(
            child: Text(
      'MUSIC MASCA',
      style: TextStyle(
          fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
    )));
  }

  Future<void> gotologin(BuildContext context) async {
    Timer(
        const Duration(seconds: 3),
        (() => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const BottomNavigationScreen()))));
  }
}
