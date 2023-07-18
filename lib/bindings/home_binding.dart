import 'package:get/get.dart';

import 'package:contact_app/presenter/home/home_controller.dart';
import 'package:contact_app/external/datasource/storage.dart';
import 'package:contact_app/infra/repository/contact_repository.dart';

import 'package:contact_app/domain/usecase/add_contact.dart';
import 'package:contact_app/domain/usecase/init_storage.dart';
import 'package:contact_app/domain/usecase/get_all_contacts.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeController(
      initStorageCase:
          InitStorage(ContactRepository(storageClient: StorageClient())),
      addContactCase:
          AddContact(ContactRepository(storageClient: StorageClient())),
      getAllContactsCase:
          GetAllContacts(ContactRepository(storageClient: StorageClient())),
    ));
  }
}
