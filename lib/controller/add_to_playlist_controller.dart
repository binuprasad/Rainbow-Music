import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddToPlaylistController extends GetxController{
  trailingfnctn(index){
    //  playlistCheck(item.data![index]);
  }

  ifcondition(item){
     if (item.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (item.data!.isEmpty) {
              return const Center(
                child: Text(
                  'NO Songs Found',
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                ),
              );
            }
  }  

  


}