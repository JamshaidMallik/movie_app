import 'dart:convert';
import 'package:movie_app/Model/movie_model.dart';
import 'package:http/http.dart' as http;

class MovieService {
  Future<List<MovieModel>> getMovies() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List).map((e) => MovieModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}