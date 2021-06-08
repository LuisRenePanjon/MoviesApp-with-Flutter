import 'package:flutter/material.dart';
 
import 'package:peliculas/src/pages/home_page.dart';
import 'package:peliculas/src/pages/movie_detail_page.dart';
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies',
      initialRoute: '/',
      routes : {
        '/'           : ( BuildContext context ) => HomePage(),
        'movieDetail' : ( BuildContext context ) => MovieDetailPage(),
      }
    );
  }
}