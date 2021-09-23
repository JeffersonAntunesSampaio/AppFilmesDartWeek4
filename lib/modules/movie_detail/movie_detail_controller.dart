import 'package:app_filmes/application/ui/loader/loader_mixin.dart';
import 'package:app_filmes/application/ui/messages/messages_mixin.dart';
import 'package:app_filmes/models/movie_detail_model.dart';
import 'package:app_filmes/services/movies/movies_services.dart';
import 'package:get/get.dart';

class MovieDetailController extends GetxController
    with LoaderMixin, MessagesMixin {

  final MoviesServices _moviesServices;
  var loading = false.obs;
  var message = Rxn<MessageModule>();
  var movie = Rxn<MovieDetailModel>();

  MovieDetailController({
    required MoviesServices moviesServices,
  }) : _moviesServices = moviesServices;

  
  @override
  void onInit() {
    super.onInit();
    loaderListener(loading);
    messageListener(message);
  }

  @override
  void onReady() async {
    super.onReady();
    
    try {

      final movieId = Get.arguments;
      loading.value = true;

      final movieDetailData = await _moviesServices.getDetail(movieId);
      movie.value = movieDetailData;

      loading.value = false;
    } catch (e,s){
      loading.value = false;
      print(e);
      print(s);

      message.value = MessageModule.error(title: "Erro API", message: "Erro ao buscar detalhes do filme");

    }

  }

}
