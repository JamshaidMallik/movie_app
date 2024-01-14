import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/widgets/movie_card_widget.dart';
import '../controller/movie_controller.dart';

class SelectedMoviesScreen extends GetView<PostController> {
  const SelectedMoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selected Movies'),
      ),
      body:GetBuilder(
          init: PostController(),
          builder: (myController) {
            final selectedPosts = controller.selectedPostList;
            return ListView.builder(
              itemCount: selectedPosts.length,
              itemBuilder: (context, index) {
                final post = selectedPosts[index];
                return MovieCardWidget(item: post);
              },
            );
          }
      ),
    );
  }
}