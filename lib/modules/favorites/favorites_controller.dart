import 'package:app_filmes/application/auth/auth_service.dart';
import 'package:app_filmes/models/movie_model.dart';
import 'package:app_filmes/services/movies/movies_services.dart';
import 'package:get/get.dart';

class FavoritesController extends GetxController {
  final MoviesServices _moviesServices;
  final AuthService _authService;

  var movies = <MovieModel>[].obs;

  FavoritesController({
    required MoviesServices moviesServices,
    required AuthService authService,
  })  : _moviesServices = moviesServices,
        _authService = authService;

  @override
  void onReady() {
    super.onReady();
    _getFavorites();
  }

  Future<void> _getFavorites() async {
    var user = _authService.user;
    if (user != null) {
      var favorites = await _moviesServices.getFavoritesMovies(user.uid);
      movies.assignAll(favorites);
    }
  }

  Future<void> removeFavorite(MovieModel movie) async {
    var user = _authService.user;
    if (user != null) {
      await _moviesServices.addOrRemoveFavorite(
          user.uid, movie.copyWith(favorite: false));
      movies.remove(movie);
    }
  }
}
