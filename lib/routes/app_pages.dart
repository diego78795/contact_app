import 'package:get/get.dart';
import 'package:contact_app/ui/home/home_page.dart';
import 'package:contact_app/bindings/home_binding.dart';

import 'package:contact_app/ui/home/contact_page.dart';
import 'package:contact_app/bindings/contact_binding.dart';

part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
        name: Routes.home,
        page: () => const HomePage(),
        binding: HomeBinding()),
    GetPage(
        name: Routes.contact,
        page: () => const ContactPage(),
        binding: ContactBinding())
  ];
}
