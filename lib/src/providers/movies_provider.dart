import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:movie_record/src/models/movie_model.dart';

class MoviesProvider {
  String _movieDBApiKey = 'a1e9a9b933e0665365757075050ec073';
  String _movieDBUrl = 'api.themoviedb.org';
  String _movieDBLanguage = 'es-ES';
  int _movieDBVersion = 3;

  Future<List<Movie>> getNowPlaying() async {
    final url = Uri.https(_movieDBUrl, '$_movieDBVersion/movie/now_playing',
        {'api_key': _movieDBApiKey, 'language': _movieDBLanguage});

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final movies = Movies.fromJson(decodedData['results']);

    print(movies.items[0].title);

    return movies.items;
  }
}
