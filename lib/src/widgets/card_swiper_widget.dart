import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiperWidget extends StatelessWidget {
  final List<dynamic> movies;

  CardSwiperWidget({this.movies});

  @override
  Widget build(BuildContext context) {
    final Size _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 16.0),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(24.0),
            child: Image.network(
              'https://i.picsum.photos/id/$index/500/300.jpg',
              fit: BoxFit.fill,
            ),
          );
        },
        itemCount: movies.length,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
        layout: SwiperLayout.STACK,
      ),
    );
  }
}
