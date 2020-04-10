import 'package:flutter/cupertino.dart';
import 'package:movie_record/src/models/movie_model.dart';

class MovieDetailArgument {
  Movie movie;
  String heroSubTag;

  MovieDetailArgument(this.movie, this.heroSubTag);
}