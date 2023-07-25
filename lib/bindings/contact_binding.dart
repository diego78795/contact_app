import 'package:get/get.dart';

import 'package:contact_app/data/providers/storage.dart';
import 'package:contact_app/controller/contact_controller.dart';
import 'package:contact_app/data/repository/contact_repository.dart';

class ContactBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ContactController(
      contactRepository: ContactRepository(storageClient: StorageClient()),
    ));
  }
}
