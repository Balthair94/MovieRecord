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
        SliverList(
          delegate: SliverChildListDelegate([
            SizedBox(height: 16.0,),
            _postTitle(movie, context),
            _description(movie, context),
            _description(movie, context),
            _description(movie, context),
            _description(movie, context),
          ]),
        ),
      ],
    ));
  }

  Widget _description(Movie movie, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Text(movie.overview, textAlign: TextAlign.justify,),
    );
  }

  Widget _postTitle(Movie movie, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: FadeInImage(
              height: 150.0,
              image: NetworkImage(
                movie.getPosterPath(),
              ),
              placeholder: AssetImage('assets/no-available-image.png'),
            ),
          ),
          SizedBox(
            width: 16.0,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  movie.title,
                  style: Theme.of(context).textTheme.title,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(movie.originalTitle,
                    style: Theme.of(context).textTheme.subtitle,
                    overflow: TextOverflow.ellipsis),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text('${movie.voteAverage}',
                        style: Theme.of(context).textTheme.subhead)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _createAppBar(Movie movie) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          movie.title,
          overflow: TextOverflow.ellipsis,
        ),
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
