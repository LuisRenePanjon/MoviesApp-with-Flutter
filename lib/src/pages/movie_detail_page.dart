import 'package:flutter/material.dart';
import 'package:peliculas/src/models/actors_model.dart';
import 'package:peliculas/src/models/movie_model.dart';
import 'package:peliculas/src/providers/movies_provider.dart';

class MovieDetailPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _createAppBar( movie ),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                SizedBox( height: 10.0, ),
                _moviePoster(context, movie ),
                _movieDescription(movie),
                _movieDescription(movie),
                _movieDescription(movie),
                _movieDescription(movie),
                _movieDescription(movie),
                _movieDescription(movie),
                _movieDescription(movie),
                _createCasting(movie),

              ]
              ),
          ),
        ],
      ),
    );
  }

  Widget _createAppBar(Movie movie) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.orange[300],
      expandedHeight: 200.0 ,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          movie.title, 
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          image: NetworkImage( movie.getBackgroundImg() ),
          placeholder: AssetImage( 'assets/img/loading.gif' ),
          // fadeInDuration: Duration( seconds: 1 ),
          fit: BoxFit.cover,
        ),
      )   
    );
  }

  Widget _moviePoster(BuildContext context, Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal:  20.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: movie.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular( 20.0 ),
              child: Image(
                image: NetworkImage( movie.getPosterImg() ),
                height: 150.0 ,
              ),
            ),
          ),
          SizedBox( width: 20.0, ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text( movie.title , style: Theme.of(context).textTheme.headline6, overflow: TextOverflow.ellipsis,),
                Text( movie.originalTitle, style: Theme.of(context).textTheme.subtitle1, overflow: TextOverflow.ellipsis, ),
                Row(
                  children: <Widget>[
                    Icon( Icons.star_border ),
                    Text( movie.voteAverage.toString(),  style: Theme.of(context).textTheme.subtitle1),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _movieDescription(Movie movie) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Text( 
        movie.overview, 
        textAlign: TextAlign.justify,
      )
      );
  }

  Widget _createCasting(Movie movie) {
    final movieProvider = new MoviesProvider();
    movieProvider.getCast(movie.id.toString());
    return FutureBuilder(
      future: movieProvider.getCast(movie.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot){
        if ( snapshot.hasData ){
          return _createActorsPageView( snapshot.data );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }
    );
  }

  Widget _createActorsPageView(List<Actor> actors) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1
        ),
        itemBuilder: (context, item) => _actorTarget(actors[item]),
        itemCount: actors.length,
      ),
    );
  }

  Widget _actorTarget( Actor actor ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue
      ),
      child: Column(
        children: <Widget> [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(actor.getProfilePicture()),
              placeholder: AssetImage( 'assets/img/no-image.jpg' ),
              height: 140.0,
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