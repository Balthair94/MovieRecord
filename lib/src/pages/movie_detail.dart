import 'package:flutter/material.dart';
import 'package:movie_record/src/models/movie_model.dart';


class MovieDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            _createAppBar(movie),
          ],
        )
    );
  }

  Widget _createAppBar(Movie movie) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: false,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(movie.title, overflow: TextOverflow.ellipsis,),
        titlePadding: EdgeInsets.only(left: 16.0, bottom: 16.0),
        background: FadeInImage(
          image: NetworkImage(movie.getBackdropPath()),
          placeholder: AssetImage('assets/no-available-image.png'),
          fadeInDuration: Duration(milliseconds: 250),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
