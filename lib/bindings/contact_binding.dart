import 'package:get/get.dart';

import 'package:contact_app/controller/contact_controller.dart';

class ContactBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContactController>(() => ContactController());
  }
}
