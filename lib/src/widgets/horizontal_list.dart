import 'package:flutter/material.dart';
import 'package:movie_record/src/models/movie_model.dart';


class HorizontalList extends StatelessWidget {

  final List<Movie> movies;

  HorizontalList({@required this.movies});

  @override
  Widget build(BuildContext context) {
    final Size _screenSize = MediaQuery.of(context).size;
    return Container(
      height: _screenSize.height * .2,
      child: PageView(
        pageSnapping: false,
        controller: PageController(
          initialPage: 0,
          viewportFraction: 0.2
        ),
        children: _cardsList(context),
      ),
    );
  }

  List<Widget> _cardsList(BuildContext context) {
    return movies.map((movie) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: FadeInImage(
                image: NetworkImage(movie.getPosterPath()),
                placeholder: AssetImage('assets/jar-loading.gif'),
                fit: BoxFit.cover,
                height: 100.0,
              ),
            ),
            SizedBox(height: 8.0,),
            Text(
              movie.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );
    }).toList();
  }
}
