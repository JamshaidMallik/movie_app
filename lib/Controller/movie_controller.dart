import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/Model/movie_model.dart';
import 'package:get/get.dart';

import '../Services/MovieServices.dart';

class MovieController extends GetxController {
  MovieService movieService = MovieService();
  String postUrl = 'https://jsonplaceholder.typicode.com/posts';
  MovieModel movieModel = MovieModel();
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
    // fetchMovies();
  }

  void selectItem(MovieModel item) {
    item.isSelected = !item.isSelected!;
    if (item.isSelected!) {
      selectedMovieList.add(item);
    } else {
      selectedMovieList.remove(item);
    }
    update();
  }


  void searchMovies(String value) {
    hasMore = false;
    visibleList = movieList.where((element) => element.title
            .toString()
            .toLowerCase()
            .contains(value.toLowerCase()))
        .toList();
    update();
  }

  Future fetchMovies() async {
    var response = await movieService.getMovies(limit: limit, page: page);
    log('fetchMovies: $response');
    page++;
    if (response['data']['movie_count'] < limit) { // total movies is 58317
      hasMore = false;
    }
    response['data']['movies'].forEach((element) {
      movieModel = MovieModel.fromJson(element);
      movieList.add(movieModel);
      visibleList = movieList;
    });
    update();
    return visibleList;
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
