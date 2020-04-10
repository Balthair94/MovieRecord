import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate {

  final movies = ['one', 'two', 'three'];
  final recentMovies = ['four', 'five', 'six','seven'];

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
  }

}