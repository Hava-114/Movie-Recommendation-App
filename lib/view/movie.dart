import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/home_view.dart';
import '../models/movie_ model.dart';
import 'Specific_movie.dart';
import 'Genre.dart';
import '../widgets/mainscaff.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home> {
 String search='';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = Provider.of<MovieView>(context, listen: false);
      vm.fetchAllGenres();
      vm.searchMovies(search);
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<MovieView>(context);
FirebaseFirestore.instance.collection('movielist').get().then((snapshot) {
  for (var doc in snapshot.docs) {
    print(doc.data());
  }
});

    return MainScaffold(
      body: Stack(
        children: [
          /// ---------------------------------------------------
          ///  TOP POSTER BANNER   (0.35 height)
          /// ---------------------------------------------------
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            child: PageView(
              children: [
                Image.asset('assets/poster3.png', fit: BoxFit.cover),
                Image.asset('assets/poster2.png', fit: BoxFit.cover),
                Image.asset('assets/poster1.png', fit: BoxFit.cover),
              ],
            ),
          ),

          /// ---------------------------------------------------
          /// DRAGGABLE SHEET (touching the poster → NO GAP)
          /// ---------------------------------------------------
          DraggableScrollableSheet(
            initialChildSize: 0.65,     // exactly 1 - poster height
            minChildSize: 0.65,
            maxChildSize: 1.0,
            snap: true,
            snapSizes: const [0.65, 1.0],

            builder: (context, scrollController) {
              return Container(

                decoration: const BoxDecoration(
                    color:Colors.black,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),

                child: ListView(
                  controller: scrollController,
                  padding: EdgeInsets.zero,
                  children: [
                    // Drag handle
                    const SizedBox(height: 8),
                    Center(
                      child: Container(
                        width: 50,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Search Bar
                    

                    // Movie sections
                    vm.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : Column(
                            children: [
                              if (search.isNotEmpty)
                                _buildGenreSection('Search Results', vm.searchResults),
                              _buildGenreSection('Action', vm.actionMovies),
                              _buildGenreSection('Comedy', vm.comedyMovies),
                              _buildGenreSection('Drama', vm.dramaMovies),
                              _buildGenreSection('Romance', vm.romanceMovies),
                            ],
                          ),

                    const SizedBox(height: 50),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  /// ---------------------------------------------------
  /// GENRE SECTION BUILDER
  /// ---------------------------------------------------
  Widget _buildGenreSection(String genre, List<Movie> movies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => GenreMovies(genre)),
              );
            },
            child: Text(
              genre,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),

        const SizedBox(height: 8),

        SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => Specific_movie(movie.id)),
                ),child: Container(
  width: 140,  // box size reduced
  margin: const EdgeInsets.symmetric(horizontal: 12), // more gap between boxes
  padding: const EdgeInsets.all(10),
  decoration: BoxDecoration(
    color: Colors.purple.withOpacity(0.25),
    borderRadius: BorderRadius.circular(20.0),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start, // TEXTS aligned to left
    children: [
      Center(
        child: Image.asset(
          movie.posterUrl,
          width: 120,
          height: 170,
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
        'Release: ${movie.reviewDate}',   // add your variable
        style: const TextStyle(fontSize: 11),
      ),

      const SizedBox(height: 1),

      Text(
        'Genre: ${movie.genre}',
        style: const TextStyle(fontSize: 11),
      ),
    ],
  ),
),

              );
            },
          ),
        ),

        const SizedBox(height: 8),
      ],
    );
  }
}
