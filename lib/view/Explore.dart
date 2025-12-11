import 'package:flutter/material.dart';
import 'package:movie_app/widgets/mainscaff.dart';
import 'package:provider/provider.dart';
import '../view_models/home_view.dart';
import 'Specific_movie.dart';

class ExplorePage extends StatefulWidget {
  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  String search = '';
  String selectedGenre = 'Action';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MovieView>(context, listen: false)
          .fetchMovieByGenre(selectedGenre);
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<MovieView>(context);
    final movies = vm.chosenMovies;

    // GRID AUTO SIZE
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = 150.0;
    final crossAxisCount = (screenWidth / itemWidth).floor().clamp(2, 6);

    return MainScaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // SEARCH BAR
            TextField(
              decoration: InputDecoration(
                hintText: 'Search movies...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onChanged: (value) {
                search = value;
                if (value.isNotEmpty) {
                  vm.searchMovies(value);
                } else {
                  vm.fetchMovieByGenre(selectedGenre);
                }
              },
            ),

            const SizedBox(height: 20),

            // GENRE ROW
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildGenre("Action"),
                buildGenre("Drama"),
                buildGenre("Comedy"),
                buildGenre("Romance"),
              ],
            ),

            const SizedBox(height: 25),

            Text(
              search.isNotEmpty
                  ? "Search Results"
                  : "$selectedGenre Movies",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            // MOVIE GRID
            Expanded(
              child: vm.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : GridView.builder(
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
                    child:Container(
  width: 140,
  height: 220,  // box size reduced
  margin: const EdgeInsets.symmetric(horizontal: 8), // more gap between boxes
  padding: const EdgeInsets.all(10),
  decoration: BoxDecoration(
    color: Colors.purple.withOpacity(0.25),
    borderRadius: BorderRadius.circular(20.0),
  ),
  child: Column(
                      children: [
                        Center(
        child: Image.asset(
          movie.posterUrl,
          width: 150,
          height: 190,
          fit: BoxFit.cover,
        ),
      ),

      const SizedBox(height: 10),

      Text(
        movie.movieTitle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),

      const SizedBox(height: 5),

      Text(
        'IMDb: ${movie.rating}',
        style: const TextStyle(fontSize: 11),
      ),

      const SizedBox(height: 1),

      Text(
        'Genre: ${movie.genre}',
        style: const TextStyle(fontSize: 11),
      ),
    
                      ],
                    ),
                  ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // GENRE BOX
  Widget buildGenre(String genre) {
    bool isSelected = selectedGenre == genre;

    return GestureDetector(
      onTap: () {
        setState(() => selectedGenre = genre);

        Provider.of<MovieView>(context, listen: false)
            .fetchMovieByGenre(genre);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
        decoration: BoxDecoration(
          color: isSelected ? Colors.purple : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
              color: isSelected ? Colors.purple : Colors.grey.shade400),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Text(
          genre,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
