import 'package:app_filmes/application/ui/filmes_app_icons.dart';
import 'package:app_filmes/application/ui/theme_extensions.dart';
import 'package:app_filmes/models/movie_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

class MovieCard extends StatelessWidget {
  final dateFormat = DateFormat('y');
  final MovieModel movie;
  final VoidCallback favoriteCallback;

  MovieCard({Key? key, required this.movie, required this.favoriteCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(
          "/movie/detail",
          arguments: movie.id,
        );
      },
      child: Container(
        //padding: EdgeInsets.all(8),
        width: 148,
        height: 280,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      clipBehavior: Clip.antiAlias,
                      child: FadeInImage.memoryNetwork(   
                        width: 148,
                        height: 184,
                        fit: BoxFit.cover,
                        placeholder: kTransparentImage,
                        image: "https://image.tmdb.org/t/p/w200${movie.posterPath}",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    movie.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    dateFormat.format(DateTime.parse(movie.releaseDate)),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 75,
              right: 2,
              child: Material(
                elevation: 5,
                shape: CircleBorder(),
                clipBehavior: Clip.antiAlias,
                child: SizedBox(
                  height: 30,
                  child: IconButton(
                    iconSize: 13,
                    color: movie.favorite ? context.themeRed : Colors.grey,
                    icon: Icon(
                      movie.favorite
                          ? FilmesAppIcons.heart
                          : FilmesAppIcons.heart_empty,
                    ),
                    onPressed: favoriteCallback,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
