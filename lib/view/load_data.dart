import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../api_service.dart';
import '../models/movie_ model.dart';
import '../view/movie.dart';

class AddData extends StatelessWidget {
  Future<void> addData(Movie movie) async {
    await FirebaseFirestore.instance.collection('movielist').add({
      'id': movie.id,
      'name': movie.name,
      'genre': movie.genre,
      'rating': movie.rating,
      'reviewerName': movie.reviewerName,
      'reviewDate': movie.reviewDate,
      'spoilerAlert': movie.spoilerAlert,
      'recommendation': movie.recommendation,
      'movieTitle': movie.movieTitle,
      'posterUrl': movie.posterUrl,
      'shortStory': movie.shortStory,
    });
  }

  ApiService _apiService= ApiService();
  List<Movie> _selectedMovie=[];
  List<Movie> get selectedMovie=>_selectedMovie;
  Future<void> fetchAllMovies() async{
    
    _selectedMovie = await _apiService.fetchAllMovies();
    print(_selectedMovie.length);
  }Future<void> fetchAndUploadMovies(BuildContext context) async {
    final movies = await _apiService.fetchAllMovies();
    print("Fetched ${movies.length} movies");

    for (var movie in movies) {
      await addData(movie);
      print("Added movie: ${movie.id}");
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => Home()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              await fetchAndUploadMovies(context);
            },
            child: const Text('Add'),
          ),
        ),
      ),
    );
  }
}