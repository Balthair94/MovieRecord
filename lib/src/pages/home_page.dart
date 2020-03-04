import 'package:flutter/material.dart';
import 'package:movie_record/src/models/movie_model.dart';
import 'package:movie_record/src/providers/movies_provider.dart';
import 'package:movie_record/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {
  final MoviesProvider _moviesProvider = MoviesProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies in teathers'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => {},
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          _swiperCards(),
        ],
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
}
