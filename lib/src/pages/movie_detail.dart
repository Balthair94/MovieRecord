import 'package:flutter/material.dart';
import 'package:movie_record/src/models/movie_detail_argument.dart';

import 'package:movie_record/src/models/movie_model.dart';
import 'package:movie_record/src/providers/movies_provider.dart';
import 'package:movie_record/src/models/actor_model.dart';

class MovieDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MovieDetailArgument argument = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        _createAppBar(argument.movie),
        SliverList(
          delegate: SliverChildListDelegate([
            SizedBox(
              height: 16.0,
            ),
            _postTitle(argument, context),
            _description(argument.movie, context),
            _createCastView(argument.movie.id),
          ]),
        ),
      ],
    ));
  }

  Widget _description(Movie movie, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _postTitle(MovieDetailArgument argument, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: "${argument.movie.id}${argument.heroSubTag}",
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: FadeInImage(
                height: 150.0,
                image: NetworkImage(argument.movie.getPosterPath(),),
                placeholder: AssetImage('assets/no-available-image.png'),
              ),
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
                  argument.movie.title,
                  style: Theme.of(context).textTheme.title,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(argument.movie.originalTitle,
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
                    Text('${argument.movie.voteAverage}',
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
      backgroundColor: Colors.black,
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

  Widget _createCastView(int movieId) {
    final movieProvider = MoviesProvider();

    return FutureBuilder(
        future: movieProvider.getCast(movieId),
        builder: (BuildContext context, AsyncSnapshot<List<Actor>> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return _createActorsPageView(snapshot.data);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _createActorsPageView(List<Actor> cast) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        itemCount: cast.length,
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1,
        ),
        itemBuilder: (BuildContext context, int index) {
          return _actorCard(cast[index]);
        },
      ),
    );
  }

  Widget _actorCard(Actor actor) {
    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: FadeInImage(
              image: NetworkImage(actor.getProfilePhoto()),
              placeholder: AssetImage('assets/no-available-image.png'),
              height: 150.0,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
