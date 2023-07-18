import 'package:contact_app/domain/usecase/contact_cases.dart';
import 'package:get/get.dart';

import 'package:contact_app/presenter/home/home_controller.dart';
import 'package:contact_app/external/datasource/storage.dart';
import 'package:contact_app/infra/repository/contact_repository.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeController(
      contactCases:
          ContactCases(ContactRepository(storageClient: StorageClient())),
    ));
  }
}
