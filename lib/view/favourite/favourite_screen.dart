import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/controller/favourite_screen%20_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavouriteScreen extends GetView<FavouriteScreenController> {
  FavouriteScreen({Key? key}) : super(key: key);

  final favcontroller = Get.put(FavouriteScreenController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavouriteScreenController>(
      builder: (controller) => Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: appgradientcolor,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Row(
              children: [
                Text(
                  'Favourite',
                  style: GoogleFonts.ptSerif(
                      color: black, fontWeight: FontWeight.bold, fontSize: 19),
                ),
                const Expanded(
                  child: Divider(
                    thickness: 1,
                    color: black,
                  ),
                ),
              ],
            ),
          ),
          body: SafeArea(
            child: controller.favoriteSongs.isEmpty
                ? Center(
                    child: Column(
                    children: [
                      Lottie.network(
                          'https://assets7.lottiefiles.com/packages/lf20_jw02fgil.json'),
                      const Text(
                        'No Favourite Songs',
                        style: TextStyle(fontSize: 16, color: white),
                      )
                    ],
                  ))
                : GetBuilder<FavouriteScreenController>(
                    builder: (controller) => SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: controller.favoriteSongs.length,
                       
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Card(
                                                  //      shape: RoundedRectangleBorder(
                                                  // borderRadius: BorderRadius.circular(20)),
                                              color: Colors.lightBlue.withOpacity(0.5),
                                              margin: const EdgeInsets.symmetric(vertical: 7),
                              child: ListTile(
                                leading: QueryArtworkWidget(
                                  id: controller.favoriteSongs[index].id,
                                  type: ArtworkType.AUDIO,
                                  nullArtworkWidget: const Icon(
                                    Icons.music_note_outlined,
                                    color: Colors.black,
                                    size: 35,
                                  ),
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    controller.deletesong(index);
                                  },
                                  icon: const Icon(
                                    Icons.favorite,
                                    color: Colors.black,
                                  ),
                                ),
                                title: Text(
                                  controller.favoriteSongs[index].title,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                                subtitle: Text(
                                  controller.favoriteSongs[index].album!,
                                  style: const TextStyle(color: Colors.black54),
                                ),
                                onTap: () {
                                  controller.listileOntap(index);
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
