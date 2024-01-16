import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/widgets/movie_card_widget.dart';
import '../constant/constant.dart';
import '../controller/movie_controller.dart';

class FavoriteMoviesScreen extends GetView<MovieController> {
  const FavoriteMoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Favorite',
          style: bigFontStyle(),
        ),
      ),
      body: GetBuilder(
          init: MovieController(),
          builder: (c) {
            final selectedPosts = controller.visibleList.where((element) {
              return element.isSelected == true;
            }).toList();
            if (selectedPosts.isEmpty) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/empty.png',
                    width: kSize.width * 0.5,
                  ),
                  10.height,
                  Text(
                    'No Data',
                    style: bigFontStyle(),
                  ),
                  10.height,
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        'Explore',
                        style: whiteFontStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
                      ))
                ],
              ));
            }
            return ListView.builder(
              itemCount: selectedPosts.length,
              itemBuilder: (context, index) {
                final post = selectedPosts[index];
                return MovieCardWidget(item: post);
              },
            );
          }),
    );
  }
}
