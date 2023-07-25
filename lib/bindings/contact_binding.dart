import 'package:get/get.dart';

import 'package:contact_app/adapters/storage_adapter.dart';
import 'package:contact_app/external/datasource/storage.dart';
import 'package:contact_app/presenter/contact/contact_controller.dart';

import 'package:contact_app/infra/repository/init_storage_repository.dart';
import 'package:contact_app/infra/repository/delete_contact_repository.dart';
import 'package:contact_app/infra/repository/edit_contact_repository.dart';
import 'package:contact_app/infra/repository/get_single_contact_repository.dart';

import 'package:contact_app/domain/usecase/edit_contact_use_case.dart';
import 'package:contact_app/domain/usecase/init_storage_use_case.dart';
import 'package:contact_app/domain/usecase/delete_contact_use_case.dart';
import 'package:contact_app/domain/usecase/get_single_contact_use_case.dart';

class ContactBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StorageAdapter());
    Get.put(ContactController(
      initStorageUseCase: InitStorageUseCase(InitStorageRepository(
          storageClient:
              StorageClient(storageAdapter: Get.find<StorageAdapter>()))),
      getSingleContactUseCases: GetSingleContactUseCase(
          GetSingleContactRepository(
              storageClient:
                  StorageClient(storageAdapter: Get.find<StorageAdapter>()))),
      editContactUseCases: EditContactUseCase(EditContactRepository(
          storageClient:
              StorageClient(storageAdapter: Get.find<StorageAdapter>()))),
      deleteContactUseCases: DeleteContactUseCase(DeleteContactRepository(
          storageClient:
              StorageClient(storageAdapter: Get.find<StorageAdapter>()))),
    ));
  }
}
