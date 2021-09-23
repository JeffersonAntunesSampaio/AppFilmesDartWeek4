import 'package:app_filmes/services/login/login_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static const NAVIGATOR_KEY = 1;
  static const INDEX_PAGE_EXIT = 2;

  final _pages = ["/movies", "/favorites"];

  final LoginService _loginServices;
  final _pageIndex = 0.obs;

  HomeController({required LoginService loginService})
      : _loginServices = loginService;

  int get pageIndex => _pageIndex.value;

  void goToPage(int page) async {
    _pageIndex.value = page;

    if (page == INDEX_PAGE_EXIT) {
      await _loginServices.logout();
    } else {
      Get.offNamed(_pages[page], id: NAVIGATOR_KEY);
    }
  }
}
