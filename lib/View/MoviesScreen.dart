import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constant/constant.dart';
import '../widgets/movie_card_widget.dart';
import 'show_selectd_movie_screen.dart';
import '../../controller/movie_controller.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MovieController>(
        init: MovieController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Movies',
                style: bigFontStyle(),
              ),
              actions: [
                controller.selectedMovieList.isNotEmpty
                    ? InkWell(
                        onTap: () => Get.to(const SelectedMoviesScreen()),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: randomColor[Random().nextInt(randomColor.length)],
                            child: Text(
                              controller.selectedMovieList.length.toString(),
                              style: TextStyle(color: whiteColor, fontWeight: FontWeight.bold, fontSize: 20.0),
                            ),
                          ),
                        ))
                    : Container(),
              ],
            ),
            body: RefreshIndicator(
              backgroundColor: whiteColor,
              color: randomColor[Random().nextInt(randomColor.length)],
              onRefresh: () => controller.onRefreshMovie(),
              child: Column(
                children: [
                  CupertinoSearchTextField(
                    onChanged: (value) => controller.searchMovies(value),
                    placeholder: 'Search',
                    style: const TextStyle(color: Colors.black),
                    placeholderStyle: const TextStyle(color: Colors.black),
                    prefixInsets: const EdgeInsets.all(10),
                    suffixInsets: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                  ),
                  Expanded(
                    child: (controller.visibleList.isNotEmpty)
                        ? ListView.builder(
                            controller: controller.scrollController,
                            itemCount: controller.visibleList.length + 1,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              if (index < controller.visibleList.length) {
                                var item = controller.visibleList[index];
                                return MovieCardWidget(item: item);
                              } else {
                                return loadingWidget(controller);
                              }
                            })
                        : const Center(child: Text('No Match Found')),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

// ignore: camel_case_types
class loadingWidget extends StatelessWidget {
  final MovieController controller;
  const loadingWidget(
    this.controller, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      child: Center(
          child: controller.hasMore
              ? CircularProgressIndicator(color: randomColor[Random().nextInt(randomColor.length)])
              : const Text('has no more data')),
    );
  }
}
