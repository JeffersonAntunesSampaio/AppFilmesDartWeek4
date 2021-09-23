import 'package:app_filmes/models/genre_model.dart';
import 'package:app_filmes/repositories/genres/genres_repository.dart';
import 'package:app_filmes/services/genres/genres_services.dart';

class GenresServicesImpl implements GenresServices {

  final GenresRepository _genresRepository;

  GenresServicesImpl({
    required GenresRepository genresRepository,
  }) : _genresRepository = genresRepository;

  @override
  Future<List<GenreModel>> getGenres() => _genresRepository.getGenres();

  
}