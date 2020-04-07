import 'dart:async';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:movie_record/src/models/actor_model.dart';
import 'package:movie_record/src/models/movie_model.dart';

class MoviesProvider {
  String _movieDBApiKey = 'a1e9a9b933e0665365757075050ec073';
  String _movieDBUrl = 'api.themoviedb.org';
  String _movieDBLanguage = 'es-ES';
  int _movieDBVersion = 3;

  int _popularPage = 0;
  bool _isLoading = false;
  List<Movie> _popularMovies = List();

  // broadcast make understand that many places can hear the same stream
  final _popularMoviesStreamController =  StreamController<List<Movie>>.broadcast();

  // Add a list of movies to the stream
  Function(List<Movie>) get popularSink => _popularMoviesStreamController.sink.add;

  // Hear when a new list of movies is added in the stream
  Stream<List<Movie>> get popularStream => _popularMoviesStreamController.stream;

  void disposePopularStream() {
    _popularMoviesStreamController.close();
  }

  Future<List<Movie>> getNowPlaying() async {
    final url = Uri.https(_movieDBUrl, '$_movieDBVersion/movie/now_playing',
        {'api_key': _movieDBApiKey, 'language': _movieDBLanguage});

    return _performMovieListCall(url);
  }

  Future<List<Movie>> getPopular() async {
    if(_isLoading) return [];

    _popularPage++;
    _isLoading = true;

    final url = Uri.https(_movieDBUrl, '$_movieDBVersion/movie/popular',
        {
          'api_key': _movieDBApiKey,
          'language': _movieDBLanguage,
          'page': '$_popularPage'
        });

    final response = await _performMovieListCall(url);

    _popularMovies.addAll(response);
    popularSink(_popularMovies);

    _isLoading = false;

    return response;
  }

  Future<List<Movie>> _performMovieListCall(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final movies = Movies.fromJson(decodedData['results']);

    return movies.items;
  }

  Future<List<Actor>> getCast(int movieId) async {
    final url = Uri.https(
            _movieDBUrl,
            '$_movieDBVersion/$movieId/credits',
            {'api_key': _movieDBApiKey}
        );

    final response = await http.get(url);

    final decodedData = json.decode(response.body);

    final Cast cast = Cast.fromJson(decodedData['cast']);

    return cast.actors;
  }
}
