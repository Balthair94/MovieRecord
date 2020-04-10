import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:movie_record/src/models/movie_detail_argument.dart';
import 'package:movie_record/src/models/movie_model.dart';

class CardSwiperWidget extends StatelessWidget {
  final List<Movie> data;
  final String heroSubTag = "_nowPlaying";

  CardSwiperWidget({ @required this.data});

  @override
  Widget build(BuildContext context) {
    final Size _screenSize = MediaQuery.of(context).size;

    return Container(
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return _card(context, data[index]);
        },
        itemCount: data.length,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
        layout: SwiperLayout.STACK,
      ),
    );
  }

  Widget _card(BuildContext context, Movie movie) {
    Widget card = Hero(
      tag: "${movie.id}$heroSubTag",
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.0),
        child: FadeInImage(
          image: NetworkImage(movie.getPosterPath(),),
          placeholder: AssetImage('assets/jar-loading.gif'),
          fit: BoxFit.cover,
        ),
      ),
    );

    return GestureDetector(
      child: card,
      onTap: (){
        Navigator.pushNamed(
            context, 'detail',
            arguments: MovieDetailArgument(movie, heroSubTag)
        );
      },
    );
  }
}
