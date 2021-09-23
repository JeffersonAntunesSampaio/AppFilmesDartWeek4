import 'package:app_filmes/application/auth/auth_service.dart';
import 'package:app_filmes/application/ui/messages/messages_mixin.dart';
import 'package:app_filmes/models/genre_model.dart';
import 'package:app_filmes/models/movie_model.dart';
import 'package:app_filmes/services/genres/genres_services.dart';
import 'package:app_filmes/services/movies/movies_services.dart';
import 'package:get/get.dart';

class MoviesController extends GetxController with MessagesMixin {
  final GenresServices _genresServices;
  final MoviesServices _moviesServices;
  final AuthService _authService;

  final _message = Rxn<MessageModule>();
  final genres = <GenreModel>[].obs;

  final popularMovies = <MovieModel>[].obs;
  final topRatedMovies = <MovieModel>[].obs;

  var _popularMoviesOriginal = <MovieModel>[];
  var _topRatedMoviesOriginal = <MovieModel>[];

  final genreSelected = Rxn<GenreModel>();

  MoviesController({
    required GenresServices genresServices,
    required MoviesServices moviesServices,
    required AuthService authService,
  })  : _genresServices = genresServices,
        _moviesServices = moviesServices,
        _authService = authService;

  @override
  void onInit() {
    super.onInit();
    messageListener(_message);
  }

  @override
  void onReady() async {
    super.onReady();

    try {
      final genresData = await _genresServices.getGenres();
      genres.assignAll(genresData);

      await getMovies();

    } catch (e, s) {
      print(e);
      print(s);
      _message.value = MessageModule.error(
          title: "Erro API", message: "Erro aos carregar dados da página");
    }
    
  }

  Future<void> getMovies() async {
    try {

      final favoritesMoviesData = await getFavorites();
      var popularMoviesData = await _moviesServices.getPopularMovies();
      var topRatedMoviesData = await _moviesServices.getTopRated();

      popularMoviesData = popularMoviesData.map((m) {
        if(favoritesMoviesData.containsKey(m.id)){
          return m.copyWith(favorite: true);
        }else {
          return m.copyWith(favorite: false);
        }          
      }).toList();


      topRatedMoviesData = topRatedMoviesData.map((m) {
        if(favoritesMoviesData.containsKey(m.id)){
          return m.copyWith(favorite: true);
        }else {
          return m.copyWith(favorite: false);
        }          
      }).toList();

      popularMovies.assignAll(popularMoviesData);
      _popularMoviesOriginal = popularMoviesData;

      
      topRatedMovies.assignAll(topRatedMoviesData);
      _topRatedMoviesOriginal = topRatedMoviesData;

      

    } catch (e, s) {
      print(e);
      print(s);
      _message.value = MessageModule.error(
          title: "Erro API", message: "Erro aos carregar dados da página");
    }
  }

  void filterByName(String title) {
    if (title.isNotEmpty) {
      var newPopularMovies = _popularMoviesOriginal.where((movie) {
        return movie.title.toLowerCase().contains(title.toLowerCase());
      });

      var newTopRatedMovies = _topRatedMoviesOriginal.where((movie) {
        return movie.title.toLowerCase().contains(title.toLowerCase());
      });

      popularMovies.assignAll(newPopularMovies);
      topRatedMovies.assignAll(newTopRatedMovies);
    } else {
      popularMovies.assignAll(_popularMoviesOriginal);
      topRatedMovies.assignAll(_topRatedMoviesOriginal);
    }
  }

  void filtersMoviesByGenre(GenreModel? genreModel) {
    var genreFilter = genreModel;

    if (genreFilter?.id == genreSelected.value?.id) {
      genreFilter = null;
    }

    genreSelected.value = genreFilter;

    if (genreFilter != null) {
      var newPopularMovies = _popularMoviesOriginal.where((movie) {
        return movie.genres.contains(genreFilter?.id);
      });

      var newTopRatedMovies = _topRatedMoviesOriginal.where((movie) {
        return movie.genres.contains(genreFilter?.id);
      });

      popularMovies.assignAll(newPopularMovies);
      topRatedMovies.assignAll(newTopRatedMovies);
    } else {
      popularMovies.assignAll(_popularMoviesOriginal);
      topRatedMovies.assignAll(_topRatedMoviesOriginal);
    }
  }

  Future<void> favoriteMovies(MovieModel movie) async {
    final user = _authService.user;

    if(user != null){
      var newMovie = movie.copyWith(favorite: !movie.favorite);
      await _moviesServices.addOrRemoveFavorite(user.uid, newMovie);
      await getMovies();
    }
  }

  Future<Map<int, MovieModel>> getFavorites() async {
    var user = _authService.user;
    if(user != null) {
      final favorites = await _moviesServices.getFavoritesMovies(user.uid);
      return <int, MovieModel>{
        for(var fav in favorites) fav.id: fav,
      };
    }
    return {};

  }


}
