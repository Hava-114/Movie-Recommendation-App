import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../view_models/home_view.dart';
import 'Specific_movie.dart';

class GenreMovies extends StatefulWidget {
  final String genre;

  const GenreMovies(this.genre, {super.key});

  @override
  _GenreMoviesState createState() => _GenreMoviesState();
}

class _GenreMoviesState extends State<GenreMovies> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MovieView>(context, listen: false)
          .fetchMovieByGenre(widget.genre);
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<MovieView>(context);
    final movies = vm.chosenMovies;
   
    // Use MediaQuery to calculate crossAxisCount
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = 150.0; // approximate width per item
    final crossAxisCount = (screenWidth / itemWidth).floor().clamp(2, 6);

    return
        Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: movies.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 20,
            mainAxisSpacing: 30,
            childAspectRatio: 0.6,
          ),
          itemBuilder: (context, index) {
            final movie = movies[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Specific_movie(movie.id),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 200,
                    child: Image.asset(
                      movie.posterUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    movie.movieTitle,
                    style: const TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                ],
              ),
            );
          },
        ),
        );
   
  }
}