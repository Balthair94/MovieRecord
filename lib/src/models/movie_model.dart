class Movies {
  List<Movie> items = List();

  Movies();

  Movies.fromJson(List<dynamic> json) {
    if(json == null) return;

    for(var item in json) {
      Movie movie = Movie.fromJson(item) ?? Movie();
      items.add(movie);
    }
  }
}

class Movie {
  int id;
  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;

  Movie({
    this.id,
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });

  Movie.fromJson(Map<String, dynamic> json) {
    id               = json['id'] ?? 0;
    popularity       = (json['popularity'] ?? 0) / 1;
    voteCount        = json['vote_count'] ?? 0;
    video            = json['video'] ?? false;
    posterPath       = json['poster_path'] ?? "";
    adult            = json['adult'] ?? false;
    backdropPath     = json['backdrop_path'] ?? "";
    originalLanguage = json['original_language'] ?? "";
    originalTitle    = json['original_title'] ?? "";
    genreIds         = (json['genre_ids'] ?? []).cast<int>();
    title            = json['title'] ?? "";
    voteAverage      = (json['vote_average'] ?? 0) /1;
    overview         = json['overview'] ?? "";
    releaseDate      = json['release_date'] ?? "";
  }

  String getPosterPath() {
    if(this.posterPath ==  null || this.posterPath == "") {
      return 'assets/no-available-image.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500${this.posterPath}';
    }
  }
}