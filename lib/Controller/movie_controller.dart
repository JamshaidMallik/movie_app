import 'package:flutter/material.dart';
import 'package:movie_app/Model/Movie.dart';
import 'package:get/get.dart';
import '../Services/MovieService.dart';

class MovieController extends GetxController {
  /// ScrollController is used to control the scrolling of the listview for pagination
  final ScrollController scrollController = ScrollController();

  /// MovieService is used to get the movies from the API
  MovieService movieService = MovieService();

  /// Movie is the model class for the movie
  Movie movieModel = Movie();

  /// movieList is used to store the list of movies
  List<Movie> movieList = [];

  /// selectedMovieList is used to store the list of selected movies
  List<Movie> selectedMovieList = [];

  /// visibleList is used to store the list of visible movies
  List<Movie> visibleList = [];

  /// isLoading is used to check whether the data is loading or not
  bool hasMore = true;

  /// page is used to store the page number for pagination
  int page = 1;

  /// limit is used to store the limit of the movies
  int limit = 20;

  /// onInit is used to initialize the scrollController
  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_scrollListener);
  }

  /// favToggleFunction is used to toggle the favorite icon and add or remove the movie from the selectedMovieList
  void favToggleFunction(Movie item) {
    item.isSelected = !item.isSelected!;
    if (item.isSelected!) {
      selectedMovieList.add(item);
    } else {
      selectedMovieList.remove(item);
    }
    update();
  }

  /// searchMovies is used to search the movies from the list locally
  void searchMovies(String value) {
    hasMore = false;
    visibleList = movieList.where((element) => element.title
            .toString()
            .toLowerCase()
            .contains(value.toLowerCase()))
        .toList();
    update();
  }

  /// fetchMovies is used to fetch the movies from the API
  Future<List<Movie>> fetchMovies() async {
    var response = await movieService.getMovies(limit: limit, page: page);
    page++;
    if (response['data']['movie_count'] < limit) { // total movies is 58317
      hasMore = false;
    }
    /// forEach is used to iterate through the list of movies and add it to the movieList
    response['data']['movies'].forEach((element) {
      movieModel = Movie.fromJson(element);
      movieList.add(movieModel);
      visibleList = movieList;
    });
    update();
    return visibleList;
  }

  /// _scrollListener is used to listen to the scrollController and fetch the movies when the user reaches the end of the listview
  _scrollListener() {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      fetchMovies();
      update();
    }
  }

  /// onRefreshMovie is used to refresh the listview
  onRefreshMovie() async {
    await Future.delayed(const Duration(seconds: 2));
    movieList.clear();
    visibleList.clear();
    page = 1;
    hasMore = true;
    fetchMovies();
    update();
  }

  /// ocClose is used to dispose the scrollController and clear the visibleList
  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
    visibleList.clear();
  }
}
