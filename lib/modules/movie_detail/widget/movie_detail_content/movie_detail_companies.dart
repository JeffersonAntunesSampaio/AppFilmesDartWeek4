import 'package:app_filmes/models/movie_detail_model.dart';
import 'package:flutter/material.dart';

class MovieDetailCompanies extends StatelessWidget {
  final MovieDetailModel? movie;
  const MovieDetailCompanies({Key? key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(bottom: 5),
      child: RichText(
        text: TextSpan(
            text: "Compania(s) produtora(s): ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF222222),
            ),
            children: [
              TextSpan(
                text: movie?.productionCompanies.join(", ") ?? "",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF222222),
                ),
              ),
            ]),
      ),
    );
  }
}
