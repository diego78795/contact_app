import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:contact_app/controller/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<HomeController>(builder: (_) {
      return const SafeArea(child: Center(child: Text("Home Page")));
    }));
  }
}
