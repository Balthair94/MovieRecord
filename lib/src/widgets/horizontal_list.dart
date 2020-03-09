import 'package:flutter/material.dart';
import 'package:movie_record/src/models/movie_model.dart';


class HorizontalList extends StatelessWidget {

  final List<Movie> movies;

  final Function loadMore;

  final _pageController = PageController(
      initialPage: 2,
      viewportFraction: 0.2
  );

  HorizontalList({@required this.movies, this.loadMore});

  @override
  Widget build(BuildContext context) {
    final Size _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent - 200) {
        loadMore();
      }
    });

    return Container(
      height: _screenSize.height * .2,
      child: PageView(
        pageSnapping: false,
        controller: _pageController,
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
