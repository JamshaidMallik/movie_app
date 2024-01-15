import 'dart:convert';
import 'package:http/http.dart' as http;

class MovieService {
  Future<dynamic> getMovies({required int limit, required int page}) async {
    var response = await http.get(Uri.parse('https://www.yts.nz/api/v2/list_movies.json?sort=seeds&limit=$limit&page=$page'));
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      return decodedResponse;
    } else {
      throw Exception('Failed to load movies');
    }
  }
}