import 'package:app_filmes/models/genre_model.dart';
import 'package:app_filmes/repositories/genres/genres_repository.dart';
import 'package:flutter/cupertino.dart';

abstract class GenresServices {

  Future<List<GenreModel>> getGenres();
}
