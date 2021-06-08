import 'package:flutter/material.dart';
import 'package:peliculas/src/models/movie_model.dart';
import 'package:peliculas/src/providers/movies_provider.dart';

class DataSearch extends SearchDelegate{
  final moviesProvider = new MoviesProvider();

  final recentMovies= [
    
  ];
  
  @override
  List<Widget> buildActions(BuildContext context) {
      //Las acciones del appBar
      return[
        IconButton(
          icon: Icon( Icons.clear ), 
          onPressed: () {
            query = '';
          },
        ),
      ];
    }
  
    @override
    Widget buildLeading(BuildContext context) {
      // Icono a la izquierda
      return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: (){
          close( context, null );
        }
      );
    }
  
    @override
    Widget buildResults(BuildContext context) {
      // Crea los resultados a mostrar
      return Container();
    }
  
    @override
    Widget buildSuggestions(BuildContext context) {
    // Sugerencias que aparece en el transcurso de la escritura
    if ( query.isEmpty ) {
      return Container();
    } 

    return FutureBuilder(
      future: moviesProvider.searchMovie( query ),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot){
        if( snapshot.hasData ){
          return ListView(
            children: snapshot.data.map((movie) {
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(movie.getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  width: 50.0,
                  fit: BoxFit.contain
                ),
                title: Text( movie.title ),
                subtitle: Text( movie.originalTitle ),
                onTap: (){
                  close(context, null);
                  movie.uniqueId = '';
                  Navigator.pushNamed(context, 'movieDetail', arguments: movie);
                },
              );
            }).toList(),
          );
        }  else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }
      );
  }

}