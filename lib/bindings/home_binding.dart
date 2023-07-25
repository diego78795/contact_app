import 'package:get/get.dart';

import 'package:contact_app/adapters/storage_adapter.dart';
import 'package:contact_app/external/datasource/storage.dart';
import 'package:contact_app/presenter/home/home_controller.dart';

import 'package:contact_app/infra/repository/add_contact_repository.dart';
import 'package:contact_app/infra/repository/get_contacts_repository.dart';
import 'package:contact_app/infra/repository/init_storage_repository.dart';

import 'package:contact_app/domain/usecase/add_contact_use_case.dart';
import 'package:contact_app/domain/usecase/init_storage_use_case.dart';
import 'package:contact_app/domain/usecase/get_contacts_use_case.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StorageAdapter());
    Get.put(HomeController(
      initStorageUseCase: InitStorageUseCase(InitStorageRepository(
          storageClient:
              StorageClient(storageAdapter: Get.find<StorageAdapter>()))),
      getContactsUseCase: GetContactsUseCase(GetContactsRepository(
          storageClient:
              StorageClient(storageAdapter: Get.find<StorageAdapter>()))),
      addContactUseCase: AddContactUseCase(AddContactRepository(
          storageClient:
              StorageClient(storageAdapter: Get.find<StorageAdapter>()))),
    ));
  }
}
