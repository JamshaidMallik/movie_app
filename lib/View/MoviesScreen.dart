import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constant/constant.dart';
import '../../controller/movie_controller.dart';
import '../widgets/movie_card_widget.dart';
import 'show_selectd_movie_screen.dart';


class MoviesScreen extends StatefulWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostController>(
        init: PostController(),
        builder: (postController) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Posts',
                style: bigFontStyle(),
              ),
              actions: [
                postController.selectedPostList.isNotEmpty?  InkWell(
                    onTap: () => Get.to(const SelectedMoviesScreen()),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: randomColor[Random().nextInt(randomColor.length)],
                        child: Text(
                          postController.selectedPostList.length.toString(),
                          style: TextStyle(
                              color: whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        ),
                      ),
                    )
                ):Container(),
              ],
            ),
            body: RefreshIndicator(
              backgroundColor: whiteColor,
              color: randomColor[Random().nextInt(randomColor.length)],
              onRefresh: () => postController.onRefreshPost(),
              child: Column(
                children: [
                  CupertinoSearchTextField(
                    onChanged: (value) => postController.searchPost(value),
                    placeholder: 'Search',
                    style: const TextStyle(
                        color: Colors.black),
                    placeholderStyle: const TextStyle(
                        color:  Colors.black),
                    prefixInsets: const EdgeInsets.all(10),
                    suffixInsets: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                  ),
                  Expanded(
                    child: (postController.visibleList.isNotEmpty)
                        ? ListView.builder(
                        controller: postController.scrollController,
                        itemCount: postController.visibleList.length + 1,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          if (index < postController.visibleList.length) {
                            var item = postController.visibleList[index];
                            return MovieCardWidget(item: item);
                          } else {
                            return loadingWidget(postController);
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
  final PostController Controller;
  const loadingWidget(
      this.Controller, {
        super.key,
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      child: Center(
          child: Controller.hasMore
              ? CircularProgressIndicator(
              color: randomColor[Random().nextInt(randomColor.length)])
              : const Text('has no more data')),
    );
  }
}