import 'package:flutter/foundation.dart';
import '../models/movie_ model.dart';
import '../api_service.dart';

class MovieView extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Movie> actionMovies = [];
  List<Movie> comedyMovies = [];
  List<Movie> dramaMovies = [];
  List<Movie> romanceMovies = [];
  List<Movie> searchResults = [];

  bool isLoading = true;

  Future<void> fetchAllGenres() async {
    isLoading = true;
    notifyListeners();

    final allMovies = await _apiService.fetchAllMovies();

    actionMovies = allMovies.where((m) => m.genre.toLowerCase() == 'action').toList();
    comedyMovies = allMovies.where((m) => m.genre.toLowerCase() == 'comedy').toList();
    dramaMovies = allMovies.where((m) => m.genre.toLowerCase() == 'drama').toList();
    romanceMovies = allMovies.where((m) => m.genre.toLowerCase() == 'romance').toList();

    isLoading = false;
    notifyListeners();
  }

  Future<void> searchMovies(String query) async {
    if (query.isEmpty) {
      searchResults = [];
      notifyListeners();
      return;
    }

    final allMovies = await _apiService.searchMovies(query);
    searchResults = allMovies;
    notifyListeners();
  }
}