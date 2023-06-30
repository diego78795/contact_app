import 'package:get/get.dart';
import 'package:contact_app/ui/home_page.dart';

part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.home,
      page: () => const HomePage(),
    )
  ];
}
