import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:peliculas/src/models/movie_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;
  
  CardSwiper({@required this.movies });
  @override
  Widget build(BuildContext context) {
    
    final _screenSize = MediaQuery.of(context).size;


    return Container(
      padding: EdgeInsets.only(top: 20.0),
      
      child: Swiper(
          itemBuilder: (BuildContext context,int index){
            movies[index].uniqueId = '${ movies[index].id } - card swiper';
            return Hero(
              tag: movies[index].uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, 'movieDetail', arguments: movies[index]);
                  },
                  child: FadeInImage(
                    image: NetworkImage( movies[index].getPosterImg()),
                    placeholder: AssetImage( 'assets/img/no-image.jpg' ) ,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ); 
            
            
          },
          itemCount: movies.length,
          // pagination: new SwiperPagination(),
          // control: new SwiperControl(),
          itemWidth: _screenSize.width * 0.7,
          itemHeight: _screenSize.height * 0.5,
          layout: SwiperLayout.STACK,
        ),
    );
  }
}