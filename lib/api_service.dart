import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/movie_ model.dart';

class ApiService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ✅ Fetch all movies from Firestore
  Future<List<Movie>> fetchAllMovies() async {
    final snapshot = await _db.collection('movielist').get();
    return snapshot.docs.map((doc) => Movie.fromJson(doc.data())).toList();
  }

  // ✅ Filter movies by genre (Firestore query)
  Future<List<Movie>> fetchMoviesByGenre(String genre) async {
    final snapshot = await _db
        .collection('movielist')
        .where('genre', isEqualTo: genre)
        .get();

    return snapshot.docs.map((doc) => Movie.fromJson(doc.data())).toList();
  }

  // ✅ Search movies by title (Firestore query with contains-like filter)
  Future<List<Movie>> searchMovies(String query) async {
    final snapshot = await _db
        .collection('movielist')
        .where('movieTitle', isGreaterThanOrEqualTo: query)
        .where('movieTitle', isLessThanOrEqualTo: query + '\uf8ff')
        .get();

    return snapshot.docs.map((doc) => Movie.fromJson(doc.data())).toList();
  }

  // ✅ Get movie by ID
  Future<Movie?> fetchMovieById(int id) async {
    final snapshot = await _db
        .collection('movielist')
        .where('id', isEqualTo: id)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return Movie.fromJson(snapshot.docs.first.data());
    }
    return null;
  }
}