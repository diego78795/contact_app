import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:contact_app/controller/contact_controller.dart';

class ContactPage extends GetView<ContactController> {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<ContactController>(builder: (_) {
      return SafeArea(
        child: Container(),
      );
    }));
  }
}
