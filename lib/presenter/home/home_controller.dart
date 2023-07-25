import 'package:get/get.dart';
import 'package:flutter/foundation.dart';

import 'package:contact_app/adapters/image_adapter.dart';
import 'package:contact_app/domain/entity/contact_entity.dart';

import 'package:contact_app/domain/usecase/add_contact_use_case.dart';
import 'package:contact_app/domain/usecase/init_storage_use_case.dart';
import 'package:contact_app/domain/usecase/get_contacts_use_case.dart';

class HomeController extends GetxController {
  final InitStorageUseCase? initStorageUseCase;
  final GetContactsUseCase? getContactsUseCase;
  final AddContactUseCase? addContactUseCase;

  HomeController({
    @required this.initStorageUseCase,
    @required this.getContactsUseCase,
    @required this.addContactUseCase,
  }) : assert(
          initStorageUseCase != null,
          addContactUseCase != null,
        );

  bool isLoading = true;
  List<ContactEntity> contactList = [];

  final _gender = ''.obs;
  get gender => _gender.value;
  set gender(value) => _gender.value = value;

  final _birthdate = DateTime(0).obs;
  get birthdate => _birthdate.value;
  set birthdate(value) => _birthdate.value = value;

  final _image = ImageAdapter('').obs;
  get image => _image.value;
  set image(value) => _image.value = value;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  fetchData() async {
    await initStorage();
    await getContacts();
    isLoading = false;
    update();
  }

  Future<void> initStorage() async {
    await initStorageUseCase!.initStorage();
  }

  Future<void> getContacts() async {
    contactList = [];
    contactList = await getContactsUseCase!.getContacts();
  }

  Future<void> addContact(ContactEntity contact) async {
    isLoading = true;
    update();
    await addContactUseCase!.addContact(contact);

    contactList.add(contact);
    isLoading = false;
    update();
  }
}
