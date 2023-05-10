part of 'movies_cubit.dart';


class MoviesState {
  final Map<int, Movie> _movies;
  final MovieSession? _movieSession;
  final Set<Seat>? _selectedSeats;

  const MoviesState(
      {required Map<int, Movie> movies,
      MovieSession? movieSession,
      Set<Seat>? selectedSeats})
      : _movies = movies,
        _movieSession = movieSession,
        _selectedSeats = selectedSeats;


  Map<int, Movie> get movies => _movies;
  MovieSession? get movieSession => _movieSession;
  Set<Seat>? get selectedSeats => _selectedSeats;
}

class SuccessfulPaymentMovieState extends MoviesState {
  SuccessfulPaymentMovieState({
    required Map<int, Movie> movies,
    required MovieSession? movieSession,
    required Set<Seat>? selectedSeats,
  }) : super(
          movies: movies,
          movieSession: movieSession,
          selectedSeats: selectedSeats,
        );
}
