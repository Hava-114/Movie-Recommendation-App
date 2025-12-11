class Movie {
  final int id;
  final String name;
  final String genre;
  final double rating;
  final String review;
  final String reviewerName;
  final String reviewDate;
  final bool spoilerAlert;
  final String recommendation;
  final String movieTitle;
  final String posterUrl;
  final String shortStory;

  Movie({
    required this.id,
    required this.name,
    required this.genre,
    required this.rating,
    required this.review,
    required this.reviewerName,
    required this.reviewDate,
    required this.spoilerAlert,
    required this.recommendation,
    required this.movieTitle,
    required this.posterUrl,
    required this.shortStory,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      name: json['name'],
      genre: json['genre'],
      rating: (json['rating'] as num).toDouble(),
      review: json['review'],
      reviewerName: json['reviewer_name'],
      reviewDate: json['review_date'],
      spoilerAlert: json['spoiler_alert'],
      recommendation: json['recommendation'],
      movieTitle: json['movie_title'],
      posterUrl: json['poster_url'],
      shortStory: json['short_story'],
    );
  }
}