import 'package:flutter/material.dart';
import 'package:movie_record/src/models/movie_detail_argument.dart';
import 'package:movie_record/src/models/movie_model.dart';
import 'package:movie_record/src/providers/movies_provider.dart';

class DataSearch extends SearchDelegate {

  final movies = ['one', 'two', 'three'];
  final recentMovies = ['four', 'five', 'six','seven'];

  final _moviesProvider = MoviesProvider();

  String _movieSelected = "";

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.indigo,
        child: Text(_movieSelected),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return query.isEmpty ? Container() : FutureBuilder(
      future: _moviesProvider.searchMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        List<Movie> movies = snapshot.data;
        return snapshot.hasData && snapshot.data != null
            ? ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index){
                return ListTile(
                  leading: Hero(
                    tag: "${movies[index].id}_search",
                    child: FadeInImage(
                      image: NetworkImage(movies[index].getPosterPath()),
                      placeholder: AssetImage('assets/no-available-image.png'),
                      width: 50.0,
                      fit: BoxFit.contain,
                    ),
                  ),
                  title: Text(movies[index].title),
                  subtitle: Text(movies[index].originalTitle),
                  onTap: (){
                    close(context, null);
                    Navigator.pushNamed(
                        context,
                        'detail',
                        arguments: MovieDetailArgument(
                            movies[index], "search"
                        )
                    );
                  },
                );
              }
            )
            : Center(child: CircularProgressIndicator(),);
      },
    );
  }
  /*@override
  Widget buildSuggestions(BuildContext context) {
    final suggestedList = query.isEmpty
        ? recentMovies : movies.where((movie) =>
          movie.toLowerCase().startsWith(query.toLowerCase()
        )).toList();

    return ListView.builder(
        itemCount: suggestedList.length,
        itemBuilder: (context, index){
          return ListTile(
            leading: Icon(Icons.movie),
            title: Text(suggestedList[index]),
            onTap: (){
              // Call buildResults to show a widget with the selected data
              _movieSelected = suggestedList[index];
              showResults(context);
            },
          );
        },
    );
  }*/

}