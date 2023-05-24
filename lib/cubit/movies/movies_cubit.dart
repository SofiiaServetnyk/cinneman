import 'package:bloc/bloc.dart';
import 'package:cinneman/cubit/user/user_cubit.dart';
import 'package:cinneman/data/models/movie.dart';
import 'package:cinneman/data/models/movie_session_models.dart';
import 'package:cinneman/services/movies_service.dart';


part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final UserCubit userCubit;
  final MovieService movieService;

  MoviesCubit(this.userCubit)
      : movieService = MovieService(userCubit),
        super(const MoviesState(movies: {}));

  Future<void> loadMovies() async {
    var moviesList = await movieService.getMovies();
    Map<int, Movie> movies = {for (var movie in moviesList) movie.id: movie};

    emit(MoviesState(
        movies: movies,
        movieSession: state.movieSession,
        selectedSeats: state.selectedSeats));
  }

  Future<void> selectSession(MovieSession session) async {
    emit(MoviesState(
        movies: state.movies, movieSession: session, selectedSeats: {}));
  }



  Future<void> toggleSeat(Seat seat) async {
    Set<Seat>? seatsSet = state.selectedSeats;

    if (seatsSet == null) {
      seatsSet = {seat};
    } else if (seatsSet.contains(seat)) {
      seatsSet.remove(seat);
    } else {
      seatsSet.add(seat);
    }

    emit(MoviesState(
        movies: state.movies,
        movieSession: state.movieSession,
        selectedSeats: seatsSet));
  }

  Future<void> buyTickets({
    required List<Seat> seats,
    required MovieSession session,
    required String email,
    required String cardNumber,
    required String expirationDate,
    required String cvv,
  }) async {
    try {
      final success = await movieService.buyTickets(
        seats: seats,
        session: session,
        email: email,
        cardNumber: cardNumber,
        expirationDate: expirationDate,
        cvv: cvv,
      );

      if (success) {
        emit(SuccessfulPaymentMovieState(
          movies: state.movies,
          movieSession: state.movieSession,
          selectedSeats: state.selectedSeats,
        ));
      } else {
        throw MoviesServiceException("Error buying tickets.");
      }
    } catch (e) {
      throw MoviesServiceException("Error buying tickets.");
    }
  }
}
