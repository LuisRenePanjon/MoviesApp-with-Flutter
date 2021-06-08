import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/movies_provider.dart';
import 'package:peliculas/src/search/search_delegate.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {

  final moviesProvider = new MoviesProvider();

  @override
  Widget build(BuildContext context) {
    moviesProvider.getPopularMovies();
    return Scaffold(
      appBar: AppBar(
        title: Text('Billboard'),
        centerTitle: false,
        backgroundColor: Colors.lightBlue,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              showSearch(
                context: context, 
                delegate: DataSearch(),
                // query: 'Hola'  
              );
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperTarget(),
            _footer(context)
          ],
        ),
      ),
    );
  }

  _swiperTarget() {
    return FutureBuilder(
      future: moviesProvider.getInCinema(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if ( snapshot.hasData ){
          return CardSwiper(movies: snapshot.data);
        }else {
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container (
      width: double.infinity,
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:<Widget>[
          Container(
            padding: EdgeInsets.only( left:20.0 ),
            child: Text( 'Popular', style: Theme.of(context).textTheme.subtitle1 ),
          ),
          SizedBox( height: 10.0 ),
          StreamBuilder(
            stream: moviesProvider.popularStream,
            builder: ( BuildContext context, AsyncSnapshot<List> snapshot ){
              // moviesProvider.getPopularMovies();
              if( snapshot.hasData ){
                return MovieHorizontal( 
                  movies: snapshot.data, 
                  nextPage: moviesProvider.getPopularMovies 
                );
              } else {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
        ]
      ),
    );
  }
}