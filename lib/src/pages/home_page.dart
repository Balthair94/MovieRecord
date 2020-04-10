import 'package:flutter/material.dart';

import 'package:movie_record/src/models/movie_model.dart';
import 'package:movie_record/src/providers/movies_provider.dart';
import 'package:movie_record/src/search/data_search.dart';
import 'package:movie_record/src/widgets/card_swiper_widget.dart';
import 'package:movie_record/src/widgets/horizontal_list.dart';

class HomePage extends StatelessWidget {
  final MoviesProvider _moviesProvider = MoviesProvider();

  @override
  Widget build(BuildContext context) {
    _moviesProvider.getPopular();

    return Scaffold(
      appBar: AppBar(
        title: Text('Movies in teathers'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => {
              showSearch(context: context, delegate: DataSearch())
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[_swiperCards(), _footer(context)],
      ),
    );
  }

  Widget _swiperCards() {
    return FutureBuilder(
        future: _moviesProvider.getNowPlaying(),
        builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return CardSwiperWidget(data: snapshot.data);
          } else {
            return Container(
                height: 400.0,
                child: Center(child: CircularProgressIndicator()));
          }
        });
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 16.0),
            child: Text(
              "Popular",
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          SizedBox(height: 8.0,),
          StreamBuilder(
              stream: _moviesProvider.popularStream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  return HorizontalList(
                    movies: snapshot.data,
                    loadMore: _moviesProvider.getPopular,
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ],
      ),
    );
  }
}
