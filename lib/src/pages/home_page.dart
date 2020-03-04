import 'package:flutter/material.dart';
import 'package:movie_record/src/providers/movies_provider.dart';
import 'package:movie_record/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {
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
    final test = MoviesProvider();
    test.getNowPlaying();
    return CardSwiperWidget(
      movies: [1,2,3,4,5],
    );
  }
}
