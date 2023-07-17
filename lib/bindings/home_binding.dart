import 'package:get/get.dart';

import 'package:contact_app/data/providers/storage.dart';
import 'package:contact_app/controller/home_controller.dart';
import 'package:contact_app/data/repository/contact_repository.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeController(
      contactRepository: ContactRepository(storageClient: StorageClient()),
    ));
  }
}
