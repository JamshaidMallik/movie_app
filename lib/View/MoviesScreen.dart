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
  final MovieController controller = Get.put(MovieController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Movies',
          style: bigFontStyle(),
        ),
        actions: [
          GetBuilder<MovieController>(builder: (c) {
            return c.selectedMovieList.isNotEmpty
                ? InkWell(
                    onTap: () => Get.to(const SelectedMoviesScreen()),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 15.0,
                        child: Text(
                          c.selectedMovieList.length.toString(),
                          style: TextStyle(color: whiteColor, fontWeight: FontWeight.bold, fontSize: 15.0),
                        ),
                      ),
                    ))
                : const SizedBox();
          }),
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
                child: FutureBuilder(
                    future: controller.fetchMovies(),
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: CircularProgressIndicator(
                          color: primaryColor,
                        ));
                      } else if (snapshot.hasData) {
                        return ListView.builder(
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
                            });
                      } else {
                        return const Center(child: Text('No Data Found'));
                      }
                    })),
            // Expanded(
            //   child: (controller.visibleList.isNotEmpty)
            //       ? ListView.builder(
            //           controller: controller.scrollController,
            //           itemCount: controller.visibleList.length + 1,
            //           physics: const BouncingScrollPhysics(),
            //           itemBuilder: (BuildContext context, int index) {
            //             if (index < controller.visibleList.length) {
            //               var item = controller.visibleList[index];
            //               return MovieCardWidget(item: item);
            //             } else {
            //               return loadingWidget(controller);
            //             }
            //           })
            //       : const Center(child: Text('No Match Found')),
            // ),
          ],
        ),
      ),
    );
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
          child: controller.hasMore ? CupertinoActivityIndicator(color: randomColor[Random().nextInt(randomColor.length)]) : const Text('has no more data')),
    );
  }
}
