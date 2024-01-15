import 'package:flutter/material.dart';
import 'package:movie_app/Model/movie_model.dart';
import 'package:get/get.dart';
import 'package:movie_app/constant/constant.dart';
import '../Services/MovieServices.dart';

class MovieController extends GetxController {
  final ScrollController scrollController = ScrollController();
  MovieService movieService = MovieService();
  MovieModel movieModel = MovieModel();
  List<MovieModel> movieList = [];
  List<MovieModel> selectedMovieList = [];
  List<MovieModel> visibleList = [];
  bool isLoading = false;
  bool hasMore = true;
  int page = 1;
  int limit = 20;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_scrollListener);
  }

  void selectItem(MovieModel item) {
    item.isSelected = !item.isSelected!;
    if (item.isSelected!) {
      selectedMovieList.add(item);
    } else {
      selectedMovieList.remove(item);
    }
    /// add selected movie list to local storage
    kStorage.write('saveItemList', selectedMovieList.toList());
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

  Future<List<MovieModel>> fetchMovies() async {
    isLoading = true;
    var response = await movieService.getMovies(limit: limit, page: page);
    page++;
    if (response['data']['movie_count'] < limit) { // total movies is 58317
      hasMore = false;
    }
    response['data']['movies'].forEach((element) {
      movieModel = MovieModel.fromJson(element);
      movieList.add(movieModel);
      visibleList = movieList;
    });
    isLoading = false;
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
    visibleList.clear();
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
