import 'package:app_filmes/application/ui/loader/loader_mixin.dart';
import 'package:app_filmes/application/ui/messages/messages_mixin.dart';
import 'package:app_filmes/services/login/login_service.dart';
import 'package:get/get.dart';

class LoginController extends GetxController with LoaderMixin, MessagesMixin {
  final LoginService _loginService;
  final loading = false.obs;
  final message = Rxn<MessageModule>();

  LoginController({required LoginService loginService})
      : _loginService = loginService;

  @override
  void onInit() {
    super.onInit();
    loaderListener(loading);
    messageListener(message);
  }

  Future<void> login() async {
    try{

      loading.value = true;

      await _loginService.login();

      loading.value = false;

      message(
          MessageModule.info(title: "Sucesso", message: "Sucesso ao efetuar login com Google!"));

    }catch(e,s){
      loading.value = false;
      print(e);
      print(s);
      message(
          MessageModule.error(title: "Login Error", message: "Erro ao realizar login!"));
    }
  }
}
