import 'package:get/get.dart';

import 'package:contact_app/external/datasource/storage.dart';
import 'package:contact_app/presenter/contact/contact_controller.dart';
import 'package:contact_app/infra/repository/contact_repository.dart';

import 'package:contact_app/domain/usecase/contact_cases.dart';

class ContactBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ContactController(
      contactCases:
          ContactCases(ContactRepository(storageClient: StorageClient())),
    ));
  }
}
