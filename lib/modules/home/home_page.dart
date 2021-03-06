import 'package:app_filmes/modules/favorites/favorites_bindings.dart';
import 'package:app_filmes/modules/favorites/favorites_page.dart';
import 'package:app_filmes/modules/home/home_controller.dart';
import 'package:app_filmes/modules/movies/movies_bindings.dart';
import 'package:app_filmes/modules/movies/movies_page.dart';
import 'package:flutter/material.dart';
import 'package:app_filmes/application/ui/filmes_app_icons.dart';
import 'package:app_filmes/application/ui/theme_extensions.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          selectedItemColor: context.themeRed,
          unselectedItemColor: Colors.grey,
          onTap: controller.goToPage,
          currentIndex: controller.pageIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.movie), label: "Filmes"),
            BottomNavigationBarItem(
                icon: Icon(FilmesAppIcons.heart_empty), label: "Favoritos"),
            BottomNavigationBarItem(
                icon: Icon(Icons.logout_outlined), label: "Sair"),
          ],
        );
      }),
      body: Navigator(
        initialRoute: "/movies",
        key: Get.nestedKey(HomeController.NAVIGATOR_KEY),
        onGenerateRoute: (setting) {
          if (setting.name == "/movies") {
            return GetPageRoute(
              settings: setting,
              page: () => MoviesPage(),
              binding: MoviesBindings(),
            );
          }

          if (setting.name == "/favorites") {
            return GetPageRoute(
              settings: setting,
              page: () => FavoritesPage(),
              binding: FavoritesBindings(),
            );
          }

          return null;
        },
      ),
    );
  }
}
