// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
import 'package:myapp/app/modules/data/bindings/data_binding.dart';
import 'package:myapp/app/modules/data/views/data_view.dart';
import 'package:myapp/app/modules/login/bindings/login_binding.dart';
import '../modules/login/login_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();
  static const INITIAL = Routes.LOGIN;

  static final routes = [
     GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.DATA,
      page: () => DataView(),
      binding: DataBinding(),
    ),
  ];
}

