import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/Model/movie_model.dart';
import 'package:get/get.dart';

class MovieController extends GetxController {
  MovieModel posts = MovieModel();
  List<MovieModel> movieList = [];
  List<MovieModel> selectedMovieList = [];
  List visibleList = [].obs;
  bool isLoading = false;
  bool hasMore = true;
  int page = 1;
  int limit = 50;
  final ScrollController scrollController = ScrollController();
  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_scrollListener);
    fetchMovies();
  }


  void selectItem(MovieModel item, bool isSelected) {
    item.isSelected = isSelected;
    if (isSelected) {
      selectedMovieList.add(item);
    } else {
      selectedMovieList.remove(item);
    }
    update();
  }

  void searchMovies(String value) {
    visibleList = movieList
        .where((element) => element.title
            .toString()
            .toLowerCase()
            .contains(value.toLowerCase()))
        .toList();
    update();
  }

  Future fetchMovies() async {
    isLoading = true;
    var response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts?_limit=$limit&_page=$page'));
    if (response.statusCode == 200) {
      final newList = jsonDecode(response.body);
      page++;
      if (newList.length < limit) {
        hasMore = false;
      }
      newList.forEach((element) {
        posts = MovieModel.fromJson(element);
        movieList.add(posts);
        visibleList = movieList;
      });
      update();
      isLoading = false;
    } else {
      isLoading = false;
    }
  }

  _scrollListener() {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      fetchMovies();
      update();
    }
  }

  onRefreshMovie() async {
    await Future.delayed(const Duration(seconds: 2));
    movieList.clear();
    page = 1;
    hasMore = true;
    fetchMovies();
    update();
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
    visibleList.clear();
  }
}
