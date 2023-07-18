import 'package:get/get.dart';

import 'package:contact_app/external/datasource/storage.dart';
import 'package:contact_app/presenter/contact/contact_controller.dart';
import 'package:contact_app/infra/repository/contact_repository.dart';

import 'package:contact_app/domain/usecase/edit_contact.dart';
import 'package:contact_app/domain/usecase/init_storage.dart';
import 'package:contact_app/domain/usecase/delete_contact.dart';
import 'package:contact_app/domain/usecase/get_single_contact.dart';

class ContactBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ContactController(
      initStorageCase:
          InitStorage(ContactRepository(storageClient: StorageClient())),
      getSingleContactCase:
          GetSingleContact(ContactRepository(storageClient: StorageClient())),
      editContactCase:
          EditContact(ContactRepository(storageClient: StorageClient())),
      deleteContactCase:
          DeleteContact(ContactRepository(storageClient: StorageClient())),
    ));
  }
}
